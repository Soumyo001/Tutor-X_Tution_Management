import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({super.key});

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
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
