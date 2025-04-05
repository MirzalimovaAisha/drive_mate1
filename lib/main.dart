import 'package:drive_mate_practice1/screens/bottom_navi_screen.dart';
import 'package:drive_mate_practice1/screens/car_registration_screen.dart';
import 'package:drive_mate_practice1/screens/car_selection_screen.dart';
import 'package:drive_mate_practice1/screens/sign_in_screen.dart';
import 'package:drive_mate_practice1/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isFirstLaunch = prefs.getBool('is_first_launch') ?? true;

  // 처음 실행이면 Splash 보여주고, is_first_launch는 false로 저장
  Widget initialScreen;
  if (isFirstLaunch) {
    await prefs.setBool('is_first_launch', false);
    initialScreen = SplashScreen();
  } else {
    // 차량 등록 여부 확인
    String? carName = prefs.getString('car_name');
    String? carNumber = prefs.getString('car_number');
    String? carImage = prefs.getString('car_image');

    if (carName != null && carNumber != null && carImage != null) {
      initialScreen = BottomNaviScreen(); // 홈 페이지
    } else {
      initialScreen = SignInScreen(); // 차량 등록 페이지
    }
  }

  runApp(MyApp(initialScreen: initialScreen));
}


class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialScreen,
      routes: {
        // '/': (context) => SplashScreen(),
        '/sign_in': (context) => SignInScreen(),
        '/car_registration': (context) => CarRegistrationScreen(),
        '/car_selection': (context) => CarSelectionScreen(),
        '/bottom_navi': (context) => BottomNaviScreen(),
      },
    );
  }
}
