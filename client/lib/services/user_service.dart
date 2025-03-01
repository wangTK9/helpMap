// lib/services/user_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Lưu hoặc cập nhật thông tin người dùng vào Realtime Database
  Future<void> saveUserInfo(
      String name, String phone, String address, String avatarUrl) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Lấy tham chiếu đến vị trí người dùng trong Realtime Database
        DatabaseReference userRef = _database.ref('users/$userId');

        // Kiểm tra xem người dùng đã có thông tin trong database chưa
        DatabaseEvent event = await userRef.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          // Nếu người dùng đã có thông tin, cập nhật thông tin
          await userRef.update({
            'name': name,
            'phone': phone,
            'address': address,
            'avatar': avatarUrl,
          });
          print("Thông tin người dùng đã được cập nhật.");
        } else {
          // Nếu người dùng chưa có thông tin, tạo mới
          await userRef.set({
            'name': name,
            'phone': phone,
            'address': address,
            'avatar': avatarUrl,
          });
          print("Thông tin người dùng đã được lưu.");
        }
      }
    } catch (e) {
      print("Lỗi khi lưu thông tin người dùng: $e");
    }
  }

  // Lấy thông tin người dùng từ Realtime Database
  Future<Map<String, String>> getUserInfo() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Lấy tham chiếu đến vị trí người dùng trong Realtime Database
        DatabaseReference userRef = _database.ref('users/$userId');

        // Lấy dữ liệu của người dùng
        DatabaseEvent event = await userRef.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          // Nếu có dữ liệu, trả về dữ liệu dưới dạng Map
          Map<String, String> userInfo = {
            'name': snapshot.child('name').value.toString(),
            'phone': snapshot.child('phone').value.toString(),
            'address': snapshot.child('address').value.toString(),
            'avatar': snapshot.child('avatar').value.toString(),
          };
          return userInfo;
        } else {
          // Nếu không có dữ liệu, trả về Map rỗng
          return {};
        }
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      print("Lỗi khi lấy thông tin người dùng: $e");
      return {};
    }
  }
}
