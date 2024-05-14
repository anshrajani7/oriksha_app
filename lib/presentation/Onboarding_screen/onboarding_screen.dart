import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/widget/pwerby_widget.dart';
import 'controller/onboarding_controller.dart';

class OnBoardingScreen extends GetWidget<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.appLogo,
                  width: w(context, 200),
                ),
                Gap(
                  h(context, 50),
                ),
                Text(
                  AppString.selectLanguage.tr,
                  style: AppStyle.style(f(context, 20),
                      fontWeight: FontWeight.w900,
                      fontColor: ColorConstant.primaryOrg.withOpacity(0.9)),
                ),
              Gap(h(context, 20)),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: w(context, 30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customRadio(
                      context: context,
                      text: AppString.marathi,
                      languageCode: 'mr',
                    ),
                    _customRadio(
                      context: context,
                      text: AppString.hindi,
                      languageCode: 'hi',
                    ),
                    _customRadio(
                      context: context,
                      text: AppString.english,
                      languageCode: 'en_GB',
                    ),
                  ],
                ),
              ),
                Gap( h(context, 50),
                ),
                CustomTextButton(
                    buttonName: AppString.continu.tr,
                    onPressed: () {
                      Get.toNamed(AppRoutes.loginScreenRoutes);
                    }),

              ],
            ),
            const Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: PowerByWigdet())
          ],
        ),
      ),
    );
  }

  Widget _customRadio(
      {required BuildContext context,
        required String text,
        required String languageCode}) {
    return InkWell(
      overlayColor: const MaterialStatePropertyAll(ColorConstant.transparent),
      onTap: (){
        controller.changeLanguage = languageCode;
        },
      child: Row(
        children: [
          _getRadioImage(languageCode),
          Gap(w(context, 7)),
          Text(
            text,
            style: AppStyle.style(f(context, 14), fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
  Widget _getRadioImage(String languageCode) {
    return Obx(() {
      return SvgPicture.asset(
        controller.selectedLanguage.value == languageCode
            ? AppImage.selectRadioIcon
            : AppImage.unSelectRadio,
      );
    });
  }
}
