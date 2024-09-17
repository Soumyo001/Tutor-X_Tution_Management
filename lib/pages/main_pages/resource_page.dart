// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/input_box2.dart';
import 'package:tutor_x_tution_management/components/just_icon.dart';
import 'package:tutor_x_tution_management/controllers/resource_controller.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/models/resource.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';
import 'package:tutor_x_tution_management/service/api/resource_api.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({super.key});

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  late final TextEditingController _url;
  late final ResourceController _resourceController;
  late final UserStaticsController _userStaticsController;
  late final TextEditingController _title;
  late final TextEditingController _desc;

  @override
  void initState() {
    super.initState();
    _resourceController = Get.find<ResourceController>();
    _userStaticsController = Get.find<UserStaticsController>();
    _url = TextEditingController();
    _title = TextEditingController();
    _desc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          const NavigationPanel(),
          const Gap(15),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Expanded(
                  child: InputBox2(
                    hintText: 'Add a link',
                    controller: _url,
                    fontSize: 15,
                    maxLength: null,
                    maxLines: 1,
                    customColor: Colors.grey.shade600,
                    customFocusColor: Colors.grey.shade400,
                  ),
                ),
                const Gap(3),
                JustIcon(
                  icon: Icons.add_link,
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  JustIcon(
                                    icon: Icons.close,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                              const Gap(5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InputBox2(
                                  hintText: 'Resource Title',
                                  controller: _title,
                                  fontSize: 15,
                                  maxLength: null,
                                  maxLines: 1,
                                  customColor: Colors.grey.shade600,
                                  customFocusColor: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                          content: SizedBox(
                            width: screenSize.width * 0.4,
                            height: screenSize.height * 0.2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InputBox2(
                                  hintText: 'Description',
                                  controller: _desc,
                                  alternativeColor: true,
                                  disableMaxLengthAndLines: false,
                                  maxLength: null,
                                  maxLines: 5,
                                ),
                                const Gap(15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ButtonIcon(
                                      icon: Icons.send,
                                      onPressed: () async {
                                        final resource = Resource(
                                          resourceId: 0,
                                          userId: _userStaticsController.userId,
                                          resourceTitle: _title.text,
                                          resourceDescription: _desc.text,
                                          resourceUrl: _url.text,
                                          resourceUploadDate:
                                              DateTime.now().toString(),
                                        );
                                        final response =
                                            await ResourceApi().postResource(
                                          requestBody: resource.toJson(),
                                        );
                                        if (response.statusCode >= 200 &&
                                            response.statusCode <= 299) {
                                          _resourceController.resources
                                              .add(resource);
                                        } else {
                                          await showErrorDialog(context,
                                              'There was a problem uploading your url');
                                        }
                                      },
                                      enableIcon: true,
                                      loading: false,
                                      label: 'Submit',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder(
              future: ResourceApi().getAllResource(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  _resourceController.resources =
                      snapshot.data as List<Resource>;
                  return Obx(
                    () {
                      if (_resourceController.resources.isNotEmpty) {
                        return Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            itemCount: _resourceController.resources.length,
                            itemBuilder: (context, index) {
                              final res = _resourceController.resources[index];
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: InkWell(
                                  onTap: () async {
                                    final url = Uri.parse(res.resourceUrl);
                                    if (!await launchUrl(url)) {
                                      await showErrorDialog(
                                          context, 'Could not launch url');
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.black12.withAlpha(15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.bold,
                                              color: Pallete.gradiant9,
                                            ),
                                          ),
                                        ),
                                        const Gap(5),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              res.resourceTitle,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Pallete.gradiant9,
                                              ),
                                            ),
                                            const Gap(3),
                                            Text(
                                              res.resourceDescription,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'It\'s quiet right now...'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 3,
                            ),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
