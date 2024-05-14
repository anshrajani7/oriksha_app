import 'package:flutter/cupertino.dart';
import 'package:oriksha_application/core/Utils/app_textstyle.dart';
import 'package:oriksha_application/core/Utils/color_constant.dart';
import 'package:oriksha_application/core/Utils/size_utils.dart';
import 'package:oriksha_application/core/Utils/string_constant.dart';
import 'package:oriksha_application/presentation/Transactions_details_page/controller/transactions_details_controller.dart';
import 'package:oriksha_application/widget/custom_appBar.dart';
import 'package:oriksha_application/widget/custom_ratingcard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends GetWidget<TransactionDetailsController> {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          onPressed: (){
            Get.back();
          },
          text: AppString.transactiondetails.tr,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(context, 15)),
        child:controller.type.value=="passenger"? Column(
          children: [
            _customCard(
                context: context,
                timeText: controller.passengerRideHistoryList?.amount??'',
                title: controller.passengerRideHistoryList?.status??'',
                borderColor: ColorConstant.green,
                fontColor: ColorConstant.green,
                onTap: () {}),
            Gap(h(context, 15)),
            CustomRatingCard(name: controller.passengerRideHistoryList?.driverDetails.driverName??'',image:controller.passengerRideHistoryList?.driverDetails.driverPhoto??''),
            Gap(h(context, 25)),
        Container(
          decoration: BoxDecoration(color: ColorConstant.primaryWhite,borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: w(context, 15),vertical: h(context, 15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateFormater( controller.passengerRideHistoryList?.date??''),
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.style(f(context, 14),
                      fontColor: ColorConstant.primaryBlack,
                      fontWeight: FontWeight.w800),
                ),
                Gap(h(context, 15)),
                Row(
                  children: [
                    Column(
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
                          height: h(context, 60),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(context, 15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           dateFormaterAm( controller.passengerRideHistoryList?.rideConfirmedAt??'2024-02-22 20:13:12'),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.style(f(context, 16),
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                           "${ controller.passengerRideHistoryList?.pickupLocation} ${controller.passengerRideHistoryList?.pickupLocationSubText}",
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.style(f(context, 14),
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w400),
                          ),
                          Gap(
                            h(context, 15),
                          ),
                          Text(
                            dateFormaterAm( controller.passengerRideHistoryList?.completedTime??'2024-02-22 20:13:12'),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.style(f(context, 16),
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "${ controller.passengerRideHistoryList?.dropoffLocation} ${ controller.passengerRideHistoryList?.dropLocationSubText}",
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.style(f(context, 14),
                                fontColor: ColorConstant.primaryBlack,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(h(context, 20)),
                 Text('Bill Details', style: AppStyle.style(f(context, 16),
                    fontColor: ColorConstant.primaryBlack,
                    fontWeight: FontWeight.w800),),
                Gap(h(context, 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total km.",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                    Text("${controller.passengerRideHistoryList?.distance}",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                  ],
                ),
                Gap(12),
                Divider(color: Colors.blue),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Base fair(1st ${controller.passengerRideHistoryList?.distance}) -",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                    Text("30",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                  ],
                ),
                Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Distance fair X ${controller.passengerRideHistoryList?.distance} -",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                    Text("${controller.passengerRideHistoryList?.amount }",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                  ],
                ),
                Gap(5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount 15%",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
            Text(
              '-${(double.parse(controller.passengerRideHistoryList?.amount ?? '0') * 0.15).toStringAsFixed(2)}',

            style: AppStyle.style(
                        18,
                        fontColor: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Gap(5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Network/satellite fee",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                    Text("7.0",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                  ],
                ),
                Gap(5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Wether charge",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                    Text("3.0",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                  ],
                ),
                Gap(5),

                Gap(h(context, 15)),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Payable Amount', style: AppStyle.style(f(context, 16),
                         fontColor: ColorConstant.primaryBlack,
                         fontWeight: FontWeight.w800),),
                     Text("${double.parse(controller.passengerRideHistoryList?.amount??'')+7.0+3.0}", style: AppStyle.style(f(context, 16),
                         fontColor: ColorConstant.primaryBlack,
                         fontWeight: FontWeight.w800),)
                   ],
                 ),
              ],
            ),
          ),
        ),          ],
        ):Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Gap(h(context, 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",style: AppStyle.style(30,fontColor: ColorConstant.primaryBlack,fontWeight: FontWeight.bold),),
                  Text("Rs. ${controller.driverRideHistoryList?.amount.toString()}",style: AppStyle.style(30,fontColor: ColorConstant.primaryBlack,fontWeight: FontWeight.bold),)
                ],
              ),
              Gap(h(context, 20)),
              Container(
                height: 100,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.green,width: 2)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: 20,
                      color: Colors.green,
                    ),
                    Text("Flat 15% off on Petrolink oriksha rides",style: AppStyle.style(14,fontColor: ColorConstant.primaryBlack,),),
                    Gap(7)
                  ],
                ),
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total km.",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                  Text("11.5",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                ],
              ),
              Gap(12),
              Divider(color: Colors.blue),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Base fair(1st 1.5Km) -",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                  Text("30",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Distance fair X 17.5/Km -",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                  Text("11.5",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                ],
              ),
              Gap(5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount 15%",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                  Text(
                    '-${(controller.driverRideHistoryList?.amount ?? 0) * 0.85}', // Apply 15% discount
                    style: AppStyle.style(
                      18,
                      fontColor: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Gap(5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Network/satellite fee",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                  Text("7.0",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Wether charge",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                  Text("3.0",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total km.",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),),
                  Text("11.5",style: AppStyle.style(18,fontColor: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w500),)
                ],
              ),
              Gap(h(context, 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Final bill amount",style: AppStyle.style(24,fontColor: ColorConstant.primaryBlack,fontWeight: FontWeight.bold),),
                  Text("Rs. ${controller.driverRideHistoryList?.amount.toString()}",style: AppStyle.style(24,fontColor: ColorConstant.primaryBlack,fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
  String dateFormaterAm(String date){
    DateTime inputTime = DateTime.parse(date.isEmpty?"2024-02-22 20:13:12":date);

    // Define the desired time format
    DateFormat timeFormat = DateFormat('hh:mma');

    // Format the time using the desired format
    String formattedTime = timeFormat.format(inputTime);
    return formattedTime;
  }
 String dateFormater(String date){
   DateTime inputDate = DateTime.parse(date.isEmpty?"2024-02-22 20:13:12":date);

   // Define the desired date format
   DateFormat dateFormat = DateFormat('E, dd-MMM-yyyy hh:mma');

   // Format the date using the desired format
   String formattedDate = dateFormat.format(inputDate);
 return formattedDate;
 }
  String formatDateAndTime(DateTime dateTime) {
    // Customize the date and time format using intl package
    final DateFormat dateFormat = DateFormat('dd-MMM-yyyy hh:mm a');
    return dateFormat.format(dateTime);
  }

  Widget _customCard(
      {required BuildContext context,
      required String timeText,
      required String title,
      required Color borderColor,
      required Color fontColor,
      required void Function() onTap}) {
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
                      style: AppStyle.style(f(context, 16),
                          fontColor: fontColor, fontWeight: FontWeight.w700),
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
              style: AppStyle.style(f(context, 13),
                  fontFamily: 'Inter', fontWeight: FontWeight.w600),
            ),
            subtitle: Text(formatDateAndTime(DateTime.now()),
                style: AppStyle.style(f(context, 11),
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
