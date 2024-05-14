import 'package:oriksha_application/widget/custom_otp_text_filled.dart';
import 'package:flutter/cupertino.dart';
import '../../core/app_export.dart';
import '../../widget/custom_pdf_viewer.dart';
import 'controller/customer_details_controller.dart';

class CustomerDetailsScreen extends GetWidget<CustomerDetailsController> {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(context, 20)),
            child: Column(
              children: [
                Gap(h(context, 35)),
                Text(
                  AppString.customerDetails.tr,
                  style: AppStyle.style(f(context, 24),
                      fontColor: ColorConstant.primaryOrg,
                      fontWeight: FontWeight.w700),
                ),
                Gap(h(context, 15)),
                CustomAppTextFormField(
                  textInputType: TextInputType.name,
                  labelText: AppString.fullName.tr,
                  controller: controller.nameController,
                  textInputAction: TextInputAction.next,
                  richText: '*',
                ),
                Gap(h(context, 15)),
                CustomAppTextFormField(
                  textInputType: TextInputType.number,
                  maxLength: 10,
                  labelText: AppString.mobileNumber.tr,
                  controller: controller.mobileController,
                  textInputAction: TextInputAction.next,
                  richText: '*',
                ),
                CustomAppTextFormField(
                  textInputType: TextInputType.emailAddress,
                  labelText: AppString.emailId.tr,
                  controller: controller.emailController,
                  textInputAction: TextInputAction.next,

                ),
                Gap(h(context, 5)),
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
                Gap(h(context, 5)),
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
                  controller: controller.referralController,
                  labelText: AppString.referralCode.tr,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                Gap(h(context, 10)),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        checkColor: ColorConstant.primaryWhite,
                        activeColor: ColorConstant.primaryOrg,
                        value: controller.checkBox.value,
                        onChanged: (value) {
                          controller.checkBox.toggle();
                        },
                      ),
                    ),
                    Obx(() => GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PdfViewScreen(title: 'Terms and Conditions', finaleParth: 'assets/app_image/2_Terms and Conditions.pdf', fileName: 'sample.pdf',)),
                        );
                        controller.checkBox.value=true;
                      },
                      child: Text(
                            AppString.iAgreeToTheTermAndCondition.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: AppStyle.style(f(context, 16),
                                fontColor: controller.checkBox.isFalse
                                    ? Colors.red
                                    : Colors.black),
                          ),
                    )),
                  ],
                ),
                CustomElevatedButton(
                    onPressed: () {
                      controller.isRegister();
                    },
                    buttonName: AppString.submit.tr),
                Gap(h(context, 25))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
