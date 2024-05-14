import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Transactions_List_Page/controller/transaction_list_controller.dart';
import 'package:oriksha_application/widget/custom_shimmer.dart';
import 'package:intl/intl.dart';

import '../../core/Utils/common_constor.dart';
import '../../core/Utils/hive_keys.dart';

class TransactionListScreen extends GetWidget<TransactionListController> {
  const TransactionListScreen({Key? key}) : super(key: key);

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
          text: AppString.transaction.tr,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(context, 15)),
        child: Obx(() {
          if (!APIs.isLoading.value) {
            bool isPassenger =
                Constant.instance.dbHelper.driver.get(HiveKeys.isPassenger) ??
                    false;

            // Check if the user is a passenger
            if (isPassenger) {
              // Show passenger ride history data
              if (controller.passengerRideHistoryList == null ||
                  controller.passengerRideHistoryList!.isEmpty) {
                // If no data available, show a message
                return Center(
                  child: Text(
                    "No Data Found..",
                    style: AppStyle.style(
                      f(context, 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                // Show the list of passenger ride history items
                return ListView.builder(
                  itemCount: controller.passengerRideHistoryList!.length,
                  itemBuilder: (context, index) {
                    return _customCard(
                      context: context,
                      timeText: controller.passengerRideHistoryList![index]
                          .amount
                          .toString(), // Example: Use amount as timeText
                      title: controller.passengerRideHistoryList![index]
                          .status??'',
                      borderColor: ColorConstant.green,
                      fontColor: ColorConstant.green,
                      onTap: () {
                        Get.toNamed(AppRoutes.transactionDetailsScreenRoutes, arguments: {"data":controller.passengerRideHistoryList?[index],"type":"passenger"});
                      },
                    );
                  },
                );
              }
            } else {
              // Show driver ride history data
              if (controller.driverRideHistoryList == null ||
                  controller.driverRideHistoryList!.isEmpty) {
                // If no data available, show a message
                return Center(
                  child: Text(
                    "No Data Found..",
                    style: AppStyle.style(
                      f(context, 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                // Show the list of driver ride history items
                return ListView.builder(
                  itemCount: controller.driverRideHistoryList!.length,
                  itemBuilder: (context, index) {
                    return _customCard(
                      context: context,
                      timeText: controller.driverRideHistoryList![index]
                          .amount
                          .toString(), // Example: Use amount as timeText
                      title: controller.driverRideHistoryList![index]
                          .status,
                      borderColor: ColorConstant.green,
                      fontColor: ColorConstant.green,
                      onTap: () {
                        Get.toNamed(AppRoutes.transactionDetailsScreenRoutes, arguments:  {"data":controller.driverRideHistoryList?[index],"type":"driver"});
                      },
                    );
                  },
                );
              }
            }
          } else {
            // Show shimmer effect while loading data
            return const YourShimmeringListView(height: 0.13);
          }
        }),
      ),
    );
  }

  // Widget for custom card
  Widget _customCard({
    required BuildContext context,
    required String timeText,
    required String title,
    required Color borderColor,
    required Color fontColor,
    required void Function() onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: h(context, 10)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.primaryWhite,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            trailing: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: w(context, 2), // Adjust the border width as needed
                ),
              ),
              child: CircleAvatar(
                backgroundColor: ColorConstant.primaryWhite,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      maxLines: 1,
                      timeText,
                      style: AppStyle.style(
                        f(context, 16),
                        fontColor: fontColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: AppStyle.style(
                f(context, 13),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              formatDateAndTime(DateTime.now()), // Example: Use current date and time
              style: AppStyle.style(
                f(context, 11),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to format date and time
  String formatDateAndTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('dd-MMM-yyyy hh:mm a');
    return dateFormat.format(dateTime);
  }
}

