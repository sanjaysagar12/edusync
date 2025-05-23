import 'package:edusync/screens/teacher_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'student_dashboard_screen.dart';
import 'parent_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  final String role;
  
  const LoginScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String roleTitle = widget.role[0].toUpperCase() + widget.role.substring(1);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('$roleTitle Login'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with icon
                _buildRoleIcon(),
                const SizedBox(height: 24),
                
                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password functionality would go here
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Login button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Print role for debugging
                      print('Current role: ${widget.role}');
                      
                      // Show toast based on role for debugging
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Attempting to navigate to $roleTitle dashboard')),
                      );
                      
                      // Navigation based on role with delay to ensure snackbar is visible
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (widget.role == 'student') {
                          print('Navigating to Student Dashboard');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StudentDashboardScreen(),
                            ),
                          );
                        } else if (widget.role == 'teacher') {
                          print('Navigating to teacher Dashboard');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TeacherDashboardScreen(),
                            ),
                          );
                        } 
                        else if (widget.role == 'parent') {
                          print('Navigating to Parent Dashboard');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ParentDashboardScreen(),
                            ),
                          );
                        }else {
                          // If role doesn't match expected values, show error
                          print('Unknown role: ${widget.role}');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: Unknown role "${widget.role}"')),
                          );
                        }
                      });
                    }
                  },
                  child: const Text('LOGIN', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 24),
                
                // Current role indicator for debugging
                Text(
                  'Current role: ${widget.role}',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Registration link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(role: widget.role),
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
                
                // Debug buttons for direct navigation testing
                const SizedBox(height: 40),
                const Text(
                  'Debug Navigation',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentDashboardScreen(),
                          ),
                        );
                      },
                      child: const Text('Student Dashboard'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ParentDashboardScreen(),
                          ),
                        );
                      },
                      child: const Text('Parent Dashboard'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleIcon() {
    IconData iconData;
    Color color;
    
    switch (widget.role) {
      case 'student':
        iconData = Icons.school;
        color = Colors.blue;
        break;
      case 'teacher':
        iconData = Icons.person;
        color = Colors.green;
        break;
      case 'parent':
        iconData = Icons.family_restroom;
        color = Colors.orange;
        break;
      default:
        iconData = Icons.person;
        color = Colors.blue;
    }

    return Column(
      children: [
        Icon(
          iconData,
          size: 80,
          color: color,
        ),
        const SizedBox(height: 16),
        Text(
          '${widget.role[0].toUpperCase()}${widget.role.substring(1)} Login',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}