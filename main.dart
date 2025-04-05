import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade700
                          .withOpacity(sin(_controller.value * pi)),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to NOTEIT',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black45,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tasks made simple. Life made easier.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const Text(
                    'Start checking off your to-dos today!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AuthPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Let's Start",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late AnimationController _controller;
  final TextEditingController _emailController =
      TextEditingController(text: 'mugeshwaran@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456789');
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _handleAuth() {
    if (isLogin) {
      // Handle login
      if (_emailController.text == 'mugeshwaran@gmail.com' &&
          _passwordController.text == '123456789') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NoteItApp()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    } else {
      // Handle sign up
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
      // In a real app, you would create the user account here
      // For now, just log them in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NoteItApp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade700
                          .withOpacity(sin(_controller.value * pi)),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'NoteIt',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black45,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      prefixIcon:
                          Icon(Icons.email, color: Colors.blue.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.blue.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (!isLogin) ...[
                    const SizedBox(height: 15),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirm Password',
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.blue.shade900),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _handleAuth,
                      child: Text(
                        isLogin ? 'Login' : 'Sign Up',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLogin
                            ? "Don't have an account?"
                            : "Already have an account?",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: toggleForm,
                        child: Text(
                          isLogin ? 'Sign Up' : 'Login',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoteItApp extends StatelessWidget {
  const NoteItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteIt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          brightness: Brightness.light,
        ).copyWith(
          secondary: Colors.blueAccent,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF0A2463),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 4,
          backgroundColor: Color(0xFF3E92CC),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0A2463),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          elevation: 8,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Task {
  String id;
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  bool isCompleted;
  bool isImportant;
  DateTime? completionTime;

  Task({
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,
    this.isImportant = false,
    this.completionTime,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();

  DateTime get fullDateTime {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Task> _tasks = [];
  final List<Task> _historyTasks = [];

  List<Task> get _activeTasks {
    return _tasks.where((task) => !task.isCompleted).toList()
      ..sort((a, b) => a.fullDateTime.compareTo(b.fullDateTime));
  }

  List<Task> get _completedTasks {
    return _tasks.where((task) => task.isCompleted).toList()
      ..sort((a, b) => (b.completionTime ?? DateTime.now())
          .compareTo(a.completionTime ?? DateTime.now()));
  }

  void clearCompletedTasks() {
    setState(() {
      _tasks.removeWhere((task) => task.isCompleted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteIt'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: const Color(0xFF0A2463),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        elevation: 8,
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TaskCreationPage()),
                );
                if (newTask != null) {
                  setState(() {
                    _tasks.add(newTask);
                  });
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add, size: 32),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0: // Home
        return _buildHomePage();
      case 1: // History
        return _buildHistoryPage();
      case 2: // Profile
        return ProfilePage(clearHistoryCallback: clearCompletedTasks);
      default:
        return Container();
    }
  }

  Widget _buildHomePage() {
    return _activeTasks.isEmpty
        ? const Center(
            child: Text(
              'No active tasks. Tap + to create one!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: _activeTasks.length,
            itemBuilder: (context, index) {
              final task = _activeTasks[index];
              return _buildTaskItem(task);
            },
          );
  }

  Widget _buildHistoryPage() {
    return _completedTasks.isEmpty
        ? const Center(
            child: Text(
              'No completed tasks yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: _completedTasks.length,
            itemBuilder: (context, index) {
              final task = _completedTasks[index];
              return _buildHistoryItem(task);
            },
          );
  }

  Widget _buildTaskItem(Task task) {
    return Dismissible(
      key: Key(task.id),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        _moveTaskToHistory(task);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  setState(() {
                    task.isCompleted = value ?? false;
                    task.completionTime = DateTime.now();
                    _moveTaskToHistory(task);
                  });
                },
                activeColor: Colors.green,
              ),
              IconButton(
                icon: Icon(
                  task.isImportant ? Icons.star : Icons.star_border,
                  color: task.isImportant ? Colors.amber : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    task.isImportant = !task.isImportant;
                  });
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${DateFormat('MMM dd, yyyy').format(task.date)} • ${task.time.format(context)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Task task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  task.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Completed on: ${DateFormat('MMM dd, yyyy - hh:mm a').format(task.completionTime ?? DateTime.now())}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            if (task.isImportant)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Important',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _moveTaskToHistory(Task task) {
    setState(() {
      if (task.isCompleted) {
        task.completionTime = DateTime.now();
      }
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class TaskCreationPage extends StatefulWidget {
  const TaskCreationPage({super.key});

  @override
  _TaskCreationPageState createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends State<TaskCreationPage> {
  final _formKey = GlobalKey<FormState>();
  String _taskName = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _description = '';
  bool _isImportant = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter task name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
                onSaved: (value) => _taskName = value!,
              ),
              const SizedBox(height: 20),
              const Text(
                'Date & Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          DateFormat('MMM dd, yyyy').format(_selectedDate),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _selectedTime.format(context),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter task description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isImportant,
                    onChanged: (value) {
                      setState(() {
                        _isImportant = value ?? false;
                      });
                    },
                  ),
                  const Text('Mark as important'),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final newTask = Task(
                        name: _taskName,
                        description: _description,
                        date: _selectedDate,
                        time: _selectedTime,
                        isImportant: _isImportant,
                      );
                      Navigator.pop(context, newTask);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Text('Create Task', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final VoidCallback clearHistoryCallback;

  const ProfilePage({super.key, required this.clearHistoryCallback});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String _name = 'Your Name';
  String _email = 'mugeshwaran@gmail.com';
  String _mobileNumber = '';
  String _selectedLanguage = 'English';

  String? _editingField;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _image = null;
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await showDialog<XFile>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Profile Picture'),
          content: Text('Choose how to update your profile picture'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context,
                    await _picker.pickImage(source: ImageSource.gallery));
              },
              child: Text('Gallery'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context,
                    await _picker.pickImage(source: ImageSource.camera));
              },
              child: Text('Camera'),
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _startEditing(String field) {
    setState(() {
      _editingField = field;
      switch (field) {
        case 'name':
          _nameController.text = _name;
          break;
        case 'email':
          _emailController.text = _email;
          break;
        case 'mobile':
          _mobileController.text = _mobileNumber;
          break;
      }
    });
  }

  void _saveEditing() {
    setState(() {
      switch (_editingField) {
        case 'name':
          _name = _nameController.text;
          break;
        case 'email':
          _email = _emailController.text;
          break;
        case 'mobile':
          _mobileNumber = _mobileController.text;
          break;
      }
      _editingField = null;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          theme.colorScheme.primary.withOpacity(0.1),
                      backgroundImage: _image != null
                          ? kIsWeb
                              ? NetworkImage('https://via.placeholder.com/150')
                              : FileImage(_image!) as ImageProvider
                          : NetworkImage('https://via.placeholder.com/150'),
                      child: _image == null
                          ? Icon(Icons.person,
                              size: 50, color: theme.colorScheme.primary)
                          : null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit, size: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _startEditing('name'),
                      child: _editingField == 'name'
                          ? _buildEditField(
                              controller: _nameController,
                              icon: Icons.person_outline,
                              onSave: _saveEditing,
                            )
                          : _buildDisplayField(
                              label: 'Full Name',
                              value: _name,
                              icon: Icons.person_outline,
                            ),
                    ),
                    Divider(height: 20, thickness: 0.5),
                    GestureDetector(
                      onTap: () => _startEditing('email'),
                      child: _editingField == 'email'
                          ? _buildEditField(
                              controller: _emailController,
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              onSave: _saveEditing,
                            )
                          : _buildDisplayField(
                              label: 'Email Address',
                              value: _email,
                              icon: Icons.email_outlined,
                            ),
                    ),
                    Divider(height: 20, thickness: 0.5),
                    GestureDetector(
                      onTap: () => _startEditing('mobile'),
                      child: _editingField == 'mobile'
                          ? _buildEditField(
                              controller: _mobileController,
                              icon: Icons.phone_iphone_outlined,
                              keyboardType: TextInputType.phone,
                              prefixText: '+1 ',
                              onSave: _saveEditing,
                            )
                          : _buildDisplayField(
                              label: 'Phone Number',
                              value: _mobileNumber.isEmpty
                                  ? 'Add phone number'
                                  : _mobileNumber,
                              icon: Icons.phone_iphone_outlined,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.language_outlined,
                          color: theme.colorScheme.primary),
                    ),
                    title: Text('App Language'),
                    subtitle: Text(_selectedLanguage),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    'Select Language',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(height: 1),
                                RadioListTile(
                                  title: Text('English'),
                                  value: 'English',
                                  groupValue: _selectedLanguage,
                                  onChanged: (value) {
                                    _changeLanguage(value.toString());
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  title: Text('Español'),
                                  value: 'Spanish',
                                  groupValue: _selectedLanguage,
                                  onChanged: (value) {
                                    _changeLanguage(value.toString());
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  title: Text('Français'),
                                  value: 'French',
                                  groupValue: _selectedLanguage,
                                  onChanged: (value) {
                                    _changeLanguage(value.toString());
                                    Navigator.pop(context);
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                      );
                    },
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.credit_card_outlined,
                          color: theme.colorScheme.primary),
                    ),
                    title: Text('Subscription Plan'),
                    subtitle: Text('Free Plan'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.history_outlined, color: Colors.grey),
                    ),
                    title: Text('Clear History'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Clear History?'),
                            content: Text(
                                'This will permanently delete your completed tasks history.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.clearHistoryCallback();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('History cleared successfully'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Text('Clear',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.logout_outlined, color: Colors.red),
                    ),
                    title: Text('Logout', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Logout?'),
                            content: Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()),
                                  );
                                },
                                child: Text('Logout',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color:
                Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
        ),
        SizedBox(height: 4),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon,
              size: 24, color: Theme.of(context).colorScheme.primary),
          title: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.edit_outlined, size: 18),
          minLeadingWidth: 0,
        ),
      ],
    );
  }

  Widget _buildEditField({
    required TextEditingController controller,
    required IconData icon,
    required VoidCallback onSave,
    TextInputType? keyboardType,
    String? prefixText,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Edit',
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        prefixText: prefixText,
        suffixIcon: IconButton(
          icon: Icon(Icons.check_circle,
              color: Theme.of(context).colorScheme.primary),
          onPressed: onSave,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
