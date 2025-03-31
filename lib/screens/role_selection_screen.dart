import 'package:flutter/material.dart';
import 'login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to EduApp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Select your role to continue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 60),
              _buildRoleButton(
                context,
                'Student',
                Icons.school,
                Colors.blue,
                'student',
              ),
              const SizedBox(height: 16),
              _buildRoleButton(
                context,
                'Teacher',
                Icons.person,
                Colors.green,
                'teacher',
              ),
              const SizedBox(height: 16),
              _buildRoleButton(
                context,
                'Parent',
                Icons.family_restroom,
                Colors.orange,
                'parent',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(
    BuildContext context,
    String role,
    IconData icon,
    Color color,
    String roleType,
  ) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 24),
      label: Text(
        role,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(role: roleType)),
        );
      },
    );
  }
}
