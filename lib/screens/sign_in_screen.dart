import 'package:drive_mate_practice1/server/server.dart';
import 'package:drive_mate_practice1/widgets/color.dart';
import 'package:drive_mate_practice1/widgets/red_button_widget.dart';
import 'package:drive_mate_practice1/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServer _authServer = AuthServer();

  @override
  void initState() {
    super.initState();
    // _loadSavedCredentials();
  }

  /// 저장된 로그인 정보 불러오기
  // Future<void> _loadSavedCredentials() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedId = prefs.getString('mberId');
  //   String? savedPassword = prefs.getString('mberPassword');
  //
  //   if (savedId != null && savedPassword != null) {
  //     // 저장된 정보가 있다면 자동 로그인 시도
  //     final responseData = await _authServer.login(savedId, savedPassword);
  //     if (responseData['success'] == true) {
  //       Navigator.of(context).pushReplacementNamed('/car_registration');
  //     }
  //   }
  // }

  void _handleLogin()async{
    final mberId = _idController.text.trim();
    final mberPassword = _passwordController.text.trim();

    if(mberId.isEmpty || mberPassword.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('모든 항목을 채워주세요.'))
      );
      return;
    }

    if(mberId.isEmpty || mberId.length < 4){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사용자 이름은 4자 이상이여야 합니다.'))
      );
      return;
    }

    if(mberPassword.isEmpty || mberPassword.length < 4){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('비밀번호는 4자 이상이여야 합니다.'))
      );
      return;
    }

    if(mberId.isEmpty || mberId.contains(' ')){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('사용자 이름은 공백이 불가입니다.'))
      );
      return;
    }

    final responseData = await _authServer.login(mberId, mberPassword);
    if (responseData['success']== true){
      // if (light) {
      //   // Remember 옵션이 켜져 있으면 아이디 & 비밀번호 저장
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.setString('mberId', mberId);
      //   await prefs.setString('mberPassword', mberPassword);
      // }
      Navigator.of(context).pushReplacementNamed('/car_registration');
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('아이디 또는 비밀번호가 잘못되었습니다.'))
      );
    }

  }



  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hub_outlined, color: brownColor,size: 40,),
                        SizedBox(width: 10,),
                        Text('Drive Mate', style: TextStyle(fontSize: 27,fontWeight: FontWeight.w500,  color: Colors.white),),
                      ],
                    ),
                    Image.asset('assets/images/red car.png'),
                    SizedBox(height: 10,),
                    Text('로그인 정보를 입력하세요.', style: TextStyle(color: Colors.grey[300]),),
                    SizedBox(height: 30,),
                    TextFieldWidget(
                      controller: _idController,
                      prefixIcon: Icon(Icons.person),
                      text: 'Usernames',
                    ),
                    SizedBox(height: 10,),
                    TextFieldWidget(
                      obscureText: true,
                      controller: _passwordController,
                      prefixIcon: Icon(Icons.lock),
                      text: 'Password',
                    ),
                    SizedBox(height: 5,),

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

                    SizedBox(height: 5,),
                    RedButtonWidget(
                      onPressed: _handleLogin,
                      text: 'Sign In',
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
                width: double.infinity,
                color: Color(0xff131313),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('화원가입 기능이 준비 중입니다.'))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff7c7c7c),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder()
                      ),
                      child: Text('Sign Up', style: TextStyle(fontSize: 15),),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('비밀번호 재설정 기능이 준비 중입니다.'))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder()
                      ),
                      child: Text('Password Reset', style: TextStyle(fontSize: 15),),
                    )
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
