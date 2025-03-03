import 'package:flutter/material.dart';
import '../layouts/main_layout.dart';

class SOSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sos"),
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
      body: const Center(
        child: Text(
          "Đây là trang sos",
          style: TextStyle(fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
