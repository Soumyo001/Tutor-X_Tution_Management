import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_x_tution_management/pages/setup%20pages/student/student_info_page.dart';
import 'package:tutor_x_tution_management/pages/setup%20pages/student/student_info_page_1.dart';

class StudentWalk extends StatefulWidget {
  final String firstName, lastName, email, password, phoneNumber;
  const StudentWalk({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  @override
  State<StudentWalk> createState() => _StudentWalkState();
}

class _StudentWalkState extends State<StudentWalk> {
  late final TextEditingController _educationController, _locationController;
  final PageController _pageController = PageController();

  List<Widget> _buildPages() => [
        StudentInfo(
          change: _changePage,
          educationController: _educationController,
          locationController: _locationController,
        ),
        StudentInfo1(
          change: _changePage,
          educationController: _educationController,
          locationController: _locationController,
          firstName: widget.firstName,
          lastName: widget.lastName,
          email: widget.email,
          password: widget.password,
          phoneNumber: widget.phoneNumber,
        ),
      ];

  void _changePage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _educationController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400.withAlpha(150),
                    spreadRadius: 1,
                    blurRadius: 16,
                    offset: const Offset(5, 5),
                  ),
                  BoxShadow(
                    color: Colors.grey.shade400.withAlpha(150),
                    spreadRadius: 1,
                    blurRadius: 16,
                    offset: const Offset(-5, 5),
                  ),
                ],
              ),
              width: currentSize.width / 2,
              child: Column(
                children: [
                  Lottie.network(
                    'https://lottie.host/ac73cae1-5b19-42d2-a346-8206be8f61c5/pv8i2EcrQo.json',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'Hold tight! Your\'e almost there',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Gap(25),
                  SizedBox(
                    height: currentSize.height / 3,
                    child: PageView.builder(
                      itemCount: _buildPages().length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return _buildPages()[index];
                      },
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
}
