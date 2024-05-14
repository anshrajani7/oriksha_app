import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/widget/custom_choseFile_Button.dart';
import 'package:oriksha_application/widget/custom_image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'controller/driver_vehicle_details_controller.dart';

class DriverVehicleDetailsScreen
    extends GetWidget<DriverVehicleDetailsController> {
   DriverVehicleDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(context, 20)),
            child: Column(
              children: [
                Gap(h(context, 45)),
                Text(
                  AppString.vehicleDetails.tr,
                  style: AppStyle.style(f(context, 24),
                      fontColor: ColorConstant.primaryOrg,
                      fontWeight: FontWeight.w700),
                ),
                Gap(h(context, 25)),
                 CustomAppTextFormField(
                   textInputType: TextInputType.text,
                  labelText: AppString.vehicleNumber.tr,
                  controller: controller.vehicleNumberController,
                  textInputAction: TextInputAction.next,
                   richText: '*',
                   maxLength: 10,
                   onChanged: (p0) {
                     controller.vehicleNumberController.value =
                         controller.vehicleNumberController.value.copyWith(
                           text: p0.toUpperCase(),
                           selection:
                           TextSelection.collapsed(offset: p0.length),
                         );
                   },
                   inputFormated: [
                     maskFormatterVehical
                   ],
                ),
                CustomAppTextFormField(
                  labelText: AppString.licenceNumber.tr,
                  textInputAction: TextInputAction.done,
                  controller: controller.licenceNumberController,
                  richText: '*',
                  maxLength: 16,
                  inputFormated: [
                    maskFormatter
                  ],
                ),
                 Obx(
                   ()=> CustomChooseFile(
                     richText: '*',
                     name: controller.driverImage.value,
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      CustomGalleryDialog.instance
                          .CustomCupertinoBottomDilouge(
                        firstText: AppString.gallery.tr,
                        firstTextOnTap: () {
                          controller.pickImageGallery(name: "driver");
                        },
                        context: context,
                        secondText: AppString.camera.tr,
                        secondTextOnTap: () {
                          controller.pickImageCamera(name: "driver");
                        },
                      );
                    },
                    labelText: AppString.driverPhoto.tr,
                ),
                 ),
                Gap(h(context, 20)),
                 Obx(
                   ()=> CustomChooseFile(
                     richText: '*',
                      name: controller.vehicleFrontImage.value,
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      CustomGalleryDialog.instance
                          .CustomCupertinoBottomDilouge(
                        firstText: AppString.gallery.tr,
                        firstTextOnTap: () {
                          controller.pickImageGallery(name: "vehicleFrontImage");
                        },
                        context: context,
                        secondText: AppString.camera.tr,
                        secondTextOnTap: () {
                          controller.pickImageCamera(name: "vehicleFrontImage");
                        },
                      );
                    },
                    labelText: AppString.vehiclePhotoFront.tr,
                ),
                 ),
                Gap(h(context, 20)),
                 Obx(
                   ()=> CustomChooseFile(
                     richText: '*',
                     name: controller.vehicleBackImage.value,
                     onTap: (){
                       FocusScope.of(context).unfocus();
                       CustomGalleryDialog.instance
                           .CustomCupertinoBottomDilouge(
                         firstText: AppString.gallery.tr,
                         firstTextOnTap: () {
                           controller.pickImageGallery(name: "");
                         },
                         context: context,
                         secondText: AppString.camera.tr,
                         secondTextOnTap: () {
                           controller.pickImageCamera(name: "");
                         },
                       );
                     },
                    labelText: "${AppString.vehiclePhotoBack.tr} ${AppString.withCompanyLogo.tr}",
                ),
                 ),
                Gap(h(context, 30)),
                Obx(
                    ()=> CustomElevatedButton(
                        isLoading: APIs.isApiLoading.value,
                        onPressed: () {
                    controller.isRegister();
                  }, buttonName: AppString.submit.tr),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final  maskFormatter = MaskTextInputFormatter(
      mask: 'MH## ###########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
   final  maskFormatterVehical = MaskTextInputFormatter(
       mask: 'MH##aa####',
       filter: {"#": RegExp(r'[0-9]'),'a':RegExp(r'[A-Za-z]+')},
       type: MaskAutoCompletionType.lazy);
}
