import 'package:flutter/material.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample child data
    final List<ChildInfo> children = [
      ChildInfo(
        name: 'Emma Johnson',
        grade: '5th Grade',
        teacher: 'Mr. Williams',
        photo: 'assets/images/avatar_girl.png',
        attendance: 96,
        overallGrade: 'A-',
      ),
      ChildInfo(
        name: 'Michael Johnson',
        grade: '3rd Grade',
        teacher: 'Ms. Davis',
        photo: 'assets/images/avatar_boy.png',
        attendance: 92,
        overallGrade: 'B+',
      ),
    ];

    // Sample announcements
    final List<Announcement> announcements = [
      Announcement(
        title: 'Parent-Teacher Conference',
        date: '2025-04-15',
        description: 'Annual parent-teacher conferences will be held next week.',
        priority: AnnouncementPriority.high,
      ),
      Announcement(
        title: 'School Picnic',
        date: '2025-04-25',
        description: 'Annual school picnic at Central Park.',
        priority: AnnouncementPriority.medium,
      ),
      Announcement(
        title: 'Book Fair',
        date: '2025-05-10',
        description: 'Annual book fair in the school library.',
        priority: AnnouncementPriority.low,
      ),
    ];

    // Sample upcoming events
    final List<UpcomingEvent> events = [
      UpcomingEvent(
        title: 'Math Test',
        date: '2025-04-05',
        childName: 'Emma Johnson',
        subject: 'Mathematics',
      ),
      UpcomingEvent(
        title: 'Science Fair',
        date: '2025-04-12',
        childName: 'Emma Johnson',
        subject: 'Science',
      ),
      UpcomingEvent(
        title: 'Reading Assignment',
        date: '2025-04-08',
        childName: 'Michael Johnson',
        subject: 'Language Arts',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              const Text(
                'Welcome, Mrs. Johnson!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Current Date: 2025-03-31',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              
              // Children selector
              const Text(
                'Your Children',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    return _buildChildCard(children[index], context);
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // Currently selected child overview
              _buildChildOverview(children[0]),
              const SizedBox(height: 24),
              
              // Announcements
              const Text(
                'School Announcements',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return _buildAnnouncementCard(announcements[index]);
                },
              ),
              const SizedBox(height: 24),
              
              // Upcoming events
              const Text(
                'Upcoming Events & Assignments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(events[index]);
                },
              ),
              const SizedBox(height: 24),
              
              // Parent actions
              _buildParentActionsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard(ChildInfo child, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Switch to selected child's data
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                child.name.split(' ').map((e) => e[0]).join(''),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              child.name.split(' ')[0],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              child.grade,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildOverview(ChildInfo child) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    child.name.split(' ').map((e) => e[0]).join(''),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${child.grade} • ${child.teacher}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // View detailed report
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('View Report'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Overall Grade', child.overallGrade, Colors.green),
                _buildStatVerticalDivider(),
                _buildStatItem('Attendance', '${child.attendance}%', Colors.orange),
                _buildStatVerticalDivider(),
                _buildStatItem('Completed Tasks', '24/30', Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildAnnouncementCard(Announcement announcement) {
    Color priorityColor;
    IconData priorityIcon;
    
    switch (announcement.priority) {
      case AnnouncementPriority.high:
        priorityColor = Colors.red;
        priorityIcon = Icons.priority_high;
        break;
      case AnnouncementPriority.medium:
        priorityColor = Colors.orange;
        priorityIcon = Icons.announcement;
        break;
      case AnnouncementPriority.low:
      default:
        priorityColor = Colors.blue;
        priorityIcon = Icons.info_outline;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(priorityIcon, color: priorityColor),
        title: Text(
          announcement.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${announcement.date} • ${announcement.description}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Show announcement details
        },
      ),
    );
  }

  Widget _buildEventCard(UpcomingEvent event) {
    Color subjectColor;
    
    switch (event.subject.toLowerCase()) {
      case 'mathematics':
        subjectColor = Colors.blue;
        break;
      case 'science':
        subjectColor = Colors.green;
        break;
      case 'language arts':
        subjectColor = Colors.purple;
        break;
      default:
        subjectColor = Colors.orange;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: subjectColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text(
          event.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${event.date} • ${event.childName}'),
        trailing: Chip(
          backgroundColor: subjectColor.withOpacity(0.1),
          label: Text(
            event.subject,
            style: TextStyle(
              color: subjectColor,
              fontSize: 12,
            ),
          ),
        ),
        onTap: () {
          // Show event details
        },
      ),
    );
  }

  Widget _buildParentActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(child: _buildActionButton('Contact Teacher', Icons.message, Colors.green)),
            const SizedBox(width: 12),
            Expanded(child: _buildActionButton('Report Absence', Icons.calendar_today, Colors.orange)),
          ],
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(child: _buildActionButton('Pay Fees', Icons.payment, Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _buildActionButton('School Resources', Icons.book, Colors.purple)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        alignment: Alignment.centerLeft,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.2)),
        ),
      ),
    );
  }
}

class ChildInfo {
  final String name;
  final String grade;
  final String teacher;
  final String photo;
  final int attendance;
  final String overallGrade;

  ChildInfo({
    required this.name,
    required this.grade,
    required this.teacher,
    required this.photo,
    required this.attendance,
    required this.overallGrade,
  });
}

enum AnnouncementPriority {
  high,
  medium,
  low,
}

class Announcement {
  final String title;
  final String date;
  final String description;
  final AnnouncementPriority priority;

  Announcement({
    required this.title,
    required this.date,
    required this.description,
    required this.priority,
  });
}

class UpcomingEvent {
  final String title;
  final String date;
  final String childName;
  final String subject;

  UpcomingEvent({
    required this.title,
    required this.date,
    required this.childName,
    required this.subject,
  });
}