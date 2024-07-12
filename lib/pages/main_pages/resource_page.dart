import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({super.key});

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
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
