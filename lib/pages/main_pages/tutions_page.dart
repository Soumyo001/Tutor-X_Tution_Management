import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';

class TutionsPage extends StatefulWidget {
  const TutionsPage({super.key});

  @override
  State<TutionsPage> createState() => _TutionsPageState();
}

class _TutionsPageState extends State<TutionsPage> {
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
