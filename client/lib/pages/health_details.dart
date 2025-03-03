import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../services/user_service.dart';

class HealthDetailsScreen extends StatefulWidget {
  @override
  _HealthDetailsScreenState createState() => _HealthDetailsScreenState();
}

class _HealthDetailsScreenState extends State<HealthDetailsScreen> {
  final UserService _userService = UserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();
  final TextEditingController _disabilitiesController = TextEditingController();
  final TextEditingController _medicalDevicesController =
      TextEditingController();
  final TextEditingController _specialNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHealthData();
  }

  Future<void> _loadHealthData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref('users/${user.uid}');
        DatabaseEvent event = await userRef.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          setState(() {
            _bloodTypeController.text =
                snapshot.child('bloodType').value?.toString() ?? '';
            _medicalHistoryController.text =
                snapshot.child('medicalHistory').value?.toString() ?? '';
            _allergiesController.text =
                snapshot.child('allergies').value?.toString() ?? '';
            _medicationsController.text =
                snapshot.child('medications').value?.toString() ?? '';
            _disabilitiesController.text =
                snapshot.child('disabilities').value?.toString() ?? '';
            _medicalDevicesController.text =
                snapshot.child('medicalDevices').value?.toString() ?? '';
            _specialNotesController.text =
                snapshot.child('specialNotes').value?.toString() ?? '';
          });
        }
      }
    } catch (e) {
      print("Lỗi khi tải dữ liệu sức khỏe: $e");
    }
  }

  Future<void> _saveHealthDetails() async {
    await _userService.saveUserInfo(
      bloodType: _bloodTypeController.text,
      medicalHistory: _medicalHistoryController.text,
      allergies: _allergiesController.text,
      medications: _medicationsController.text,
      disabilities: _disabilitiesController.text,
      medicalDevices: _medicalDevicesController.text,
      specialNotes: _specialNotesController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Thông tin sức khỏe đã được lưu!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin y tế khẩn cấp"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHealthCard(),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveHealthDetails,
                icon: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                label: Text(
                  "Lưu thông tin",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  backgroundColor: Color.fromRGBO(133, 129, 215, 1.0),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildHealthCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField("Nhóm máu", "VD: A+, B-, O+", Icons.bloodtype,
                _bloodTypeController),
            _buildTextField("Tiền sử bệnh", "VD: Tiểu đường, cao huyết áp",
                Icons.history, _medicalHistoryController),
            _buildTextField("Dị ứng", "VD: Dị ứng phấn hoa, hải sản",
                Icons.warning, _allergiesController),
            _buildTextField(
                "Thuốc đang sử dụng",
                "VD: Thuốc huyết áp, kháng sinh",
                Icons.medical_services,
                _medicationsController),
            _buildTextField("Khuyết tật", "VD: Khiếm thính, bại liệt",
                Icons.accessibility, _disabilitiesController),
            _buildTextField("Thiết bị y tế hỗ trợ", "VD: Máy trợ tim, nạng",
                Icons.devices, _medicalDevicesController),
            _buildTextField("Ghi chú đặc biệt", "Những lưu ý quan trọng khác",
                Icons.note, _specialNotesController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, IconData icon,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon:
              Icon(icon, color: const Color.fromRGBO(133, 129, 215, 1.0)),
          labelText: label,
          hintText: placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
