import 'dart:io';

import 'package:drive_mate_practice1/server/server.dart';
import 'package:drive_mate_practice1/widgets/color.dart';
import 'package:drive_mate_practice1/widgets/red_button_widget.dart';
import 'package:drive_mate_practice1/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarSelectionScreen extends StatefulWidget {
  const CarSelectionScreen({super.key});

  @override
  State<CarSelectionScreen> createState() => _CarSelectionScreenState();
}

class _CarSelectionScreenState extends State<CarSelectionScreen> {
  final TextEditingController _carNmController = TextEditingController();
  final TextEditingController _carNumController = TextEditingController();
  final CarPostServer _carPostServer = CarPostServer();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  String? carName;
  String? carImagePath;
  bool light = false;

  @override
  void initState() {
    super.initState();
    loadCarData();
  }


  Future<void> loadCarData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      carName = prefs.getString('carName') ?? '차량 이름 없음';
      carImagePath = prefs.getString('carImage');
    });
  }

  /// 데이터 저장하기
  Future<void> saveCarData(String carName, String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carName', carName);
    await prefs.setString('carImage', imagePath);
  }

  /// 차량 정보 저장
  void _handleCar() async {
    final carName = _carNmController.text.trim();
    final carNumber = _carNumController.text.trim();

    if (carName.isEmpty || carNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('차량 이름과 번호를 입력하세요.')),
      );
      return;
    }

    Map<String, dynamic> result = await _carPostServer.registerCar(carName, carNumber, _selectedImage!.path);

    if (result['success'] == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('car_name', carName);
      await prefs.setString('car_number', carNumber);
      if (_selectedImage != null) {
        await prefs.setString('car_image', _selectedImage!.path);
      }
      await saveCarData(carName, _selectedImage!.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('차량이 등록되었습니다!')),
      );
      Navigator.of(context).pushReplacementNamed('/car_selection');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('차량 등록 실패! 다시 시도해주세요.')),
      );
    }
  }

  /// 사진 선택 기능
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/cloud1.png'),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hub_outlined, color: brownColor,size: 50,),
                      SizedBox(width: 10,),
                      Text('Drive Mate', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,  color: Colors.white),),
                    ],
                  ),
                  SizedBox(height: 70,),

                  // ======== 선택한 차 이미지 ==============
                  // Image.asset('assets/images/cars/genesis-kr-gv80-facelift-color-glossy-vik-black-large.png'),
                  // Image.file(File(carImagePath!), height: 200,),
                  carImagePath != null ? Image.file(File(carImagePath!), height: 200,): Icon(Icons.image_not_supported_outlined),
                  SizedBox(height: 10,),
                  // ======== 차 이름 ===============
                  Text(carName ?? '이름 없음', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.6,
                        child: Switch(
                          value: light,
                          onChanged: (bool value){
                            setState(() {
                              light = value;
                            });
                          },
                          activeColor: brownColor,
                        ),
                      ),
                      Text('Remember', style: TextStyle(color: Colors.white, fontSize: 15),)
                    ],
                  ),
                  SizedBox(height: 30,),
                  RedButtonWidget(
                    onPressed: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('carSelected', true); // 차량 선택 여부 저장
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/bottom_navi',
                            (Route<dynamic> route) => false, // 모든 이전 라우트 제거
                      );
                    },
                    text: '이 차량 선택 하기',
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _showBottomOptions,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff101010),
                          foregroundColor: brownColor,
                          shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      child: Text('차량 등록 하기', style: TextStyle(fontSize: 15),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }






  /// 차량 등록 바텀 시트
  void _showBottomOptions() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Color(0xe0ffffff),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('차량등록하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.cancel_outlined, size: 30),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextFieldWidget(
                controller: _carNmController,
                prefixIcon: Icon(Icons.directions_car_outlined, color: Colors.black, size: 30),
                text: '차량 이름',
              ),
              SizedBox(height: 10),
              TextFieldWidget(
                controller: _carNumController,
                prefixIcon: Icon(Icons.pin_outlined, color: Colors.black, size: 30),
                text: '차량 번호',
              ),
              SizedBox(height: 10),

              /// 이미지 선택 버튼
              InkWell(
                onTap: _showImagePickerOptions,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xffeeeeee),
                    image: _selectedImage != null
                        ? DecorationImage(image: FileImage(_selectedImage!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: _selectedImage == null ? Icon(Icons.image_outlined, size: 40) : null,
                ),
              ),

              SizedBox(height: 10),
              Text(
                '이미지를 선택 해 주세요. \n 갤러리 앱 또는 카메라를 이용하실 수 있습니다.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              RedButtonWidget(
                onPressed: _handleCar,
                text: '차량 등록 후 이용하기',
              ),
              SizedBox(height: 30)
            ],
          ),
        );
      },
    );
  }

  /// 이미지 선택 모달
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.photo_library),
                title: Text('갤러리 열기'),
              ),
              ListTile(
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.camera_alt),
                title: Text('카메라 열기'),
              ),
            ],
          ),
        );
      },
    );
  }
}
