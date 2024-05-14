import 'package:oriksha_application/presentation/Driver_Details_Page/controller/driver_details_controller.dart';
import 'package:oriksha_application/widget/custom_choseFile_Button.dart';
import 'package:oriksha_application/widget/custom_otp_text_filled.dart';
import 'package:flutter/cupertino.dart';

import '../../ApiServices/api_services.dart';
import '../../core/app_export.dart';
import '../../widget/custom_image_picker.dart';

class DriverDetailsScreen extends GetWidget<DriverDetailsController> {
  const DriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(context, 20)),
            child: Column(
              children: [
                Gap(h(context, 16)),
                Text(
                  AppString.driverDetails.tr,
                  style: AppStyle.style(f(context, 24),
                      fontColor: ColorConstant.primaryOrg,
                      fontWeight: FontWeight.w700),
                ),
                Gap(h(context, 22)),
                CustomAppTextFormField(
                  textInputType: TextInputType.name,
                  labelText: AppString.fullName.tr,
                  controller: controller.nameController,
                  textInputAction: TextInputAction.next,
                  richText: '*',
                ),
                Gap(h(context, 16)),
                CustomAppTextFormField(
                  textInputType: TextInputType.number,
                  maxLength: 10,
                  labelText: AppString.mobileNumber.tr,
                  controller: controller.mobileNumController,
                  onChanged: (p0) {
                    if(controller.mobileNumController.text.length==10){

                    }
                  },
                  textInputAction: TextInputAction.next,
                  richText: '*',
                ),
                CustomAppTextFormField(
                  textInputType: TextInputType.emailAddress,
                  labelText: AppString.emailId.tr,
                  controller: controller.emailController,
                  richText: '*',
                  textInputAction: TextInputAction.next,
                ),
                Gap(h(context, 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => CustomOtpTextFilled(
                      labelText: AppString.pin.tr,
                          richText: '*',
                          onSubmit: (p0) {
                            controller.pinNumber.value=p0;
                          },
                          obscureText: controller.isVisible.value,
                        )),
                    IconButton(
                        style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(Colors.transparent)
                        ),
                        onPressed: () {
                          controller.iSVisibleFun();
                        },
                        icon: Obx(
                          () => Icon(
                            !controller.isVisible.value
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: ColorConstant.black72,
                          ),
                        ))
                  ],
                ),
                Gap(h(context, 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => CustomOtpTextFilled(
                      labelText: AppString.confirmPIN.tr,
                      onSubmit: (p0) {
                        controller.confirmPinNumber.value=p0;
                      },
                      richText: '*',
                      obscureText: controller.isVisible1.value,
                    )),
                    IconButton(
                      style: const ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(Colors.transparent)
                      ),
                        onPressed: () {
                          controller.iSVisibleFun1();
                        },
                        icon: Obx(
                              () => Icon(
                            !controller.isVisible1.value
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: ColorConstant.black72,
                          ),
                        ))
                  ],
                ),
                Gap(h(context, 16)),
                CustomAppTextFormField(
                  controller: controller.aadharNumController,
                  labelText: AppString.adharNumber.tr,
                  richText: '*',
                  maxLength: 14,
                  textInputType: TextInputType.number,
                  inputFormated: [
                    FilteringTextInputFormatter.digitsOnly,
                    AadharNumFormatter(),
                    LengthLimitingTextInputFormatter(14)
                  ],
                  textInputAction: TextInputAction.next,
                ),
                CustomAppTextFormField(
                  controller: controller.referralController,
                  labelText: AppString.referralCode.tr,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                Gap(h(context, 10)),
                Obx(
                    ()=> CustomChooseFile(
                      name: controller.aadharFrontImage.value,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      CustomGalleryDialog.instance.CustomCupertinoBottomDilouge(
                        firstText: AppString.gallery.tr,
                        firstTextOnTap: () {
                          controller.pickImageGallery(name: 'front');
                        },
                        context: context,
                        secondText: AppString.camera.tr,
                        secondTextOnTap: () {
                          controller.pickImageCamera(name: 'front');
                        },
                      );
                    },
                    labelText: AppString.adharPhotofront.tr,
                    richText: '*',
                  ),
                ),
                Gap(h(context, 10)),
                Obx(
                      ()=> CustomChooseFile(
                    name: controller.aadharBackImage.value,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      CustomGalleryDialog.instance.CustomCupertinoBottomDilouge(
                        firstText: AppString.gallery.tr,
                        firstTextOnTap: () {
                          controller.pickImageGallery(name: '');
                        },
                        context: context,
                        secondText: AppString.camera.tr,
                        secondTextOnTap: () {
                          controller.pickImageCamera(name: '');
                        },
                      );
                    },
                    labelText: AppString.adharPhotoback.tr,
                    richText: '*',
                  ),
                ),
                Gap(h(context, 30)),
                Obx(
                    ()=> CustomElevatedButton(
                      isLoading: APIs.isApiLoading.value,
                      onPressed: () {
                      controller.isRegister();
                      },
                      buttonName: AppString.submit.tr),
                ),
                Gap(h(context, 35)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class AadharNumFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

