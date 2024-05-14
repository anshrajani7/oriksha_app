import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oriksha_application/ApiServices/api_services.dart';
import '../../core/app_export.dart';
import 'controller/dashbord_controller.dart';

class DashBordScreen extends GetView<DashBordScreenController> {
  const DashBordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: StreamBuilder<LatLng>(
                stream: controller.locationStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    LatLng? currentLocation =
                        snapshot.data ?? controller.userLocation.value;
                    return Obx(
                      () => GoogleMap(
                        myLocationButtonEnabled: false,
                        buildingsEnabled: false,

                        mapType: MapType.terrain,
                        onMapCreated: (controllers) {
                          controller.mapController.value = controllers;
                        },
                        markers: Set<Marker>.of(controller.markers.value)
                          ..addAll(controller.pickupMarker.value),
                        initialCameraPosition: CameraPosition(
                          target: currentLocation!,
                          zoom: 15,
                        ),
                        // onCameraMove: (CameraPosition position) {
                        //   // Update the marker position
                        //   controller.updateMarkerPosition(position.target);
                        // },
                        // onCameraIdle: () {
                        //   LatLng markerPosition = controller.pickupMarker.value.first.position;
                        //   controller.mapController.value!.animateCamera(CameraUpdate.newLatLng(markerPosition));
                        // },
                        polylines: controller.polylines,
                        //  onCameraMove: (position) async {
                        //    final coordinates = geo.LatLng(position.target.latitude, position.target.longitude);
                        //    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(coordinates.latitude, coordinates.longitude);
                        //    if (placemarks.isNotEmpty) {
                        //      String? address = placemarks.first.name ?? placemarks.first.thoroughfare ?? placemarks.first.locality ?? placemarks.first.subAdministrativeArea ?? placemarks.first.administrativeArea;
                        //    print("address $address");
                        //
                        //    controller.pickupMarker.value.clear();
                        // controller.pickupMarker.value.add(
                        //     Marker(
                        //   markerId: const MarkerId('pikup_marker'),
                        //   position: LatLng(position.target.latitude, position.target.longitude),
                        //   infoWindow: const InfoWindow(title: "Pickup Point"),
                        //   icon: BitmapDescriptor.fromBytes(APIs.markerIcons[1]),
                        // )); }},
                        onTap: (argument) {
                          controller.onTap.value = false;
                        },
                        onLongPress: (LatLng position) async {
                          if (controller.openBootmSheet.isFalse &&
                              APIs.bottomSheet.isFalse) {
                            // Update the pickup marker's position when a long press is detected
                            final coordinates = geo.LatLng(
                                position.latitude, position.longitude);
                            List<geo.Placemark> placemarks =
                                await geo.placemarkFromCoordinates(
                                    coordinates.latitude,
                                    coordinates.longitude);
                            if (placemarks.isNotEmpty) {
                              String? address = placemarks.first.name ??
                                  placemarks.first.thoroughfare ??
                                  placemarks.first.locality ??
                                  placemarks.first.subAdministrativeArea ??
                                  placemarks.first.administrativeArea;
                              controller.pickup_main.value = placemarks
                                      .first.thoroughfare
                                      .toString()
                                      .isEmpty
                                  ? placemarks.first.subLocality.toString()
                                  : placemarks.first.thoroughfare.toString();
                              controller.pickup_text.value = placemarks
                                      .first.thoroughfare
                                      .toString()
                                      .isEmpty
                                  ? placemarks.first.locality.toString()
                                  : placemarks.first.subLocality.toString();
                              controller.pickupLocation.value =
                                  "${placemarks.first.thoroughfare} ${placemarks.first.subLocality} ${placemarks.first.locality}";
                              controller.pikLat = position.latitude;
                              controller.pikLong = position.longitude;
                              print("address $address");
                              controller.markers.value = {
                                Marker(
                                  markerId: const MarkerId('pickup_marker'),
                                  position: position,
                                  infoWindow:
                                      const InfoWindow(title: "Pickup Point"),
                                  icon: BitmapDescriptor.fromBytes(
                                      APIs.markerIcons[1]),
                                )
                              };
                            }
                          }
                        },
                        myLocationEnabled: true,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstant.primaryOrg,
                      ),
                    );
                  }
                },
              )),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w(context, 20),
              vertical: h(context, 35),
            ),
            child: Obx(() {
              if (APIs.bottomSheet.value || controller.openBootmSheet.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: h(context, 10),
                                  width: w(context, 10),
                                  decoration: const BoxDecoration(
                                    color: ColorConstant.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  height: h(context, 25),
                                  width: w(context, 2),
                                  decoration: const BoxDecoration(
                                    color: ColorConstant.primaryOrg,
                                  ),
                                ),
                                Container(
                                  height: h(context, 10),
                                  width: w(context, 10),
                                  decoration: const BoxDecoration(
                                    color: ColorConstant.orange38,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: h(context, 10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.pickupLocation.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: AppStyle.style(
                                      f(context, 14),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Text(
                                    controller.dropLocation.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: AppStyle.style(f(context, 14)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(() => APIs.rideConfirm.isFalse
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w(context, 8),
                                      vertical: h(context, 8)),
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes.serchScreenRoutes);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: w(context, 1))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: w(context, 10),
                                                vertical: h(context, 2)),
                                            child: Text(
                                              "Edit",
                                              style: AppStyle.style(
                                                  f(context, 13),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ))),
                                )
                              : const SizedBox())
                        ],
                      ),
                    ),
                    Gap(h(context, 15)),
                    GestureDetector(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(1, 0, 0, 0),
                          items: [
                            PopupMenuItem<String>(
                                value: 'Doge',
                                onTap: () {
                                  controller.policeEmergencyNumber();
                                },
                                child: const Text('POLICE')),
                            PopupMenuItem<String>(
                                value: 'Lion',
                                onTap: () {
                                  controller.fireEmergencyNumber();
                                },
                                child: const Text('FIRE')),
                            PopupMenuItem<String>(
                                value: 'Lion',
                                onTap: () {
                                  controller.ambulanceEmergencyNumber();
                                },
                                child: const Text('AMBULANCE')),
                            PopupMenuItem<String>(
                                value: 'Lion',
                                onTap: () {
                                  controller.womenHelplineEmergencyNumber();
                                },
                                child: const Text('WOMEN HELPLINE')),
                            PopupMenuItem<String>(
                                value: 'Lion',
                                onTap: () {
                                  controller.bloodBankEmergencyNumber();
                                },
                                child: const Text('BLOOD BANK')),
                          ],
                        );
                        // Display a message asking the user to perform a long-press action
                        //controller.showMessage();
                      },
                      child: Container(
                        height: h(context, 40),
                        width: w(context, 40),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      ColorConstant.greyBorder.withOpacity(0.6),
                                  spreadRadius: 5,
                                  blurRadius: 5)
                            ],
                            color: ColorConstant.primaryWhite,
                            shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          'SOS',
                          style: AppStyle.style(f(context, 18),
                              fontColor: Colors.red,
                              fontWeight: FontWeight.w900),
                        )),
                      ),
                    )
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.serchScreenRoutes);
                    },
                    child: Container(
                      height: h(context, 47),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: ColorConstant.grey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 1.5, color: ColorConstant.greyBorder)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: w(context, 10),
                            vertical: h(context, 5)),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppImage.serchIcon,
                              color: ColorConstant.greyBorder,
                            ),
                            Gap(h(context, 15)),
                            Obx(
                              () => Flexible(
                                child: Text(
                                  controller.pickupLocation.value.isNotEmpty
                                      ? controller.pickupLocation.value
                                      : "Enter a Pickup Point",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                  style: AppStyle.style(f(context, 16),
                                      fontColor: controller
                                              .pickupLocation.value.isNotEmpty
                                          ? ColorConstant.primaryBlack
                                          : ColorConstant.greyBorder,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(h(context, 15)),
                  GestureDetector(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(1, 0, 0, 0),
                        items: [
                          PopupMenuItem<String>(
                              value: 'Doge',
                              onTap: () {
                                controller.policeEmergencyNumber();
                              },
                              child: const Text('POLICE')),
                          PopupMenuItem<String>(
                              value: 'Lion',
                              onTap: () {
                                controller.fireEmergencyNumber();
                              },
                              child: const Text('FIRE')),
                          PopupMenuItem<String>(
                              value: 'Lion',
                              onTap: () {
                                controller.ambulanceEmergencyNumber();
                              },
                              child: const Text('AMBULANCE')),
                          PopupMenuItem<String>(
                              value: 'Lion',
                              onTap: () {
                                controller.womenHelplineEmergencyNumber();
                              },
                              child: const Text('WOMEN HELPLINE')),
                          PopupMenuItem<String>(
                              value: 'Lion',
                              onTap: () {
                                controller.bloodBankEmergencyNumber();
                              },
                              child: const Text('BLOOD BANK')),
                        ],
                      );
                      // Display a message asking the user to perform a long-press action
                      //controller.showMessage();
                    },
                    onLongPress: () {
                      //controller.dialEmergencyNumber();
                    },
                    child: Container(
                      height: h(context, 40),
                      width: w(context, 40),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color:
                                    ColorConstant.greyBorder.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 5)
                          ],
                          color: ColorConstant.primaryWhite,
                          shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        AppString.sOS,
                        style: AppStyle.style(f(context, 18),
                            fontColor: Colors.red, fontWeight: FontWeight.w900),
                      )),
                    ),
                  ),
                ],
              );
            }),
          ),
          Obx(
            () => APIs.rideArrive.isTrue && controller.distance.value > 100.0
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w(context, 10), vertical: h(context, 10)),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomTextButton(
                          onPressed: () {
                            controller.rideisComplate();
                          },
                          buttonName: 'Ride Complete'),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      bottomSheet: Obx(
        () {
          if (controller.openBootmSheet.isTrue && APIs.bottomSheet.isTrue) {
            return _buildBottomSheet(context);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
        height: h(context, 325),
        decoration: BoxDecoration(
            color: ColorConstant.primaryWhite,
            boxShadow: [
              BoxShadow(
                  color: ColorConstant.grey3.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 15)
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(30))),
        child: Obx(() => APIs.rideConfirm.isFalse
            ? Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: ColorConstant.primaryOrg,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: h(context, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/app_image/rightclick.png",
                            width: w(context, 30),
                            color: Colors.white,
                          ),
                          Text(
                            "You've saved upto 15% on your Auto Ride!",
                            maxLines: 2,
                            softWrap: true,
                            style: AppStyle.style(f(context, 13),
                                fontColor: ColorConstant.primaryWhite,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //color: ColorConstant.primaryOrg.withOpacity(0.2),
                    padding: EdgeInsets.symmetric(vertical: h(context, 8)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(context, 10)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/app_image/rixa.png",
                            width: w(context, 40),
                          ),
                          Text(
                            "Auto",
                            style:
                                AppStyle.style(17, fontWeight: FontWeight.bold),
                          ),
                          Gap(w(context, 10)),
                          Container(
                            height: h(context, 6),
                            width: w(context, 6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                          Gap(w(context, 4)),
                          Row(
                            children: [
                              Text(
                                controller.totalDuration.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: AppStyle.style(13,
                                    fontColor: ColorConstant.primaryBlack
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "(${controller.totalDistance.value})",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: AppStyle.style(10,
                                    fontColor: ColorConstant.primaryBlack,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: h(context, 6),
                            width: w(context, 6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                          Gap(w(context, 4)),
                          Text(
                            "\u{20B9}${controller.totalPrice.value}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: AppStyle.style(12,
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w600),
                          ),
                          Gap(w(context, 5)),
                          const Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: h(context, 1),
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  Container(
                    //color: ColorConstant.primaryOrg.withOpacity(0.2),
                    padding: EdgeInsets.symmetric(vertical: h(context, 8)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(context, 10)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/app_image/coupon.png",
                            width: w(context, 35),
                            color: Colors.red,
                          ),
                          Gap(w(context, 15)),
                          Text(
                            "RIDE NOW",
                            style: AppStyle.style(f(context, 13),
                                fontWeight: FontWeight.w500),
                          ),
                          Gap(w(context, 10)),
                          Container(
                            height: h(context, 6),
                            width: w(context, 6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5)),
                          ),
                          Gap(w(context, 4)),
                          Text(
                            "Coupon applied",
                            maxLines: 1,
                            style: AppStyle.style(f(context, 12),
                                fontColor:
                                    ColorConstant.primaryBlack.withOpacity(0.7),
                                fontWeight: FontWeight.w400),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: h(context, 1),
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  Container(
                    //color: ColorConstant.primaryOrg.withOpacity(0.2),
                    padding: EdgeInsets.symmetric(vertical: h(context, 8)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(context, 10)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/app_image/cash.png",
                            width: w(context, 40),
                            color: Colors.green,
                          ),
                          Gap(w(context, 10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cash",
                                style: AppStyle.style(f(context, 13),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "You can pay via cash or upi for your ride",
                                maxLines: 1,
                                style: AppStyle.style(f(context, 11),
                                    fontColor: ColorConstant.primaryBlack
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w(context, 15)),
                    child: Obx(
                      () => CustomElevatedButton(
                          isLoading: APIs.isApiLoading.value,
                          onPressed: () {
                            controller.bookRide();
                          },
                          buttonName: 'Book Ride'),
                    ),
                  ),
                  Gap(h(context, 10))
                ],
              )
            : SizedBox(
                width: double.maxFinite,
                child: Obx(
                  () => APIs.timeStart.isFalse
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnimationWidget.beat(
                                color: ColorConstant.primaryOrg, size: 50),
                            Gap(h(context, 25)),
                            Text(
                              'Please Wait 1 Minutes.\nYour Ride Send Successfully...',
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: AppStyle.style(f(context, 16),
                                  fontWeight: FontWeight.w500),
                            ),
                            Obx(() => Text(
                                  '${controller.minutes.value.toString().padLeft(2, '0')}:${controller.seconds.value.toString().padLeft(2, '0')}',
                                  style: AppStyle.style(32,
                                      fontColor: ColorConstant.primaryBlack,
                                      fontWeight: FontWeight.w700),
                                )),
                            Gap(30),
                            CustomTextButton(buttonName: 'Cancel Ride', onPressed: (){
                              controller.cancelRide();
                            })
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gap(h(context, 10)),
                            Text(
                              "Your Ride Request Confirmed",
                              style: AppStyle.style(f(context, 16)),
                            ),
                            Gap(h(context, 20)),
                            Center(
                              child: CircularCountDownTimer(
                                duration: 60 * 5,
                                initialDuration: 0,
                                controller: controller.countDownController,
                                width: h(context, 150),
                                height: w(context, 150),
                                ringColor: Colors.grey[300]!,
                                ringGradient: null,
                                fillColor:
                                    ColorConstant.primaryOrg.withOpacity(0.3),
                                fillGradient: null,
                                backgroundColor: ColorConstant.primaryOrg,
                                backgroundGradient: null,
                                strokeWidth: 10.0,
                                strokeCap: StrokeCap.round,
                                textStyle: AppStyle.style(f(context, 33),
                                    fontWeight: FontWeight.bold,
                                    fontColor: ColorConstant.primaryWhite),
                                textFormat: CountdownTextFormat.MM_SS,
                                isReverse: true,
                                isReverseAnimation: true,
                                isTimerTextShown: true,
                                autoStart: true,
                                onStart: () {
                                  controller.countDownController.start();
                                },
                                onComplete: () {
                                  controller.timeOut();
                                  debugPrint('Countdown Ended');
                                },
                                onChange: (String timeStamp) {
                                  debugPrint('Countdown Changed $timeStamp');
                                },
                                timeFormatterFunction:
                                    (defaultFormatterFunction, duration) {
                                  if (duration.inSeconds == 0) {
                                    return "Time Out";
                                  } else {
                                    return Function.apply(
                                        defaultFormatterFunction, [duration]);
                                  }
                                },
                              ),
                            ),
                            Gap(h(context, 20)),
                            Text(
                              "Driver Name: ${APIs.responseData!.driverDetails.driverName}",
                              style: AppStyle.style(f(context, 16)),
                            ),
                            Text(
                              "Driver Mobile Number: ${APIs.responseData!.driverDetails.driverMobileNumber}",
                              style: AppStyle.style(f(context, 16)),
                            ),
                            Text(
                              "OTP: ${APIs.responseData!.driverDetails.otp}",
                              style: AppStyle.style(f(context, 16)),
                            ),
                          ],
                        ),
                ))));
  }
}
