import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tutor_x_tution_management/pages/dashboard_home/dashboard_ui.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          const NavigationPanel(),
          Expanded(
            child: ScrollTransformView(
              children: [
                ScrollTransformItem(
                  builder: (scrollOffset) => const DashBoard(),
                ),
                ScrollTransformItem(
                  builder: (scrollOffset) => Container(
                    height: 100,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
