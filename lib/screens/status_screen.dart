import 'package:drive_mate_practice1/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> with SingleTickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          // =========== AppBar ====================
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ========== 왼쪽 텍스트 ===========
                Row(
                  children: [
                    Text('Q8', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SvgPicture.asset('assets/icons/chevron_right_24dp_5F6368_FILL0_wght400_GRAD0_opsz24.svg', width: 25,color: Colors.black,),
                  ],
                ),

                // ============= 가운데 텍스트 ================
                Text('Status', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),


                // =============== 오른쪽 아이콘 =============
                Row(
                  children: [
                    Icon(Icons.notifications_none_outlined, size: 30,),
                    const SizedBox(width: 10,),
                    Icon(Icons.settings_outlined, size: 30,),
                  ],
                ),
              ],
            ),
          ),
          //===========================================================
          // =================== 탭 메뉴 ==========================
          TabBar.secondary(
            controller: _tabController,
            indicatorColor: brownColor,
            labelColor: brownColor,
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: '차량',),
              Tab(text: '공조'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // =========== 차량 탭 내용물 ==============
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('차량 상태', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Column(
                          children: [
                            _tabLists('assets/icons/door2.svg', '도어', ' 잠김'),
                            _tabLists('assets/icons/window.svg', '창문', ' 닫힘'),
                            _tabLists('assets/icons/tailgate.svg', '테일게이트', ' 닫힘'),
                            _tabLists('assets/icons/bonnet.svg', '후드', ' 닫힘'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // =========== 공조 탭 내용물 ==============
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('공조 상태', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Column(
                          children: [
                            _tabList2('assets/icons/mode_cool_24dp_5F6368_FILL0_wght300_GRAD200_opsz24.svg', '냉/난방', ' 꺼짐'),
                            _tabList2('assets/icons/handle.svg', '핸들 열선', '꺼짐'),
                            _tabList2('assets/icons/mirror-svgrepo-com.svg', '앞유리 성에 제거', ' 꺼짐'),
                            _tabList2('assets/icons/mirror-svgrepo-com.svg', '뒷유리 열선', ' 꺼짐'),
                            _tabList2('assets/icons/side mirror.svg', '사이드 미러 열선', ' 꺼짐'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }

  // ================== 차량 탭 리스트 =================
  Widget _tabLists(String icon, String text, String leftText){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ========== 왼쪽 ===========
              Row(
                children: [
                  SvgPicture.asset(icon, width: 30,),
                  const SizedBox(width: 20,),
                  Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                ],
              ),

              // ========= 오른쪽 ==============
              Text(leftText, style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),)
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  //=============================================================
// ================== 차량 탭 리스트 =================
  Widget _tabList2(String icon, String text, String leftText){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ========== 왼쪽 ===========
              Row(
                children: [
                  SvgPicture.asset(icon, width: 25,color: Colors.black,),
                  const SizedBox(width: 20,),
                  Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                ],
              ),

              // ========= 오른쪽 ==============
              Text(leftText, style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),)
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}












