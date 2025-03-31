import 'package:flutter/material.dart';
import '../widgets/grades_by_subject_widget.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<SubjectGrade> grades = [
      SubjectGrade(
        subject: 'Mathematics',
        grade: 'A-',
        teacher: 'Dr. Smith',
        assignments: [
          Assignment(title: 'Algebra Quiz', dueDate: '2025-03-25', score: '92%'),
          Assignment(title: 'Geometry Project', dueDate: '2025-03-28', score: '88%'),
          Assignment(title: 'Final Exam', dueDate: '2025-04-05', score: 'Not graded'),
        ],
      ),
      SubjectGrade(
        subject: 'Science',
        grade: 'B+',
        teacher: 'Ms. Johnson',
        assignments: [
          Assignment(title: 'Lab Report', dueDate: '2025-03-22', score: '86%'),
          Assignment(title: 'Ecosystem Poster', dueDate: '2025-03-30', score: '91%'),
          Assignment(title: 'Final Exam', dueDate: '2025-04-08', score: 'Not graded'),
        ],
      ),
      SubjectGrade(
        subject: 'Language Arts',
        grade: 'A',
        teacher: 'Mr. Williams',
        assignments: [
          Assignment(title: 'Book Report', dueDate: '2025-03-18', score: '95%'),
          Assignment(title: 'Poetry Analysis', dueDate: '2025-03-27', score: '93%'),
          Assignment(title: 'Final Essay', dueDate: '2025-04-06', score: 'Not graded'),
        ],
      ),
      SubjectGrade(
        subject: 'Social Studies',
        grade: 'B',
        teacher: 'Mrs. Davis',
        assignments: [
          Assignment(title: 'History Timeline', dueDate: '2025-03-20', score: '84%'),
          Assignment(title: 'Current Events', dueDate: '2025-03-29', score: '88%'),
          Assignment(title: 'Final Project', dueDate: '2025-04-10', score: 'Not graded'),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              const Text(
                'Welcome, Alex!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Current Date: 2025-03-31',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              
              // Overview card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Academic Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('GPA', '3.7'),
                          _buildStatItem('Attendance', '97%'),
                          _buildStatItem('Rank', '8/120'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Grades by subject
              GradesBySubjectWidget(grades: grades),
              
              const SizedBox(height: 24),
              
              // Upcoming assignments
              const Text(
                'Upcoming Assignments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.blue),
                  title: const Text('Final Math Exam'),
                  subtitle: const Text('Due: April 5, 2025'),
                  trailing: const Text('Math', style: TextStyle(color: Colors.grey)),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.green),
                  title: const Text('Science Lab Report'),
                  subtitle: const Text('Due: April 8, 2025'),
                  trailing: const Text('Science', style: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}