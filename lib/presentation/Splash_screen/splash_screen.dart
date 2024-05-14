
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Splash_screen/controller/splash_controller.dart';
import 'package:oriksha_application/widget/pwerby_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: h(context, 80)),
          Expanded(
            child: Center(
              child: CustomImageView(
                imagePath: AppImage.appLogo,
                height:200,
              ),
            ),
          ),
     const PowerByWigdet(),
        ],
      ),
    );
  }
}
