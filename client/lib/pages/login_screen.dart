import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../pages/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    var user = await _authService.signIn(email, password);
    if (user != null) {
      print("Đăng nhập thành công: ${user.email}");
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      print("Đăng nhập thất bại!");
    }
  }

  void _handleGoogleSignIn() async {
    var user = await _authService.signInWithGoogle();
    if (user != null) {
      print("Đăng nhập Google thành công: ${user.email}");
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      print("Đăng nhập Google thất bại!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng nhập")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Mật khẩu"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text("Đăng nhập"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleGoogleSignIn,
              child: Text("Đăng nhập với Google"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text("Chưa có tài khoản? Đăng ký"),
            ),
          ],
        ),
      ),
    );
  }
}
