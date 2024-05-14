import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:reviews_slider/reviews_slider.dart';
import '../../ApiServices/api_services.dart';
import '../../core/app_export.dart';
import 'controller/driver_map_controller.dart';

class DriverMapScreen extends GetWidget<DriverMapScreenController> {
  const DriverMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
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
                  if (controller.entry.isTrue) {
                    controller.onMapSet();
                    controller.entry.value = false;
                  }
                  controller.calculateDistance(
                    currentLocation: controller.userLocation.value!,
                    pickupLocation: LatLng(
                      double.parse(controller.data.pickupLatitude!),
                      double.parse(controller.data.pickupLongitude!),
                    ),
                  );
                  return Obx(() => controller.isSet.isFalse
                      ? GoogleMap(
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
                          polylines: controller.polylines,
                          myLocationEnabled: true,
                        )
                      : const Center(child: CircularProgressIndicator()));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: ColorConstant.primaryOrg),
                  );
                }
              },
            ),
          ),
          Obx(() {
            if(controller.distance.value > 100 && APIs.rideArrive.isFalse){
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w(context, 10),
                  vertical: h(context, 20),
                ),
                child: CustomTextButton(
                  buttonName: "Cancel Ride",
                  buttonColor: ColorConstant.primaryLightRed,
                  onPressed: () {
                  },
                ),
              );
            }
           else if (controller.distance.value < 100.00 && APIs.rideArrive.isFalse) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w(context, 10),
                  vertical: h(context, 20),
                ),
                child: CustomTextButton(
                  buttonName: "Arrived Ride",
                  onPressed: () {
                    Get.bottomSheet(
                      CustomBottomSheetWidget(
                        controllerl: controller,
                        rideId: controller.data.rideId ?? '',
                        closeBottomSheet: () async {
                          FocusScope.of(context).unfocus();
                          await controller
                              .verifyOtp(controller.data.rideId ?? '');
                        },
                      ),
                      isDismissible: true,
                      enableDrag: true,
                    );
                  },
                ),
              );
            } else if (APIs.rideArrive.isTrue) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w(context, 10),
                  vertical: h(context, 20),
                ),
                child: CustomTextButton(
                  buttonColor: ColorConstant.green,
                  buttonName: "Complete Ride",
                  onPressed: () {
                    Get.bottomSheet(
                      GetBuilder<DriverMapScreenController>(
                        init: DriverMapScreenController(),
                        builder: (controller) {
                          return Container(
                            height: h(context, 300),
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    topLeft: Radius.circular(24))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w(context, 20)),
                              child: Column(
                                // Column used to get full height
                                mainAxisAlignment: MainAxisAlignment.start,
                                //  MainAxisAlignment.center helps to center the widget of height
                                children: [
                                  Gap(h(context, 25)),
                                  Text(
                                    "Please Share a FeedBack",
                                    style: AppStyle.style(f(context, 20),
                                        fontColor: ColorConstant.primaryBlack,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Gap(h(context, 30)),
                                  Center(
                                    child: ReviewSlider(
                                        initialValue: 3,
                                        options: controller.list,
                                        onChange: (int value) {
                                          controller.selectText.value =
                                              controller.list[value];
                                        }),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.selectText.value,
                                      style: AppStyle.style(f(context, 22),
                                          fontColor: ColorConstant.primaryBlack,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Gap(h(context, 10)),
                                  Obx(
                                      ()=> CustomElevatedButton(
                                        isLoading: APIs.isApiLoading.value,
                                        onPressed: () {
                                         controller.onSubmit();
                                        },
                                        buttonName: AppString.submit.tr),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      isDismissible: true,
                      backgroundColor: ColorConstant.primaryWhite,
                    );
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}

class CustomBottomSheetWidget extends StatefulWidget {
  final DriverMapScreenController controllerl;
  final String rideId;
  final VoidCallback closeBottomSheet;

  const CustomBottomSheetWidget({
    Key? key,
    required this.controllerl,
    required this.rideId,
    required this.closeBottomSheet,
  }) : super(key: key);

  @override
  _CustomBottomSheetWidgetState createState() =>
      _CustomBottomSheetWidgetState();
}

class _CustomBottomSheetWidgetState extends State<CustomBottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: child,
        );
      },
      child: Container(
        height: h(context, 250),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: ColorConstant.primaryWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(h(context, 30)),
            Text(
              "Please Enter a OTP",
              style: AppStyle.style(
                f(context, 18),
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(h(context, 30)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w(context, 70)),
              child: PinInputTextField(
                pinLength: 4,
                autocorrect: true,
                cursor: Cursor(
                  color: ColorConstant.primaryOrg,
                  height: 25,
                  width: 2,
                  enabled: true,
                ),
                controller: widget.controllerl.otpController,
                autoFocus: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: BoxLooseDecoration(
                  radius: const Radius.circular(8),
                  strokeColorBuilder: const FixedColorBuilder(
                    ColorConstant.primaryOrg,
                  ),
                ),
                onSubmit: (pin) {
                  // Handle the submitted OTP
                  if (kDebugMode) {
                    print('Entered OTP: $pin');
                  }
                },
              ),
            ),
            Gap(h(context, 50)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w(context, 20)),
              child: Obx(
                () => CustomElevatedButton(
                  isLoading: APIs.isApiLoading.value,
                  onPressed: widget.closeBottomSheet,
                  buttonName: 'Verify Otp',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
