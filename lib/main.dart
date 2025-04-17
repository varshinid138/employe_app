import 'package:flutter/material.dart';
import 'models/user.dart';
import 'services/api_service.dart';

void main() {
  runApp(const EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Directory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    try {
      final users = await ApiService.fetchUsers().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception("Request timed out");
        },
      );

      setState(() {
        _users = users;
        _filteredUsers = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Show error dialog
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to load users:\n${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  void _filterUsers(String query) {
    final filtered = _users
        .where((user) =>
            user.firstName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredUsers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Directory"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    onChanged: _filterUsers,
                    decoration: const InputDecoration(
                      hintText: 'Search by first name',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _filteredUsers.isEmpty
                        ? const Center(child: Text("No users found."))
                        : ListView.builder(
                            itemCount: _filteredUsers.length,
                            itemBuilder: (context, index) {
                              final user = _filteredUsers[index];
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.teal.shade100,
                                          child: Text(
                                            user.firstName[0],
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.teal),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${user.firstName} ${user.lastName}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(user.email),
                                            ],
                                          ),
                                        ),
                                        Text('ID: ${user.id}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
