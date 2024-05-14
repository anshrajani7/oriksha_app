import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Recharge_Page/controller/recharge_controller.dart';
import '../../widget/custom_slider.dart';

class RechargeScreen extends GetWidget<RechargeController> {
  final SlideController slideController = SlideController();
   RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: w(context, 25),vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImage.appLogo, width: w(context, 100)),
                Container(
                  width: w(context, 186),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: h(context, 8)),
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                      color: ColorConstant.primaryOrg,
                      borderRadius: BorderRadius.circular(100)),
                  alignment: Alignment.center,
                  child: Center(
                    child: Obx(
                      () => Text(
                        "\u{20B9}${controller.amount.value.isEmpty ? "0" : controller.amount.value}",
                        maxLines: 1,
                        style: AppStyle.style(
                            fontColor: ColorConstant.primaryBlack,
                            f(context, 30),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                for (int i = 0; i < controller.keyboardList.length; i++) ...[
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        for (int j = 0;
                            j < controller.keyboardList[i].length;
                            j++) ...[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (controller.keyboardList[3][0] ==
                                        controller.keyboardList[i][j] ||
                                    controller.keyboardList[3][2] ==
                                        controller.keyboardList[i][j]) {
                                  if (controller.keyboardList[3][0] ==
                                          controller.keyboardList[i][j] &&
                                      !controller.amount.value.contains(".")) {
                                    controller.amount.value += ".";
                                  } else {
                                    if (controller.keyboardList[3][2] ==
                                            controller.keyboardList[i][j] &&
                                        controller.amount.value.isNotEmpty) {
                                      controller.amount.value =
                                          controller.amount.value.substring(0,
                                              controller.amount.value.length - 1);
                                    }
                                  }
                                } else {
                                  if (controller.amount.value.length < 5) {
                                    if (controller.amount.value.isEmpty) {
                                      controller.amount.value =
                                          "${controller.keyboardList[i][j]}";
                                    } else {
                                      controller.amount.value +=
                                          "${controller.keyboardList[i][j]}";
                                    }
                                  }
                                }
                                slideController.text.value=controller.amount.value;
                              },
                              child: SizedBox(
                                height: h(context, 80),
                                width: h(context, 80),
                                child: Center(
                                    child: Text(
                                        controller.keyboardList[i][j] == -1
                                            ? "."
                                            : controller.keyboardList[i][j] == -2
                                                ? "<<"
                                                : controller.keyboardList[i][j]
                                                    .toString(),
                                        style: AppStyle.style(f(context, 30),
                                            fontColor:
                                                ColorConstant.primaryBlack))),
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  )
                ],
                SizedBox(
                  height: h(context, 130),
                  child: Hero(
                    tag: "Completed",
                    child: SlideWidget(controller: slideController),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
