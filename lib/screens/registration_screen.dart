import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final String role;
  
  const RegistrationScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String roleTitle = widget.role[0].toUpperCase() + widget.role.substring(1);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('$roleTitle Registration'),
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
                // Common fields for all roles
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
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
                
                // Role-specific fields
                ..._buildRoleSpecificFields(),
                
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Registration functionality would go here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$roleTitle registration successful (demo)')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('REGISTER', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 24),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Login'),
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

  List<Widget> _buildRoleSpecificFields() {
    List<Widget> fields = [];
    
    switch (widget.role) {
      case 'student':
        fields = [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Student ID',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your student ID';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Grade/Class',
              prefixIcon: Icon(Icons.grade_outlined),
            ),
            items: const [
              DropdownMenuItem(value: 'Grade 1', child: Text('Grade 1')),
              DropdownMenuItem(value: 'Grade 2', child: Text('Grade 2')),
              DropdownMenuItem(value: 'Grade 3', child: Text('Grade 3')),
              DropdownMenuItem(value: 'Grade 4', child: Text('Grade 4')),
              DropdownMenuItem(value: 'Grade 5', child: Text('Grade 5')),
            ],
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your grade';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        ];
        break;
        
      case 'teacher':
        fields = [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Employee ID',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your employee ID';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Subject Specialty',
              prefixIcon: Icon(Icons.book_outlined),
            ),
            items: const [
              DropdownMenuItem(value: 'Mathematics', child: Text('Mathematics')),
              DropdownMenuItem(value: 'Science', child: Text('Science')),
              DropdownMenuItem(value: 'Language Arts', child: Text('Language Arts')),
              DropdownMenuItem(value: 'Social Studies', child: Text('Social Studies')),
              DropdownMenuItem(value: 'Art', child: Text('Art')),
            ],
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your subject';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        ];
        break;
        
      case 'parent':
        fields = [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Child\'s Student ID',
              prefixIcon: Icon(Icons.family_restroom),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your child\'s student ID';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        ];
        break;
        
      default:
        break;
    }
    
    return fields;
  }
}