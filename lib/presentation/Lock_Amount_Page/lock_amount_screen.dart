import '../../ApiServices/api_services.dart';
import '../../core/app_export.dart';
import 'controller/lock_amount_controller.dart';

class LockAmountScreen extends GetWidget<LockAmountScreenController> {
  const LockAmountScreen({super.key});

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
          text: 'Lock Amount',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Gap(h(context, 20)),
            CustomImageView(
              imagePath: AppImage.appLogo,
              radius: BorderRadius.circular(12),
              height: 150,
              width: 120,
            ),
            Gap(h(context, 30)),
            Container(
              height: h(context, 120),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Obx(
                        () =>
                        Text(
                          APIs.lockAmount.value,
                          style: AppStyle.style(f(context, 45),
                              fontColor: ColorConstant.primaryOrg,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700),
                        ),
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      'MY AVAILABLE REFERRAL AMOUNT',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: AppStyle.style(f(context, 17),
                          fontFamily: "Inter",
                          fontColor: ColorConstant.primaryBlack,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                ],
              ),
            ),
            Gap(h(context, 100)),
            Obx(
                  () =>
                  CustomElevatedButton(
                    isLoading:APIs.isApiLoading.value,
                    buttonName: 'Redeem Amount', onPressed: ()async {
                    await  APIs.redeemAmountApi();
                  },),
            )
          ],
        ),
      ),
    );
  }
}
