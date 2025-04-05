import 'package:drive_mate_practice1/widgets/color.dart';
import 'package:drive_mate_practice1/screens/control_screen.dart';
import 'package:drive_mate_practice1/screens/home_screen.dart';
import 'package:drive_mate_practice1/screens/share_screen.dart';
import 'package:drive_mate_practice1/screens/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNaviScreen extends StatefulWidget {
  const BottomNaviScreen({super.key});

  @override
  State<BottomNaviScreen> createState() => _BottomNaviScreenState();
}

class _BottomNaviScreenState extends State<BottomNaviScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ControlScreen(),
    StatusScreen(),
    ShareScreen(),
  ];

  void _onTappedItem(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight:Radius.circular(15), topLeft: Radius.circular(15) ),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _tabItems(Icons.home_outlined, 'Home', 0),
            VerticalDivider(
              indent: 7,
              endIndent: 10,
              thickness: 1,
              width: 10,
            ),
            _tabItems(Icons.control_camera, 'Control', 1),
            VerticalDivider(
              indent: 7,
              endIndent: 10,
              thickness: 1.09,
              width: 10,
              color: Colors.grey,
            ),
            _tabItems(Icons.directions_car_outlined, 'Status', 2),
            VerticalDivider(
              indent: 7,
              endIndent: 10,
              thickness: 1,
              width: 10,
            ),
            _tabItems(Icons.device_hub, 'Share', 3),
          ],
        ),
      ),
    );
  }

  Widget _tabItems(IconData icon, String text, int index){
    return GestureDetector(
      onTap: ()=> _onTappedItem(index),
      child: SizedBox(
          width: 70,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _selectedIndex == index? brownColor : Colors.grey[700],
                size: 30,
              ),
              Text(
                text,
                style: TextStyle(
                  color: _selectedIndex == index? brownColor : Colors.grey[700],
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
    );
  }
}
