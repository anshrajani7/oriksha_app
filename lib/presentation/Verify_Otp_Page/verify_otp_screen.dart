import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Verify_Otp_Page/controller/verify_otp_controller.dart';
import 'package:oriksha_application/widget/custom_otp_text_filled.dart';



class VerifyOtpScreen extends GetWidget<VerifyOtpScreenController> {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomAppBar(
            text: AppString.verifyOtp.tr,
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: ColorConstant.primaryOrg,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(context, 25)),
          child: Column(
            children: [
              Gap(h(context, 30)),
              Container(
                height: h(context, 70),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                          color: ColorConstant.grey3,
                          offset: Offset(-5, 10),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ],
                    color: ColorConstant.primaryWhite),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w(context, 10), vertical: h(context, 10)),
                  child: Text(
                    "${AppString.aMessageWithAVerification.tr}${controller.mobileNumber.value}",
                    style: AppStyle.style(f(context, 14)),
                  ),
                ),
              ),
              Gap(h(context, 45)),
           CustomOtpTextFilled(
             onSubmit: (p0) {
               controller.otpNumber.value=p0;
             },
           ),
             Gap(h(context, 65)),
              Obx(
                  ()=> CustomElevatedButton(
                    isLoading: APIs.isApiLoading.value,
                    onPressed: ()async{
                 await controller.verifyOtp();
                }, buttonName: AppString.verifyOtp.tr,),
              )
            ],
          ),
        ));
  }
}
