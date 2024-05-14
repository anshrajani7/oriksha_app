import 'package:flutter_switch/flutter_switch.dart';
import '../../core/app_export.dart';
import 'controller/register_controller.dart';

class RegisterScreen extends GetWidget<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImage.appLogo,
            width: w(context, 180),
          ),
          Gap(h(context, 40),),
          Text(
            AppString.iAm.tr,
            style: AppStyle.style(f(context, 32),
                fontWeight: FontWeight.w800,
                fontColor: ColorConstant.primaryOrg),
          ),
        Gap(h(context, 25)),
          Padding(
            padding:  EdgeInsets.only(left: w(context, 45),right: w(context, 24)),
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
                    width: w(context, 73),
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
                    AppString.passenger.tr,
                    style: AppStyle.style(f(context, 18),
                        fontWeight: FontWeight.w800,
                        fontColor: ColorConstant.primaryOrg),
                  ),
                ),
              ],
            ),
          ),
        Gap(h(context, 50)),
          CustomTextButton(
              buttonName: AppString.next.tr,
              onPressed :() {
                controller.onPressed();
              },)
        ],
      ),
    );
  }
}
