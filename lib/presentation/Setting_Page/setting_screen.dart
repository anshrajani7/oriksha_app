import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Setting_Page/controller/setting_controller.dart';

import '../../widget/custom_pdf_viewer.dart';

class SettingScreen extends GetView<SettingScreenController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          text: AppString.setting.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => Column(
            children: [
              Gap(h(context, 20)),
              CustomElevatedButton(
                onPressed: ()async {
                  var isPassenger= await Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger)??false;
                  if(!isPassenger) {
                    Get.toNamed(AppRoutes.myBankDetailsScreenRoutes);
                  }
                },
                icon: AppImage.arrow,
                // Replace with another asset image path
                buttonName: AppString.myBankDetailsQRCode.tr,
              ),

              Gap(h(context, 20)),
              // Adjust spacing between buttons as needed
              CustomElevatedButton(
                onPressed: () {},
                icon: AppImage.arrow,
                // Replace with another asset image path
                buttonName: AppString.myRewardsAndGifts.tr,
              ),
              Gap(h(context, 20)),
              CustomElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.transactionListScreenRoutes);
                },
                icon: AppImage.arrow,
                // Replace with another asset image path
                buttonName: AppString.rideHistory.tr,
              ),
              Gap(h(context, 20)),
              CustomElevatedButton(
                onPressed: () {
                  controller.isDropdownOpen.toggle();
                },
                buttonName: AppString.feedBack.tr,
                icon: AppImage.arrow,
              ),
              if (controller.isDropdownOpen.isTrue)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      for (String option in controller.options)
                        ListTile(
                          title: Text(option),
                          onTap: () {
                            controller.selectedValue.value = option;
                            if (controller.selectedValue.value ==
                                'The Feedback I Gave') {
                              Get.toNamed(AppRoutes.postFeedBackScreenRoutes);
                              controller.isDropdownOpen.value = false;
                            } else if (controller.selectedValue.value ==
                                'The Feedback I Received') {
                              controller.isDropdownOpen.value = false;
                            }
                          },
                        ),
                    ],
                  ),
                ),
              // Adjust spacing between buttons as needed
              Gap(h(context, 20)),
              // Adjust spacing between buttons as needed
              CustomElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.legalScreenRoutes);
                },
                icon: AppImage.arrow,
                // Replace with another asset image path
                buttonName: AppString.legal.tr,
              ),
              Gap(h(context, 20)),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PdfViewScreen(title: 'Company Document', finaleParth: 'assets/app_image/3_Privacy Policy.pdf', fileName: 'sample3.pdf',)),
                  );
                },
                icon: AppImage.arrow,
                // Replace with another asset image path
                buttonName: AppString.companysDocument.tr,
              ),
              Gap(h(context, 20)),
              CustomElevatedButton(
                onPressed: () {
                  controller.logOut();
                },
                icon: AppImage.arrow,
                // Replace with another asset image path
                buttonName: AppString.logOut.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
