import 'package:oriksha_application/presentation/Recharge_Page/controller/recharge_controller.dart';

import '../core/app_export.dart';

class SlideWidget extends GetView<SlideController> {
  final SlideController controller;

  const SlideWidget({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) =>
            controller.onDragUpdate(details.localPosition.dx),
        onHorizontalDragEnd: (DragEndDetails details) =>
            controller.onDragEnd(details, MediaQuery.sizeOf(context).width),
        child: Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            height: controller.isCompleted.value ? 100 : 60,
            padding: EdgeInsets.all(controller.isCompleted.value ? 20 : 5),
            width: controller.isCompleted.value ? 100 : MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: ColorConstant.primaryOrg,
              borderRadius: BorderRadius.circular(100),
            ),
            child: controller.isCompleted.value
                ? const CircleAvatar(
              radius: 35,
              backgroundColor: ColorConstant.primaryWhite,
              child: Icon(
                Icons.done,
                color: Colors.black,
                size: 50,
                weight: 40,
              ),
            )
                : Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  left: controller.dragPosition.value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorConstant.primaryWhite,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
                controller.isCompleted.value
                    ? const SizedBox()
                    : const Text(
                  "Swipe to Recharge",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
class SlideController extends GetxController {
  var dragPosition = 1.0.obs;
  var isCompleted = false.obs;
  var text = ''.obs;

  void onDragUpdate(double position) {
    updateDragPosition(position);
  }


  void onDragComplete() {
    Future.delayed(const Duration(milliseconds: 400), () {
      isCompleted.value = true;
      navigate();
    });
  }

  void navigate() {
    final rechargeController = Get.find<RechargeController>();
    Future.delayed(const Duration(milliseconds: 500), () {

      // Perform navigation
      rechargeController.openCheckout();
    });
  }
  void onDragEnd(DragEndDetails details, double width) {
 if(text.isNotEmpty){
   if (details.primaryVelocity! < 0) {
     // If the velocity is negative, the drag ended with a leftward swipe
     dragPosition.value = 0;
   } else {
     // If the velocity is positive, the drag ended with a rightward swipe
     dragPosition.value = width - width;
     onDragComplete();
   }}else {
   CustomSnackBar.showSnackBar(
       headerText: AppString.error.tr,
       bodyText: 'Please Enter a Amount');
 }
 }


  void updateDragPosition(double position) {
    if (text.isNotEmpty) {
      double newPosition = 0;
      // Update newPosition based on position
      dragPosition.value = newPosition;
    } else {
      CustomSnackBar.showSnackBar(
          headerText: AppString.error.tr,
          bodyText: 'Please Enter a Amount');
    }
  }
}
