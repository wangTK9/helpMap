import 'package:flutter/material.dart';
import '../services/user_service.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(userName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(249, 248, 253, 0.9),
    );
  }
}
