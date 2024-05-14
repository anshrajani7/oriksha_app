import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/MyBankDetails_QRCode_Page/controller/mybankdetails_QRcode_controller.dart';
import 'package:oriksha_application/widget/custom_choseFile_Button.dart';
import 'package:oriksha_application/widget/custom_image_picker.dart';
import '../../widget/custom_appBar.dart';

class MyBankDetailsScreen extends GetWidget<MyBankDetailsController> {
  const MyBankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          onPressed: (){
            Get.back();
          },
          text: AppString.myBankDetailsQRCode.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: w(context, 15), vertical: h(context, 15)),
          child: Column(
            children: [
              CustomTextFormField(
                labelText: AppString.bankAccountNumber.tr,
                controller: controller.accountNumberController,
                richText: '*',
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormated: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16)
                ],
              ),
              Gap(h(context, 15)),
              CustomTextFormField(
                labelText: AppString.iFSCCode.tr,
                controller: controller.iFSCController,
                richText: '*',
                textInputType: TextInputType.text,
                onChanged: (p0) {
                  controller.iFSCController.value =
                      controller.iFSCController.value.copyWith(
                        text: p0.toUpperCase(),
                        selection:
                        TextSelection.collapsed(offset: p0.length),
                      );
                },
                inputFormated: [
                  LengthLimitingTextInputFormatter(12)
                ],
                textInputAction: TextInputAction.next,
              ),
              Gap(h(context, 15)),
              CustomTextFormField(
                labelText: AppString.bankAccountHoldersName.tr,
                controller: controller.holderNameController,
                richText: '*',
                textInputType: TextInputType.text,

                onChanged: (p0) {
                  controller.holderNameController.value =
                      controller.holderNameController.value.copyWith(
                        text: p0.toUpperCase(),
                        selection:
                        TextSelection.collapsed(offset: p0.length),
                      );
                },
                textInputAction: TextInputAction.next,
              ),
              Gap(h(context, 15)),
              Obx(
                () => CustomChooseFile(
                  name: controller.qRCordImage.value,
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
                  labelText: AppString.qRCodePhoto.tr,
                ),
              ),
              Gap(h(context, 30)),
              CustomTextButton(buttonName: AppString.confirm.tr, onPressed: ()async {
                await controller.addBankDetails();
              })
            ],
          ),
        ),
      ),
    );
  }
}
