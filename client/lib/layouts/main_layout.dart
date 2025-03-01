import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../pages/home_page.dart';
import '../pages/community_page.dart';
import '../pages/sos_page.dart';
import '../pages/rescue_page.dart';
import '../pages/profile_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  // Danh sách các trang
  final List<Widget> _pages = [
    HomePage(), // Tab 0
    CommunityPage(), // Tab 1
    SOSPage(), // Tab 2
    RescuePage(), // Tab 3
    ProfilePage(), // Tab 4
  ];

  // Xử lý khi bấm vào tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _selectedIndex == 0 // Chỉ hiển thị nếu là HomePage
          ? CustomNavbar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null, // Các trang khác không có navbar
    );
  }
}
