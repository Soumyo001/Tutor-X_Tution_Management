import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: const Column(
        children: [
          NavigationPanel(),
        ],
      ),
    );
  }
}
