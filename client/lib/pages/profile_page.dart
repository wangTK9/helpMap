import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/user_service.dart';
import '../layouts/main_layout.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = 'Helpers';
  String userEmail = 'Helpers@gmail.com';
  String userAvatar = 'assets/images/avatar-default.jpg';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    Map<String, String> userInfo = await UserService().getUserInfo();
    setState(() {
      userName = userInfo['name'] ?? 'Helpers';
      userEmail = userInfo['email'] ?? 'user01@gmail.com';
      userAvatar = userInfo['avatar'] ?? 'assets/images/avatar-default.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainLayout()),
              (route) => false,
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipOval(
                  child: Image.network(
                    userAvatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/avatar-default.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                userName,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Container(
                width: 190,
                height: 30,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(220, 220, 254, 1.0),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    userEmail,
                    style: const TextStyle(
                        color: Color.fromRGBO(154, 151, 229, 1.0)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(15.0),
                width: screenWidth,
                height: 290,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/edit-profile");
                        },
                        child: Container(
                          width: screenWidth,
                          height: 50,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Color.fromARGB(255, 235, 233, 237),
                            width: 0.5,
                          ))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(MdiIcons.accountEditOutline,
                                      color:
                                          Color.fromRGBO(133, 129, 215, 1.0)),
                                  SizedBox(width: 12),
                                  Text('Thông tin liên hệ',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16)),
                                ],
                              ),
                              Icon(MdiIcons.arrowRight,
                                  color: Color.fromRGBO(227, 227, 227, 1.0)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/health");
                        },
                        child: Container(
                          width: screenWidth,
                          height: 50,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Color.fromARGB(255, 235, 233, 237),
                            width: 0.5,
                          ))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(MdiIcons.stethoscope,
                                      color:
                                          Color.fromRGBO(133, 129, 215, 1.0)),
                                  SizedBox(width: 12),
                                  Text('Thông tin y tế khẩn cấp',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16)),
                                ],
                              ),
                              Icon(MdiIcons.arrowRight,
                                  color: Color.fromRGBO(227, 227, 227, 1.0)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/edit-profile");
                        },
                        child: Container(
                          width: screenWidth,
                          height: 50,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Color.fromARGB(255, 235, 233, 237),
                            width: 0.5,
                          ))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(MdiIcons.cog,
                                      color:
                                          Color.fromRGBO(133, 129, 215, 1.0)),
                                  SizedBox(width: 12),
                                  Text('Cài đặt',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16)),
                                ],
                              ),
                              Icon(MdiIcons.arrowRight,
                                  color: Color.fromRGBO(227, 227, 227, 1.0)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Xác nhận đăng xuất"),
                                content: const Text(
                                    "Bạn có chắc chắn muốn đăng xuất không?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Đóng popup
                                    },
                                    child: const Text("Hủy"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await FirebaseAuth.instance
                                          .signOut(); // Đăng xuất Firebase // Đóng popup trước
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/login", (route) => false);
                                    },
                                    child: const Text(
                                      "Có",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          width: screenWidth,
                          height: 50,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 235, 233, 237),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(MdiIcons.logout, color: Colors.red),
                                  SizedBox(width: 12),
                                  Text(
                                    'Đăng xuất',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                ],
                              ),
                              Icon(MdiIcons.arrowRight, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(249, 248, 253, 0.8),
    );
  }
}
