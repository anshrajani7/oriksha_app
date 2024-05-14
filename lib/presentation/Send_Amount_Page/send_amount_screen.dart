import '../../ApiServices/api_services.dart';
import '../../core/app_export.dart';
import 'controller/send_amount_controller.dart';

class SendAmountScreen extends GetWidget<SendAmountScreenController> {
  const SendAmountScreen({super.key});

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
          text: 'Send Amount',
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
              CustomTextFormField(
                labelText: "Enter Receiver Mobile No.",
                richText: "*",
                controller: controller.senderTextController,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormated: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],
              ),
              Gap(h(context, 10)),
              CustomTextFormField(
                labelText: "Enter Amount",
                richText: "*",
                controller: controller.amountTextController,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormated: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4)
                ],
              ),
              Gap(h(context, 50)),
              Obx(
                () => CustomElevatedButton(
                  isLoading: APIs.isApiLoading.value,
                  buttonName: 'Send Amount',
                  onPressed: () async {
                 if(controller.senderTextController.text.length<9){
                   CustomSnackBar.showSnackBar(
                     headerText: AppString.error.tr,
                     bodyText: 'Please enter a valid mobile number',
                   );
                 }else if(controller.amountTextController.text.isEmpty){
                   CustomSnackBar.showSnackBar(
                     headerText: AppString.error.tr,
                     bodyText: 'Please enter amount',
                   );
                 }else{
                   await APIs.sendAmountApi(reciverPhone: controller.senderTextController.text,amount: controller.amountTextController.text);
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
