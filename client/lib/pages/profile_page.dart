import 'package:flutter/material.dart';
import '../layouts/main_layout.dart';
import '../services/user_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  // Khởi tạo đối tượng UserService
  final UserService _userService = UserService();

  // Hàm lưu thông tin người dùng
  Future<void> _saveUserInfo() async {
    if (_formKey.currentState!.validate()) {
      // Lấy dữ liệu từ các controller
      String name = _nameController.text;
      String phone = _phoneController.text;
      String address = _addressController.text;
      String avatarUrl = _avatarController.text;

      // Gọi hàm saveUserInfo từ UserService
      await _userService.saveUserInfo(name, phone, address, avatarUrl);

      // Hiển thị thông báo sau khi lưu thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thông tin đã được lưu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài Khoản"),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Trường nhập tên
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tên'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              // Trường nhập số điện thoại
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),
              // Trường nhập địa chỉ
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
              // Trường nhập URL ảnh đại diện (hoặc có thể để trống)
              TextFormField(
                controller: _avatarController,
                decoration:
                    const InputDecoration(labelText: 'URL ảnh đại diện'),
              ),
              const SizedBox(height: 20),
              // Nút lưu thông tin
              ElevatedButton(
                onPressed: _saveUserInfo,
                child: const Text('Lưu Thông Tin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
