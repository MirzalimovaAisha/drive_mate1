import 'dart:io';

import 'package:drive_mate_practice1/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? carName;
  String? carImagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCarInfo();
  }

  Future<void> loadCarInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      carName = prefs.getString('carName') ?? '';
      carImagePath = prefs.getString('carImage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =============== 배경색 ===================
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 670,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFAAAAAA),  // #aaa
                        Color(0xFF818181),  // #818181
                        Color(0xFFFFFFFF),  // #fff
                        Color(0xFFFFFFFF),  // #fff
                      ],
                      stops: [0.0, 0.68, 0.79, 1.0],
                    ),
                  ),
                ),

                // =============== 구름 이미지 ====================
                Image.asset('assets/images/cloud2.png',),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                child: Text(carName?? '', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                onTap: (){
                                  Navigator.of(context).pushReplacementNamed('/car_selection');
                                },
                              ),
                              SvgPicture.asset('assets/icons/chevron_right_24dp_5F6368_FILL0_wght400_GRAD0_opsz24.svg', width: 25,color: Colors.black,),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(Icons.notifications_none_outlined, size: 35,),
                              const SizedBox(width: 10,),
                              Icon(Icons.settings_outlined, size: 35,),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.wb_sunny_outlined, size: 25,),
                                  const SizedBox(width: 5,),
                                  Text("28.1'C", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.my_location_outlined, size: 25,),
                                  const SizedBox(width: 5,),
                                  Text("경상북도 경주시", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.local_gas_station_outlined, size: 25,),
                              const SizedBox(width: 5,),
                              Text("424km", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 100,),

                      // ================= 차 이미지 ================
                      carImagePath != null ? Image.file(File(carImagePath!), height: 200,): Icon(Icons.image_not_supported_outlined),

                      const SizedBox(height: 80,),

                      // ==================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _tabItems('assets/icons/power_settings_new_24dp_5F6368_FILL0_wght300_GRAD200_opsz24.svg', '시동'),
                          _tabItems('assets/icons/lock_24dp_5F6368_FILL0_wght300_GRAD200_opsz24.svg', '도어'),
                          _tabItems('assets/icons/car-door-svgrepo-com.svg', '창문'),
                          _tabItems('assets/icons/warning_24dp_5F6368_FILL0_wght300_GRAD200_opsz24.svg', '비상등'),
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),

            //=========================================================
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('홍길동님, 안녕하세요?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 10,),
                  
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    width: double.infinity,
                    // height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _itemList('assets/icons/car-svgrepo-com.svg', 'Vehicle control'),
                        const SizedBox(height: 10,),
                        _itemList('assets/icons/ventilating-fan-svgrepo-com.svg', 'Vehicle control'),
                        const SizedBox(height: 10,),
                        _itemList('assets/icons/my_location_black_24dp.svg', 'Location'),
                        const SizedBox(height: 10,),
                        _itemList('assets/icons/vpn_key_black_24dp.svg', 'Valet Mode'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40,)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10
            )
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.power_settings_new, color: Colors.grey, size: 30),
        ),
      ),

    );
  }


 /// ======================================================
/// =======================================================

  // ================== list =====================
  Widget _itemList(String icon, String text){
   return Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             children: [
               SvgPicture.asset(icon, color: brownColor, width: 27,),
               const SizedBox(width: 10,),
               Text(text, style: TextStyle(fontSize: 16, color: Colors.white),)
             ],
           ),
           Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 15,)
         ],
       ),
       const SizedBox(height: 5,),
       Divider(color: Colors.grey[800],),
     ],
   );
  }

  // ================ TAB ITEM ================
  Widget _tabItems(String icon, String text){
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey
            ),
            borderRadius: BorderRadius.circular(8)
          ),
          child: SvgPicture.asset(icon, color: Colors.black,),
        ),
        const SizedBox(height: 10,),
        Text(text, style: TextStyle(fontSize: 16),)
      ],
    );
  }
}
















