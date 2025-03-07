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

  Color primaryColor = Color.fromRGBO(133, 129, 215, 1.0);

  void _handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    var user = await _authService.signIn(email, password);
    if (user != null) {
      print("Đăng nhập thành công: \${user.email}");
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      print("Đăng nhập thất bại!");
    }
  }

  void _handleGoogleSignIn() async {
    var user = await _authService.signInWithGoogle();
    if (user != null) {
      print("Đăng nhập Google thành công: \${user.email}");
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      print("Đăng nhập Google thất bại!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                child: Text("Đăng nhập", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: _handleGoogleSignIn,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  side: BorderSide(color: primaryColor),
                ),
                child: Text("Đăng nhập với Google", style: TextStyle(fontSize: 16, color: primaryColor)),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text(
                  "Chưa có tài khoản? Đăng ký",
                  style: TextStyle(fontSize: 14, color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
