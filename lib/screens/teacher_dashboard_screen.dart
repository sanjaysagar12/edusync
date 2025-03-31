import 'package:flutter/material.dart';
import '../widgets/class_timeline_widget.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  int _selectedIndex = 0;

  // Sample data
  final List<ClassSession> _todayClasses = [
    ClassSession(
      subject: 'Mathematics 101',
      teacher: 'You',
      room: 'Room 201',
      startTime: '8:30 AM',
      endTime: '9:20 AM',
      isCompleted: true,
      materials: [
        ClassMaterial(name: 'Lecture Notes', type: 'pdf'),
        ClassMaterial(name: 'Practice Problems', type: 'pdf'),
      ],
    ),
    ClassSession(
      subject: 'Mathematics 202',
      teacher: 'You',
      room: 'Lab 101',
      startTime: '9:30 AM',
      endTime: '10:20 AM',
      isCompleted: true,
      materials: [
        ClassMaterial(name: 'Advanced Calculus', type: 'pdf'),
        ClassMaterial(name: 'Solution Video', type: 'video'),
      ],
    ),
    ClassSession(
      subject: 'Office Hours',
      teacher: 'You',
      room: 'Office 105',
      startTime: '10:30 AM',
      endTime: '11:20 AM',
      isActive: true,
    ),
    ClassSession(
      subject: 'Lunch Break',
      teacher: '',
      room: 'Faculty Lounge',
      startTime: '11:30 AM',
      endTime: '12:20 PM',
      isActive: false,
    ),
    ClassSession(
      subject: 'Mathematics 301',
      teacher: 'You',
      room: 'Room 302',
      startTime: '12:30 PM',
      endTime: '1:20 PM',
      isActive: false,
      assignmentDue: 'Collect Final Project',
      materials: [
        ClassMaterial(name: 'Advanced Topics', type: 'pdf'),
        ClassMaterial(name: 'Weekly Quiz', type: 'quiz'),
      ],
    ),
    ClassSession(
      subject: 'Department Meeting',
      teacher: 'Faculty',
      room: 'Conference Room',
      startTime: '2:30 PM',
      endTime: '3:30 PM',
      isActive: false,
    ),
  ];

  final List<StudentTask> _pendingTasks = [
    StudentTask(
      title: 'Math 101 Quizzes',
      description: 'Grade weekly quizzes',
      dueDate: '2025-04-01',
      priority: TaskPriority.high,
    ),
    StudentTask(
      title: 'Math 202 Projects',
      description: 'Review mid-term projects',
      dueDate: '2025-04-03',
      priority: TaskPriority.medium,
    ),
    StudentTask(
      title: 'Prepare Lesson Plan',
      description: 'Next week\'s calculus topics',
      dueDate: '2025-04-05',
      priority: TaskPriority.low,
    ),
  ];

  final List<ClassStats> _classStats = [
    ClassStats(
      className: 'Mathematics 101',
      studentCount: 28,
      averageGrade: 'B+',
      completionRate: 92,
    ),
    ClassStats(
      className: 'Mathematics 202',
      studentCount: 24,
      averageGrade: 'B',
      completionRate: 87,
    ),
    ClassStats(
      className: 'Mathematics 301',
      studentCount: 18,
      averageGrade: 'A-',
      completionRate: 95,
    ),
  ];

  final List<StudentMessage> _studentMessages = [
    StudentMessage(
      studentName: 'Alex Johnson',
      message: 'Question about today\'s homework',
      time: '10:15 AM',
      isRead: false,
      avatar: 'AJ',
    ),
    StudentMessage(
      studentName: 'Emma Wilson',
      message: 'Will be absent tomorrow due to doctor\'s appointment',
      time: '9:32 AM',
      isRead: true,
      avatar: 'EW',
    ),
    StudentMessage(
      studentName: 'Noah Brown',
      message: 'Submitted my project early for feedback',
      time: 'Yesterday',
      isRead: true,
      avatar: 'NB',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Show profile
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboardTab(),
          _buildClassesTab(),
          _buildStudentsTab(),
          _buildResourcesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action based on current tab
          switch (_selectedIndex) {
            case 0: // Dashboard
              _showAddTaskDialog();
              break;
            case 1: // Classes
              _showAddClassDialog();
              break;
            case 2: // Students
              _showAddAnnouncementDialog();
              break;
            case 3: // Resources
              _showAddResourceDialog();
              break;
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_outlined),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Resources',
          ),
        ],
      ),
    );
  }

  // Dashboard Tab
  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            const Text(
              'Welcome, Professor Smith!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Current Date: 2025-03-31',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Quick Stats
            _buildStatsGrid(),
            const SizedBox(height: 24),

            // Pending Tasks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pending Tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // View all tasks
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ..._pendingTasks.map((task) => _buildTaskCard(task)),
            const SizedBox(height: 24),

            // Student Messages
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Messages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // View all messages
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ..._studentMessages.map((message) => _buildMessageCard(message)),
          ],
        ),
      ),
    );
  }

  // Classes Tab
  Widget _buildClassesTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Classes Header
            const Text(
              'Your Classes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Manage your classroom activities',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Class Stats
            ..._classStats.map((stats) => _buildClassStatsCard(stats)),
            const SizedBox(height: 24),

            // Weekly Schedule
            const Text(
              'Weekly Schedule',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildWeeklySchedule(),
            const SizedBox(height: 24),

            // Online Classes Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to online classes screen
              },
              icon: const Icon(Icons.video_call),
              label: const Text('Start Online Class'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Students Tab
  Widget _buildStudentsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Students Header
            const Text(
              'Your Students',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Manage student records and performance',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),

            // Class Selector
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Class',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Mathematics 101',
                  child: Text('Mathematics 101'),
                ),
                DropdownMenuItem(
                  value: 'Mathematics 202',
                  child: Text('Mathematics 202'),
                ),
                DropdownMenuItem(
                  value: 'Mathematics 301',
                  child: Text('Mathematics 301'),
                ),
              ],
              onChanged: (value) {
                // Change selected class
              },
            ),
            const SizedBox(height: 24),

            // Search and Filter Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search students...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Show filter options
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Student List
            _buildStudentList(),
            const SizedBox(height: 24),

            // Send Announcement Button
            ElevatedButton.icon(
              onPressed: () {
                _showAddAnnouncementDialog();
              },
              icon: const Icon(Icons.announcement),
              label: const Text('Send Announcement'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Resources Tab
  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resources Header
            const Text(
              'Teaching Resources',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Access and manage your teaching materials',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Resource Categories
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildResourceCategory(
                  'Lesson Plans',
                  Icons.description,
                  Colors.blue,
                  12,
                ),
                _buildResourceCategory(
                  'Worksheets',
                  Icons.assignment,
                  Colors.green,
                  28,
                ),
                _buildResourceCategory(
                  'Presentations',
                  Icons.slideshow,
                  Colors.orange,
                  9,
                ),
                _buildResourceCategory(
                  'Tests & Quizzes',
                  Icons.quiz,
                  Colors.purple,
                  17,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Resources
            const Text(
              'Recently Added Resources',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRecentResourcesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard('Classes Today', '5', Icons.class_outlined, Colors.blue),
        _buildStatCard('Students', '70', Icons.people_outline, Colors.green),
        _buildStatCard(
          'Pending Assignments',
          '12',
          Icons.assignment_outlined,
          Colors.orange,
        ),
        _buildStatCard('Messages', '3', Icons.message_outlined, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(StudentTask task) {
    Color priorityColor;
    IconData priorityIcon;

    switch (task.priority) {
      case TaskPriority.high:
        priorityColor = Colors.red;
        priorityIcon = Icons.priority_high;
        break;
      case TaskPriority.medium:
        priorityColor = Colors.orange;
        priorityIcon = Icons.error_outline;
        break;
      case TaskPriority.low:
      default:
        priorityColor = Colors.blue;
        priorityIcon = Icons.info_outline;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(priorityIcon, color: priorityColor),
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${task.description} • Due: ${task.dueDate}'),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () {
            // Mark task as completed
          },
        ),
      ),
    );
  }

  Widget _buildMessageCard(StudentMessage message) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(message.avatar),
          backgroundColor: message.isRead ? Colors.grey[300] : Colors.blue[100],
        ),
        title: Text(
          message.studentName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message.message),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.time,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            if (!message.isRead)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        onTap: () {
          // Open message details
        },
      ),
    );
  }

  Widget _buildClassStatsCard(ClassStats stats) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stats.className,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Show options
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildClassStat(
                  'Students',
                  stats.studentCount.toString(),
                  Icons.people,
                ),
                _buildClassStat('Avg. Grade', stats.averageGrade, Icons.grade),
                _buildClassStat(
                  'Completion',
                  '${stats.completionRate}%',
                  Icons.check_circle,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: stats.completionRate / 100,
              backgroundColor: Colors.grey[200],
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // View class details
                  },
                  icon: const Icon(Icons.visibility),
                  label: const Text('View'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Open class
                  },
                  icon: const Icon(Icons.class_),
                  label: const Text('Enter Class'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassStat(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildWeeklySchedule() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildDaySchedule('Mon', '3 Classes'),
          _buildDaySchedule('Tue', '2 Classes'),
          _buildDaySchedule('Wed', '3 Classes'),
          _buildDaySchedule('Thu', '2 Classes'),
          _buildDaySchedule('Fri', '1 Class'),
        ],
      ),
    );
  }

  Widget _buildDaySchedule(String day, String classes) {
    bool isToday = day == 'Mon'; // Assume Monday is today

    return Container(
      width: 100,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isToday ? Colors.blue.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
        border: isToday ? Border.all(color: Colors.blue) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              color: isToday ? Colors.blue : null,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday ? Colors.blue : Colors.grey[300],
            ),
            child: Center(
              child: Text(
                day.substring(0, 1),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            classes,
            style: TextStyle(
              fontSize: 12,
              color: isToday ? Colors.blue : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    final List<Map<String, dynamic>> students = [
      {
        'name': 'Alex Johnson',
        'email': 'alex.j@university.edu',
        'avatar': 'AJ',
        'grade': 'A',
      },
      {
        'name': 'Emma Wilson',
        'email': 'e.wilson@university.edu',
        'avatar': 'EW',
        'grade': 'B+',
      },
      {
        'name': 'Noah Brown',
        'email': 'noah.b@university.edu',
        'avatar': 'NB',
        'grade': 'A-',
      },
      {
        'name': 'Sophia Davis',
        'email': 's.davis@university.edu',
        'avatar': 'SD',
        'grade': 'B',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text(student['avatar'])),
            title: Text(
              student['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(student['email']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        student['grade'].startsWith('A')
                            ? Colors.green[100]
                            : Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    student['grade'],
                    style: TextStyle(
                      color:
                          student['grade'].startsWith('A')
                              ? Colors.green[800]
                              : Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Show student options
                  },
                ),
              ],
            ),
            onTap: () {
              // View student details
            },
          ),
        );
      },
    );
  }

  Widget _buildResourceCategory(
    String title,
    IconData icon,
    Color color,
    int count,
  ) {
    return InkWell(
      onTap: () {
        // Open resource category
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '$count items',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentResourcesList() {
    final List<Map<String, dynamic>> resources = [
      {
        'name': 'Introduction to Calculus',
        'type': 'pdf',
        'size': '2.3 MB',
        'date': '2025-03-28',
      },
      {
        'name': 'Mid-term Exam',
        'type': 'docx',
        'size': '1.8 MB',
        'date': '2025-03-25',
      },
      {
        'name': 'Algebra Basics',
        'type': 'pptx',
        'size': '4.5 MB',
        'date': '2025-03-22',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resource = resources[index];
        IconData icon;
        Color color;

        switch (resource['type']) {
          case 'pdf':
            icon = Icons.picture_as_pdf;
            color = Colors.red;
            break;
          case 'docx':
            icon = Icons.description;
            color = Colors.blue;
            break;
          case 'pptx':
            icon = Icons.slideshow;
            color = Colors.orange;
            break;
          default:
            icon = Icons.insert_drive_file;
            color = Colors.grey;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            title: Text(
              resource['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${resource['type'].toUpperCase()} • ${resource['size']} • ${resource['date']}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Show resource options
              },
            ),
            onTap: () {
              // Open resource
            },
          ),
        );
      },
    );
  }

  // Dialog methods
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Due Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'high', child: Text('High')),
                    DropdownMenuItem(value: 'medium', child: Text('Medium')),
                    DropdownMenuItem(value: 'low', child: Text('Low')),
                  ],
                  onChanged: (value) {
                    // Set priority
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add task logic
              },
              child: const Text('Add Task'),
            ),
          ],
        );
      },
    );
  }

  void _showAddClassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Class'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Class Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Room Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Days of Week',
                    border: OutlineInputBorder(),
                    hintText: 'e.g. Mon, Wed, Fri',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add class logic
              },
              child: const Text('Add Class'),
            ),
          ],
        );
      },
    );
  }

  void _showAddAnnouncementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Announcement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Send To',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Classes')),
                    DropdownMenuItem(
                      value: 'math101',
                      child: Text('Mathematics 101'),
                    ),
                    DropdownMenuItem(
                      value: 'math202',
                      child: Text('Mathematics 202'),
                    ),
                    DropdownMenuItem(
                      value: 'math301',
                      child: Text('Mathematics 301'),
                    ),
                  ],
                  onChanged: (value) {
                    // Set recipient class
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {
                        // Toggle send email copy
                      },
                    ),
                    const Text('Send email copy to students'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Send announcement logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Announcement sent successfully!'),
                  ),
                );
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _showAddResourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Resource'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Resource Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Resource Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'lesson',
                      child: Text('Lesson Plan'),
                    ),
                    DropdownMenuItem(
                      value: 'worksheet',
                      child: Text('Worksheet'),
                    ),
                    DropdownMenuItem(
                      value: 'presentation',
                      child: Text('Presentation'),
                    ),
                    DropdownMenuItem(value: 'quiz', child: Text('Quiz/Test')),
                  ],
                  onChanged: (value) {
                    // Set resource type
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Associated Class',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'none', child: Text('None')),
                    DropdownMenuItem(
                      value: 'math101',
                      child: Text('Mathematics 101'),
                    ),
                    DropdownMenuItem(
                      value: 'math202',
                      child: Text('Mathematics 202'),
                    ),
                    DropdownMenuItem(
                      value: 'math301',
                      child: Text('Mathematics 301'),
                    ),
                  ],
                  onChanged: (value) {
                    // Set associated class
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    // Upload file
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload File'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add resource logic
              },
              child: const Text('Add Resource'),
            ),
          ],
        );
      },
    );
  }
}

// Models
class ClassSession {
  final String subject;
  final String teacher;
  final String room;
  final String startTime;
  final String endTime;
  final bool isCompleted;
  final bool isActive;
  final String? assignmentDue;
  final List<ClassMaterial>? materials;

  ClassSession({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
    this.isActive = false,
    this.assignmentDue,
    this.materials,
  });
}

class ClassMaterial {
  final String name;
  final String type;

  ClassMaterial({required this.name, required this.type});
}

enum TaskPriority { high, medium, low }

class StudentTask {
  final String title;
  final String description;
  final String dueDate;
  final TaskPriority priority;

  StudentTask({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });
}

class ClassStats {
  final String className;
  final int studentCount;
  final String averageGrade;
  final int completionRate;

  ClassStats({
    required this.className,
    required this.studentCount,
    required this.averageGrade,
    required this.completionRate,
  });
}

class StudentMessage {
  final String studentName;
  final String message;
  final String time;
  final bool isRead;
  final String avatar;

  StudentMessage({
    required this.studentName,
    required this.message,
    required this.time,
    required this.isRead,
    required this.avatar,
  });
}
