import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Lưu hoặc cập nhật thông tin người dùng vào Realtime Database
  Future<void> saveUserInfo({
    String? name,
    String? phone,
    String? address,
    String? avatarUrl,
    String? bloodType,
    String? medicalHistory,
    String? allergies,
    String? medications,
    String? disabilities,
    String? medicalDevices,
    String? specialNotes,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        DatabaseReference userRef = _database.ref('users/$userId');

        // Lấy dữ liệu người dùng từ database
        DatabaseEvent event = await userRef.once();
        DataSnapshot snapshot = event.snapshot;

        // Nếu chưa có dữ liệu, lấy từ FirebaseAuth
        String defaultName = user.displayName ?? "Người dùng";
        String defaultEmail = user.email ?? "";
        String defaultAvatar =
            user.photoURL ?? "assets/images/avatar-default.jpg";

        // Dữ liệu mới để cập nhật
        Map<String, String> userData = {
          'name':
              name ?? snapshot.child('name').value?.toString() ?? defaultName,
          'email': defaultEmail,
          'phone': phone ?? snapshot.child('phone').value?.toString() ?? '',
          'address':
              address ?? snapshot.child('address').value?.toString() ?? '',
          'avatar': avatarUrl ??
              snapshot.child('avatar').value?.toString() ??
              defaultAvatar,
          'bloodType':
              bloodType ?? snapshot.child('bloodType').value?.toString() ?? '',
          'medicalHistory': medicalHistory ??
              snapshot.child('medicalHistory').value?.toString() ??
              '',
          'allergies':
              allergies ?? snapshot.child('allergies').value?.toString() ?? '',
          'medications': medications ??
              snapshot.child('medications').value?.toString() ??
              '',
          'disabilities': disabilities ??
              snapshot.child('disabilities').value?.toString() ??
              '',
          'medicalDevices': medicalDevices ??
              snapshot.child('medicalDevices').value?.toString() ??
              '',
          'specialNotes': specialNotes ??
              snapshot.child('specialNotes').value?.toString() ??
              '',
        };

        // Nếu chưa có dữ liệu, tạo mới; nếu có, cập nhật
        if (snapshot.exists) {
          await userRef.update(userData);
          print("Thông tin người dùng đã được cập nhật.");
        } else {
          await userRef.set(userData);
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
        DatabaseReference userRef = _database.ref('users/$userId');

        DatabaseEvent event = await userRef.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          return {
            'name': snapshot.child('name').value?.toString() ??
                user.displayName ??
                "Người dùng",
            'email':
                snapshot.child('email').value?.toString() ?? user.email ?? "",
            'phone': snapshot.child('phone').value?.toString() ?? '',
            'address': snapshot.child('address').value?.toString() ?? '',
            'avatar': snapshot.child('avatar').value?.toString() ??
                user.photoURL ??
                "assets/images/avatar-default.jpg",
            'bloodType': snapshot.child('bloodType').value?.toString() ?? '',
            'medicalHistory':
                snapshot.child('medicalHistory').value?.toString() ?? '',
            'allergies': snapshot.child('allergies').value?.toString() ?? '',
            'medications':
                snapshot.child('medications').value?.toString() ?? '',
            'disabilities':
                snapshot.child('disabilities').value?.toString() ?? '',
            'medicalDevices':
                snapshot.child('medicalDevices').value?.toString() ?? '',
            'specialNotes':
                snapshot.child('specialNotes').value?.toString() ?? '',
          };
        } else {
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
