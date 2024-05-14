import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Transaction_Successfully_Page/controller/transaction_successfully_controller.dart';

class TransactionSuccessfullyScreen
    extends GetWidget<TransactionSuccessfullyController> {
  const TransactionSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const Center(
            child: Hero(
              tag: "Completed",
              child: CircleAvatar(
                radius: 75,
                backgroundColor: ColorConstant.primaryOrg,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorConstant.primaryWhite,
                  child: Icon(
                    Icons.done,
                    color: Colors.black,
                    size: 50,
                    weight: 40,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
           Text(
           AppString.yourTransactionIsSuccessfully.tr,
            style: TextStyle(
                color: ColorConstant.primaryBlack,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
           Get.close(1);
           },
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                  color: ColorConstant.primaryOrg,
                  borderRadius: BorderRadius.circular(100)),
              alignment: Alignment.center,
              child:  Text(
                AppString.close.tr,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
