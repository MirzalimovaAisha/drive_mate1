import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final String baseUrl = "http://api.db.pe.kr:51092/api";

class AuthServer{

  Future<Map<String, dynamic>> login(String mberId, String mberPassword)async{
    final url = Uri.parse('$baseUrl/authenticate/signin');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'mberId': mberId,
        'mberPassword': mberPassword
      }
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final token = data['tkn'];

      if (token != null && token is String && token.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
      }
      print('로그인 코드: $data');
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('access_token', token);

      return data;
    }else{
      print('로그인 실패');
      return{
        'success': false,
      };
    }
  }
}


class CarPostServer {
  Future<Map<String, dynamic>> registerCar(String carName, String carNumber,  String imagePath) async {
    final url = Uri.parse('$baseUrl/car');

    // 저장된 토큰 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      print('토큰이 없습니다. 로그인이 필요합니다.');
      return {'success': false, 'message': '토큰 없음'};
    }
    // 🚗 **이미지 파일 추가**

    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Content-Type'] = 'multipart/form-data'
      ..fields['carNm'] = carName
      ..fields['carNo'] = carNumber;

    if (imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody);
      print('자동차 등록 응답: $data');
      return data;
    } else {
      print('자동차 등록 실패: $responseBody');
      return {'success': false};
    }
  }
}


















