import 'package:flutter/cupertino.dart';
import 'package:oriksha_application/ApiServices/api_services.dart';

import '../../core/app_export.dart';
import '../../widget/pwerby_widget.dart';
import 'controller/login_controller.dart';

class LogInScreen extends GetWidget<LogInController> {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w(context, 20)),
                    child: Column(
                      children: [
                        Gap(h(context, 70)),


                        CustomElevatedButton(
                            isLoading: APIs.isApiLoading.value,
                            onPressed: () {
                              Get.toNamed(AppRoutes.registerScreenRoutes);
                            },
                            buttonName: AppString.register.tr),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.forNewUser.tr,
                              style: AppStyle.style(f(context, 15),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Gap(h(context, 30)),
                        Center(
                          child: Image.asset(
                            AppImage.appLogo,
                            width: w(context, 180),
                          ),
                        ),
                        Gap(
                          h(context, 20),
                        ),
                        Center(
                          child: Text(
                            AppString.pleaseEnterYourMobileNumberToContinue.tr,
                            style: AppStyle.style(f(context, 14),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(h(context, 10)),
                        CustomTextFormField(
                          onTap: () => controller.onTap.value = true,
                          controller: controller.mobileController,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          hintText: AppString.mobileNumber.tr,
                          inputFormated: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(AppImage.mobileIcon),
                          ),
                        ),
                        Gap(h(context, 10)),
                        Obx(
                          () => CustomTextFormField(
                            onTap: () => controller.onTap.value = true,
                            controller: controller.pinController,
                            hintText: AppString.pin.tr,
                            isObscureText:
                                controller.isVisible.value ? false : true,
                            textInputType: TextInputType.number,
                            inputFormated: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4)
                            ],
                            textInputAction: TextInputAction.done,
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  controller.iSVisibleFun();
                                },
                                icon: Icon(
                                  controller.isVisible.value
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash,
                                  color: ColorConstant.black72,
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w(context, 10),
                                  top: h(context, 10),
                                  bottom: h(context, 30)),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                      AppRoutes.forgatePasswordScreenRoutes);
                                },
                                child: Text(
                                  AppString.forgetPin.tr,
                                  style: AppStyle.style(f(context, 15),
                                      fontWeight: FontWeight.w500,
                                      fontColor:
                                          Colors.purple.withOpacity(0.8)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => CustomElevatedButton(
                              isLoading: APIs.isApiLoading.value,
                              onPressed: () async {
                                await controller.onLogin();
                              },
                              buttonName: AppString.logIN.tr),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => controller.onTap.isFalse
                ? const Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: PowerByWigdet())
                : SizedBox()),
          ],
        ),
      ),
    );
  }
}
