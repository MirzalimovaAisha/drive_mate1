import 'package:drive_mate_practice1/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late AnimationController _logoController;
  late AnimationController _text1Controller;
  late AnimationController _text2Controller;
  late AnimationController _carImgController;

  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _text1Animation;
  late Animation<Offset> _text2Animation;
  late Animation<double> _carImgAnimation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _logoAnimation = Tween<Offset>(
      begin: Offset(0, -10),
      end: Offset.zero
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _text1Controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _text1Animation = Tween<Offset>(
        begin: Offset(7, 0),
        end: Offset.zero
    ).animate(CurvedAnimation(parent: _text1Controller, curve: Curves.easeOut));

    _text2Controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _text2Animation = Tween<Offset>(
        begin: Offset(-7, 0),
        end: Offset.zero
    ).animate(CurvedAnimation(parent: _text2Controller, curve: Curves.easeOut));

    _carImgController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _carImgAnimation = Tween<double>(
        begin: 0,
        end:1
    ).animate(CurvedAnimation(parent: _carImgController, curve: Curves.elasticOut));

    _startAnimations();
  }

  void _startAnimations() async{
    await _logoController.forward();
    await _text1Controller.forward();
    await _text2Controller.forward();
    await _carImgController.forward();
    _signInPage();

    // if (!mounted) return;

    // _checkStatus(); // 여기서만 Navigator 호출
  }

  void _signInPage(){
    Navigator.of(context).pushReplacementNamed('/sign_in');
  }

  // void _checkStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   String? carName = prefs.getString('car_name');
  //   String? carNumber = prefs.getString('car_number');
  //   String? carImage = prefs.getString('car_image');
  //
  //   await Future.delayed(Duration(milliseconds: 0));
  //   if (carName != null && carNumber != null && carImage != null) {
  //     // 차량 등록 되어 있음 → 홈 화면으로
  //     Navigator.pushReplacementNamed(context, '/bottom_navi');
  //   } else {
  //     // 차량 등록 안 되어 있음 → 차량 등록 화면으로
  //     Navigator.pushReplacementNamed(context, '/sign_in');
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _logoController.dispose();
    _text1Controller.dispose();
    _text2Controller.dispose();
    _carImgController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _logoAnimation,
              child: Icon(Icons.hub_outlined, color: brownColor,size: 80,),
            ),
            SizedBox(height: 20,),
            SlideTransition(
              position: _text1Animation,
              child: Text('Drive Mate', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
            SizedBox(height: 5,),
            SlideTransition(
              position: _text2Animation,
              child: Text('연결하고, 운전하고, 즐기세요', style: TextStyle(fontSize: 18, color: Colors.grey[300]),),
            ),

            SizedBox(height: 50,),
            ScaleTransition(
              scale: _carImgAnimation,
              child: Image.asset('assets/images/car.png'),
            )

          ],
        ),
      ),
    );
  }
}













