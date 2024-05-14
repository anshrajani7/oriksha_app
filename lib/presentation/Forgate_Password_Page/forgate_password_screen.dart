import 'package:flutter_switch/flutter_switch.dart';

import '../../ApiServices/api_services.dart';
import '../../core/app_export.dart';
import 'controller/forgate_password_controller.dart';

class ForgatePasswordScreen extends GetWidget<ForgatePasswordScreenController> {
  const ForgatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          onPressed: () {
            Get.back();
          },
          text: 'Forget Pin',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Gap(h(context, 30)),
              CustomImageView(
                imagePath: AppImage.appLogo,
                radius: BorderRadius.circular(12),
                height: 150,
                width: 120,
              ),
              Gap(h(context, 30)),
              Obx(
                ()=> CustomTextFormField(
                  labelText: "Enter Mobile Number",
                  richText: "*",
                  suffixIcon: controller.otpVerify.value?const Icon(Icons.mark_email_read_rounded,color: Colors.green,):null,
                  controller: controller.senderTextController,
                  textInputType: TextInputType.phone,
                  readOnly: controller.otpVerify.value,
                  textInputAction: TextInputAction.next,
                  inputFormated: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                ),
              ),
              Gap(h(context, 10)),
              Obx(
                ()=> !controller.sendOtp.value? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: ()async{
                      await  APIs.sendOtpApi(mobileNum: controller.senderTextController.text);
                      controller.sendOtp.value=true;
                      },
                      child:  Text("send otp",style: AppStyle.style(14,fontWeight:FontWeight.w500,fontColor: ColorConstant.primaryOrg),),
                    )
                  ],
                ):SizedBox(),
              ),
              Padding(
                padding:  EdgeInsets.only(left: w(context, 20),right: w(context, 0),top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap:(){
                        controller.switchValue.value=false;
                      },
                      child: Text(
                        AppString.driver.tr,
                        style: AppStyle.style(f(context, 18),
                            fontWeight: FontWeight.w800,
                            fontColor: ColorConstant.primaryOrg),
                      ),
                    ),
                    Obx(
                          ()=> FlutterSwitch(
                        width: w(context, 60),
                        height: h(context, 35),
                        padding: 0,
                        // inactiveSwitchBorder: Border.all(width: 1,color: ColorConstant.grey9e),
                        // activeSwitchBorder: Border.all(width: 1,color: ColorConstant.grey9e),
                        toggleSize: h(context, 35),
                        value: controller.switchValue.value,
                        activeColor: ColorConstant.primaryWhite,
                        activeToggleColor: ColorConstant.primaryOrg,
                        inactiveToggleColor: ColorConstant.primaryOrg,
                        inactiveColor: ColorConstant.primaryWhite,
                        onToggle: (bool value) {
                          controller.switchValue.value=value;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        controller.switchValue.value=true;
                      },
                      child: Text(
                        'Passenger',
                        style: AppStyle.style(f(context, 18),
                            fontWeight: FontWeight.w800,
                            fontColor: ColorConstant.primaryOrg),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),

              Obx(
                ()=>controller.sendOtp.value&&!controller.otpVerify.value? CustomTextFormField(
                  labelText: "Enter Otp",
                  richText: "*",
                  controller: controller.otpTextController,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormated: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ],
                ):SizedBox()),
              Gap(10),
              Obx(
                    ()=> !controller.otpVerify.value? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        controller.otpVerifyFun();
                      },
                      child:  Text("verify otp",style: AppStyle.style(14,fontWeight:FontWeight.w500,fontColor: ColorConstant.primaryOrg),),
                    )
                  ],
                ):SizedBox(),
              ),
              Obx(() => controller.otpVerify.value?
              CustomTextFormField(
                labelText: "Enter New Pin",
                richText: "*",
                controller: controller.amountTextController,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormated: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4)
                ],
              ):SizedBox()),
              Gap(h(context, 50)),
              Obx(
                () => CustomElevatedButton(
                  isLoading: APIs.isApiLoading.value,
                  buttonName: 'Change Password',
                  onPressed: () async {
                 if(controller.senderTextController.text.length<9){
                   CustomSnackBar.showSnackBar(
                     headerText: AppString.error.tr,
                     bodyText: 'Please enter a valid mobile number',
                   );
                 }else if(controller.amountTextController.text.length<4){
                   CustomSnackBar.showSnackBar(
                     headerText: AppString.error.tr,
                     bodyText: 'Please enter valid pin',
                   );
                 }else{
                   await APIs.forgetPinApi(phone: controller.senderTextController.text,password: controller.amountTextController.text,isPassenger: controller.switchValue.value);
                 }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
