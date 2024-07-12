import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
