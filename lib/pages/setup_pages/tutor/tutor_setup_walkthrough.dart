import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/pages/setup_pages/tutor/tutor_info_page.dart';
import 'package:tutor_x_tution_management/pages/setup_pages/tutor/tutor_info_page3.dart';
import 'package:tutor_x_tution_management/pages/setup_pages/tutor/tutor_info_page_2.dart';

class TutorSetupWalk extends StatefulWidget {
  final String fullName, phoneNumber, email, password;
  final ProfessionType professionType;
  const TutorSetupWalk({
    super.key,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.professionType,
  });

  @override
  State<TutorSetupWalk> createState() => _TutorSetupWalkState();
}

class _TutorSetupWalkState extends State<TutorSetupWalk> {
  final PageController _pageController = PageController();
  late final TextEditingController _educationController;
  late final TextEditingController _locationController;
  late final TextEditingController _salaryController;

  @override
  void initState() {
    super.initState();
    _educationController = TextEditingController();
    _locationController = TextEditingController();
    _salaryController = TextEditingController();
  }

  List<Widget> _buildPages() => [
        TutorInfo(
          change: _changePage,
          educationController: _educationController,
          locationController: _locationController,
          salaryController: _salaryController,
        ),
        TutorInfo1(change: _changePage),
        TutorInfo2(
          change: _changePage,
          fullName: widget.fullName,
          phoneNumber: widget.phoneNumber,
          email: widget.email,
          password: widget.password,
          professionType: widget.professionType,
          educationController: _educationController,
          locationController: _locationController,
          salaryController: _salaryController,
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
  Widget build(BuildContext context) {
    final currentWith = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              width: currentWith.width / 2,
              child: Column(
                children: [
                  Lottie.network(
                    'https://lottie.host/ac73cae1-5b19-42d2-a346-8206be8f61c5/pv8i2EcrQo.json',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'Just a few clicks away!',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Gap(25),
                  SizedBox(
                    height: 320,
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
