import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Driver_DashBord_Page/controller/driver_dashbord_controller.dart';
import 'package:oriksha_application/widget/custom_card.dart';
import 'package:oriksha_application/widget/custom_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DriverDashBordScreen extends GetView<DriverDashBordScreenController> {
  const DriverDashBordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          action: Obx(
            () => Row(
              children: [
                Obx(() => Text(
                      'OFF',
                      style: AppStyle.style(16,
                          fontColor: controller.switchValue.isFalse
                              ? ColorConstant.primaryBlack
                              : ColorConstant.primaryBlack.withOpacity(0.4),
                          fontWeight: FontWeight.w700),
                    )),
                const SizedBox(width: 5),
                // Adjust spacing as needed
                Switch(
                  activeColor: ColorConstant.grey,
                  inactiveThumbColor: ColorConstant.greyBorder,
                  inactiveTrackColor: ColorConstant.greyBorder.withOpacity(0.2),
                  hoverColor: ColorConstant.grey,
                  splashRadius: 47,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: controller.switchValue.value,
                  onChanged: (value) {
                    controller.toggleSwitch();
                  },
                ),
                const SizedBox(width: 5),
                // Adjust spacing as needed
                Obx(() => Text(
                      'ON',
                      style: AppStyle.style(16,
                          fontColor: controller.switchValue.isTrue
                              ? ColorConstant.primaryBlack
                              : ColorConstant.primaryBlack.withOpacity(0.4),
                          fontWeight: FontWeight.w700),
                    )),
                // Text for "on" state
              ],
            ),
          ),
          text: AppString.dashBoard.tr,
        ),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        scrollController: controller.scrollController,
        onRefresh: () {
          controller.fetchUserData();
        },
        header: const WaterDropMaterialHeader(
          backgroundColor: ColorConstant.primaryOrg,
          color: Colors.white,
          distance: 35, // Set your desired color here
        ),
        child: SingleChildScrollView(
          child: Obx(() {
            if (APIs.hasData.isFalse) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: w(context, 15)),
                child: Column(
                  children: [
                    Obx(() {
                      if (APIs.noData.isFalse) {
                        return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: APIs.rideRequestList.rideRequests.length,
                          itemBuilder: (context, index) {
                            var rides =
                                APIs.rideRequestList.rideRequests[index];
                            return Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: h(context, 6)),
                              child: CustomCard(
                                status: rides.status ?? 'book',
                                locationDropSubTitle:
                                    rides.dropLocationSubText ?? "",
                                locationDropTitle:
                                    "${rides.dropLocationMainText} (${rides.distance})",
                                locationPickSubTitle:
                                    rides.pickupLocationSubText ?? "",
                                locationPickTitleo:
                                    "${rides.pickupLocationMainText} (0km)",
                                rupeesText: rides.price ?? "",
                                secondText: "60",
                                acceptOnTap: () async {
                                  await APIs.handelRideRequest(
                                    pushToken: rides.pushNotification ?? '',
                                    id: controller.id.value,
                                    handelRequest: 'accept',
                                    rideId: rides.rideId ?? '',
                                    rideInfo:
                                        "${rides.pickupLocationMainText} - ${rides.dropLocationMainText}",
                                  );
                                  if (APIs.isLoading.isTrue) {
                                    Get.offAllNamed(
                                        AppRoutes.driverMapScreenRoutes,
                                        arguments: rides);
                                  }
                                },
                                rejectOnTap: () async {
                                  await APIs.handelRideRequest(
                                    pushToken: rides.pushNotification ?? '',
                                    id: controller.id.value,
                                    handelRequest: 'reject',
                                    rideId: rides.rideId ?? '',
                                    rideInfo:
                                        "${rides.pickupLocationMainText} - ${rides.dropLocationMainText}",
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          heightFactor: h(context, 17),
                          child: Text(
                            "No Ride Request...",
                            style: AppStyle.style(f(context, 22)),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              );
            } else {
              return const YourShimmeringListView(height: 0.26, padding: false);
            }
          }),
        ),
      ),
    );
  }
}
