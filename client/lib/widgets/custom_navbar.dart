import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavbar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green[700],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.messageCircle),
                label: 'Cộng đồng',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Empty space for center button
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.users),
                label: 'Cứu hộ',
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.user),
                label: 'Tài khoản',
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20, // Adjust height of the floating button
          child: ThreeDSOSButton(
            onPressed: () => onItemTapped(2),
          ),
        ),
      ],
    );
  }
}

class ThreeDSOSButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ThreeDSOSButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<ThreeDSOSButton> createState() => _ThreeDSOSButtonState();
}

class _ThreeDSOSButtonState extends State<ThreeDSOSButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(4, 4),
              blurRadius: _isPressed ? 4 : 10,
              spreadRadius: _isPressed ? 1 : 3,
            ),
            const BoxShadow(
              color: Colors.white30,
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'SOS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
