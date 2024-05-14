import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_export.dart';
import 'controller/serch_controller.dart';

class SerchScreen extends GetWidget<SerchScreenController> {
  const SerchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Focus on drop location text field when screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dropFocusNode.requestFocus();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: Obx(
              () => CustomAppBar(
            text: controller.pickup.isTrue ? "Pickup" : "Drop",
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(context, 25)),
        child: Column(
          children: [
            Gap(h(context, 35)),
            Container(
              height: h(context, 100),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey)),
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
                          height: h(context, 40),
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
                    child: Column(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            controller: controller.pickupController,
                            textInputAction: TextInputAction.next,
                            onChanged: (p0) {
                              controller.placeAutocomplete(
                                  p0, controller.pickupController);
                            },
                            onTap: () {
                              controller.pickup.value = true;
                              controller.onTap.value = true;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: h(context, 5)),
                                hintText: AppString.pickupLocation.tr,
                                border: InputBorder.none,

                                suffix: Padding(
                                  padding: EdgeInsets.only(
                                      right: w(context, 10),
                                      top: h(context, 5)),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.pickupController.clear();
                                      },
                                      child: const Icon(
                                        Icons.cancel_outlined,
                                        size: 20,
                                      )),
                                )),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: controller.dropController,
                            maxLines: 1,
                            focusNode: controller.dropFocusNode, // Added line
                            onChanged: (p0) {
                              controller.placeAutocomplete(
                                  p0, controller.dropController);
                            },
                            onTap: () {
                              controller.pickup.value = false;
                              controller.onTap.value = true;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: h(context, 17)),
                                hintText: AppString.dropLocation.tr,
                                border: InputBorder.none,
                                suffix: Padding(
                                  padding: EdgeInsets.only(
                                      right: w(context, 10),
                                      bottom: h(context, 2)),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.dropController.clear();
                                      },
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        size: 20,
                                      )),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
                  () => controller.onTap.isTrue
                  ? Flexible(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.places.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: const SizedBox(
                            height: double.infinity,
                            child: Icon(
                              Icons.location_on_sharp,
                              color: Colors.green,
                            ),
                          ),
                          title: Text(controller.places[index]
                          ['structured_formatting']['main_text']
                              .toString()),
                          onTap: () async {
                            await controller.handlePlaceSelection(index);
                            controller.places.clear();
                            FocusScope.of(context).unfocus();
                          },
                          subtitle: Text(
                            controller.places[index]
                            ['structured_formatting']
                            ['secondary_text']
                                .toString(),
                          ),
                        ),
                      );
                    },
                  );
                }),
              )
                  : const SizedBox(),
            ),
            Gap(h(context, 50)),
            Obx(() => !controller.onTap.value
                ? CustomElevatedButton(
              isLoading: controller.isSetMap.value,
                onPressed: () {
                  controller.onMapSet();
                },
                buttonName: AppString.setMap.tr)
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
