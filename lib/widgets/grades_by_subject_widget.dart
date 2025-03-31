import 'package:flutter/material.dart';

class GradesBySubjectWidget extends StatelessWidget {
  final List<SubjectGrade> grades;

  const GradesBySubjectWidget({
    Key? key, 
    required this.grades,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Grades by Subject',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Grade by subject
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: grades.length,
          itemBuilder: (context, index) {
            final grade = grades[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getSubjectColor(grade.subject),
                  child: Text(
                    grade.subject[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  grade.subject,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Teacher: ${grade.teacher}',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getGradeColor(grade.grade),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    grade.grade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  // Show more details about this subject's grades
                  _showGradeDetails(context, grade);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getSubjectColor(String subject) {
    switch (subject.toLowerCase()) {
      case 'mathematics':
        return Colors.blue;
      case 'science':
        return Colors.green;
      case 'language arts':
        return Colors.purple;
      case 'social studies':
        return Colors.orange;
      case 'art':
        return Colors.pink;
      case 'physical education':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return Colors.green;
    if (grade.startsWith('B')) return Colors.blue;
    if (grade.startsWith('C')) return Colors.orange;
    if (grade.startsWith('D')) return Colors.deepOrange;
    if (grade.startsWith('F')) return Colors.red;
    return Colors.grey;
  }

  void _showGradeDetails(BuildContext context, SubjectGrade grade) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              grade.subject,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Teacher: ${grade.teacher}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current Grade:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _getGradeColor(grade.grade),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    grade.grade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Recent Assignments:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: grade.assignments.length,
              itemBuilder: (context, index) {
                final assignment = grade.assignments[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(assignment.title),
                  subtitle: Text('Due: ${assignment.dueDate}'),
                  trailing: Text(
                    assignment.score,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: assignment.score == 'Not graded'
                          ? Colors.grey
                          : _getGradeColor(assignment.score),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectGrade {
  final String subject;
  final String grade;
  final String teacher;
  final List<Assignment> assignments;

  SubjectGrade({
    required this.subject,
    required this.grade,
    required this.teacher,
    required this.assignments,
  });
}

class Assignment {
  final String title;
  final String dueDate;
  final String score;

  Assignment({
    required this.title,
    required this.dueDate,
    required this.score,
  });
}