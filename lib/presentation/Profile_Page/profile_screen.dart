import 'dart:io';
import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Profile_Page/controller/profile_controller.dart';
import 'package:oriksha_application/widget/custom_choseFile_Button.dart';
import 'package:flutter/cupertino.dart';
import '../../widget/custom_image_picker.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h(context, 170),
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: h(context, 100),
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: ColorConstant.primaryOrg,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: h(context, 15),
                    child:  Column(
                        children: [
                          imageCircle(context),
                          Gap(h(context, 12)),
                          Text(
                              controller.nameController.text,
                              style: AppStyle.style(f(context, 22),
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),

                  ),
                  // InkWell(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           backgroundColor: ColorConstant.primaryOrg,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //           ),
                  //           title: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 '🚀 Welcome!',
                  //                 style: AppStyle.style(f(context, 24),
                  //                     fontColor: ColorConstant.primaryWhite,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //               IconButton(
                  //                 onPressed: () {
                  //                   Get.back();
                  //                 },
                  //                 icon: const Icon(
                  //                   Icons.close,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           content: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Center(
                  //                 child: Lottie.asset(
                  //                   'assets/anim4.json',
                  //                   height: h(context, 100),
                  //                   width: w(context, 100),
                  //                 ),
                  //               ),
                  //               Text(
                  //                 '🎉 Login Successful!',
                  //                 style: AppStyle.style(f(context, 20),
                  //                     fontColor: ColorConstant.primaryWhite,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //               Gap(h(context, 16)),
                  //               Text(
                  //                 '🛺 Welcome to O Riksha!\n  Your journey begins now.🚀',
                  //                 textAlign: TextAlign.center,
                  //                 style: AppStyle.style(f(context, 15),
                  //                     fontColor: ColorConstant.primaryWhite),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: Text("mihir"),
                  // )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w(context, 22)),
              child: Column(
                children: [
                  Gap(h(context, 30)),
                  Obx(
                    ()=> CustomTextFormField(
                      controller: controller.nameController,
                      prefixIcon: const Icon(Icons.person,color: ColorConstant.primaryBlack,size: 28,),
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      hintText: controller.name.isEmpty?AppString.fullName.tr:controller.name.value,
                    ),
                  ),
                  Gap(h(context, 15)),
                  CustomChooseFile(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      CustomGalleryDialog.instance.CustomCupertinoBottomDilouge(
                        firstText: AppString.gallery.tr,
                        firstTextOnTap: () {
                          controller.pickImageGallery();
                        },
                        context: context,
                        secondText: AppString.camera.tr,
                        secondTextOnTap: () {
                          controller.pickImageCamera();
                        },
                      );
                    },
                    name: AppString.profilePicture.tr,
                    icon: SvgPicture.asset(
                     AppImage.uploadImage,
                      width: 25,
                    ),
                  ),
                  Gap(h(context, 15)),
                  CustomAppTextFormField(
                    controller: controller.addressController,
                    textInputType: TextInputType.multiline,
                    maxLines: 4,
                    hintFontStyle: AppStyle.style(f(context, 15),
                        fontWeight: FontWeight.w400, ),
                    shape: TextFormFieldShape.RoundedBorder18,
                    prefix: SvgPicture.asset(AppImage.mapImage,width: w(context, 23),),
                    textInputAction: TextInputAction.none,
                    onChanged: (value) {
                      if (value.contains('\n')) {
                        if (kDebugMode) {}
                      }
                    },
                    hintText: AppString.detailsAdress.tr,
                  ),
                  Gap(h(context, 15)),
                  CustomTextFormField(
                    controller: controller.pinCodeController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                    hintText: AppString.yourPinCode.tr,
                    inputFormated: [
                      LengthLimitingTextInputFormatter(6)
                    ],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(AppImage.locationIcon),
                    ),
                  ),
                  Gap(h(context, 20)),
                  Obx(
                      ()=> CustomElevatedButton(
                        isLoading: APIs.isApiLoading.value,
                        onPressed: () {
                          controller.updateProfile();
                        }, buttonName: AppString.update.tr),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget imageCircle(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    var h = mq.height * 1;
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(5),
        height: h * 0.14,
        width: h * 0.14,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 1,
              color: ColorConstant.grey3)
        ], shape: BoxShape.circle, color: Colors.white),
        child: controller.selectedImagePath.isNotEmpty
            ? Obx(
                () => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(
                                File(controller.selectedImagePath.value)),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                        color: Colors.blueGrey)),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .1),
                child: CachedNetworkImage(
                  width: mq.height * .2,
                  placeholder: (context, url) => const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  height: mq.height * .2,
                  fit: BoxFit.cover,
                  imageUrl: controller.imageUrl?.value ??
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),
      ),
    );
  }
}
