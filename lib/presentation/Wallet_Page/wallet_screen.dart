import 'package:oriksha_application/ApiServices/api_services.dart';
import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Wallet_Page/controller/wallet_controller.dart';
import 'package:intl/intl.dart';
import 'package:oriksha_application/widget/custom_shimmer.dart';

import '../../model/transation_model.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => _WalletScreenState();

}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     await fetchData();
    });
  }
  Future<void> fetchData()async{
    await APIs.showTransactionApi();
  }
  WalletScreenController controller=Get.put(WalletScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(context, 25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(h(context, 60)),
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
                    ()=> Text(
                        APIs.amount.value,
                        style: AppStyle.style(f(context, 45),
                            fontColor: ColorConstant.primaryOrg,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                     AppString.myAvailableBalance.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: AppStyle.style(f(context, 17),
                          fontFamily: "Inter",
                          fontColor: ColorConstant.primaryBlack,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: w(context, 15),
                  crossAxisCount: 2,
                  mainAxisSpacing: h(context, 15),
                  childAspectRatio: 1.02,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                        if (index == 0) {
                          Get.toNamed(AppRoutes.rechargeScreenRoutes);
                        } else if (index == 1) {
                          Get.toNamed(AppRoutes.myBankDetailsScreenRoutes);
                        }
                        else if(index==2){
                          Get.toNamed(AppRoutes.sendAmountScreenRoutes);
                        }else if(index==3){
                          Get.toNamed(AppRoutes.lockAmountScreenRoutes);
                        }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            controller.imagePaths[index],
                            fit: BoxFit.cover,
                          ),
                          Gap(h(context, 10)),
                          Text(controller.text[index].toString(),
                              textAlign: TextAlign.center,
                              style: AppStyle.style(f(context, 16),
                                  fontColor: ColorConstant.primaryBlack,
                                  fontFamily: 'Inter')),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Gap(h(context, 18)),
              Text(
                AppString.transaction.tr,
                style: AppStyle.style(f(context, 15),
                    fontFamily: "Inter", fontWeight: FontWeight.bold),
              ),
              Obx(
                ()=>APIs.isApiLoading.value? const YourShimmeringListView(height: 0.1,padding: false,):APIs.noTransation.isTrue? Center(heightFactor:5,child: const Text("No Transaction data...")):ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: APIs.transactionList.length,
                  itemBuilder: (context, index) {
                     Transaction transation = APIs.transactionList[index];
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              color: ColorConstant.green,
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: ColorConstant.primaryWhite,
                            child: Text(
                              transation.amount.toString(),
                              style: AppStyle.style(f(context, 16),
                                  fontColor: ColorConstant.green,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        title: Text(
                          transation.type.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: AppStyle.style(f(context, 11),
                              fontFamily: 'Inter', fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(formatDateAndTime(transation.createdAt.toString()),
                            style: AppStyle.style(f(context, 11),
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  );

                },),
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatDateAndTime(String timestamp) {
    // Parse the timestamp string to DateTime object
    DateTime dateTime = DateTime.parse(timestamp);

    // Customize the date and time format using intl package
    final DateFormat dateFormat = DateFormat('dd-MMM-yyyy hh:mm a');

    // Format the DateTime object to the desired format
    return dateFormat.format(dateTime);
  }
}
