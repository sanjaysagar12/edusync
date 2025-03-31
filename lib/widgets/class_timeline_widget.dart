import 'package:flutter/material.dart';

class ClassTimelineWidget extends StatelessWidget {
  final List<ClassSession> classes;
  final bool showCompleted;

  const ClassTimelineWidget({
    Key? key,
    required this.classes,
    this.showCompleted = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ClassSession> filteredClasses = showCompleted 
      ? classes 
      : classes.where((classSession) => !classSession.isCompleted).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Timeline of Classes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // View full schedule
                },
                child: const Text('View Schedule'),
              ),
            ],
          ),
        ),
        
        // Timeline of classes
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filteredClasses.length,
          itemBuilder: (context, index) {
            final classSession = filteredClasses[index];
            final bool isLastItem = index == filteredClasses.length - 1;
            
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Timeline indicator
                  SizedBox(
                    width: 60,
                    child: _buildTimeIndicator(classSession, isLastItem),
                  ),
                  
                  // Class card
                  Expanded(
                    child: _buildClassCard(context, classSession),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeIndicator(ClassSession classSession, bool isLastItem) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 8.0),
          height: 20,
          child: Text(
            classSession.startTime,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: classSession.isCompleted ? Colors.grey : Colors.black87,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: classSession.isCompleted 
                  ? Colors.grey 
                  : classSession.isActive ? Colors.green : Colors.blue,
                border: Border.all(
                  color: classSession.isActive ? Colors.green.shade800 : Colors.blue.shade800,
                  width: 2,
                ),
              ),
            ),
            Container(
              width: 2,
              height: isLastItem ? 30 : 70,
              color: isLastItem ? Colors.transparent : Colors.grey.withOpacity(0.3),
            ),
          ],
        ),
        if (isLastItem)
          Container()
        else
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8.0, top: 4.0),
            height: 20,
            child: Text(
              classSession.endTime,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildClassCard(BuildContext context, ClassSession classSession) {
    return Card(
      margin: const EdgeInsets.only(right: 16.0, bottom: 16.0),
      elevation: classSession.isActive ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: classSession.isActive 
          ? BorderSide(color: _getSubjectColor(classSession.subject), width: 2)
          : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  classSession.subject,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: classSession.isCompleted 
                      ? Colors.grey 
                      : _getSubjectColor(classSession.subject),
                  ),
                ),
                _buildStatusIndicator(classSession),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  'Teacher: ${classSession.teacher}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  classSession.room,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            
            // Assignment due or class materials (if any)
            if (classSession.assignmentDue != null || classSession.materials.isNotEmpty)
              const SizedBox(height: 8),
            
            if (classSession.assignmentDue != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.assignment_outlined,
                      size: 14,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${classSession.assignmentDue}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            
            if (classSession.materials.isNotEmpty)
              const SizedBox(height: 4),
            
            if (classSession.materials.isNotEmpty)
              Wrap(
                spacing: 8,
                children: classSession.materials.map((material) {
                  IconData icon;
                  switch (material.type) {
                    case 'pdf':
                      icon = Icons.picture_as_pdf_outlined;
                      break;
                    case 'video':
                      icon = Icons.video_library_outlined;
                      break;
                    case 'quiz':
                      icon = Icons.quiz_outlined;
                      break;
                    default:
                      icon = Icons.attachment_outlined;
                  }
                  
                  return Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    avatar: Icon(
                      icon,
                      size: 16,
                      color: Colors.blue,
                    ),
                    label: Text(
                      material.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(ClassSession classSession) {
    if (classSession.isCompleted) {
      return const Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: Colors.grey,
        label: Text(
          'Completed',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      );
    } else if (classSession.isActive) {
      return const Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: Colors.green,
        label: Text(
          'In Progress',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return const Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: Colors.blue,
        label: Text(
          'Upcoming',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      );
    }
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
        return Colors.teal;
    }
  }
}

class ClassSession {
  final String subject;
  final String teacher;
  final String room;
  final String startTime;
  final String endTime;
  final bool isCompleted;
  final bool isActive;
  final String? assignmentDue;
  final List<ClassMaterial> materials;

  ClassSession({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
    this.isActive = false,
    this.assignmentDue,
    this.materials = const [],
  });
}

class ClassMaterial {
  final String name;
  final String type;
  final String? url;

  ClassMaterial({
    required this.name,
    required this.type,
    this.url,
  });
}