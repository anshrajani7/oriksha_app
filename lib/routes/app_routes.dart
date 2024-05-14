import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/DashBord_Page/binding/dashbord_binding.dart';
import 'package:oriksha_application/presentation/DashBord_Page/dashbord_screen.dart';
import 'package:oriksha_application/presentation/Driver_Details_Page/binding/driver_details_binding.dart';
import 'package:oriksha_application/presentation/Driver_Details_Page/diver_detalis_screen.dart';
import 'package:oriksha_application/presentation/Driver_Map_Page/binding/driver_map_binding.dart';
import 'package:oriksha_application/presentation/Driver_Map_Page/driver_map_screen.dart';
import 'package:oriksha_application/presentation/Driver_Vehicle_Details_Page/binding/driver_vehicle_details_binding.dart';
import 'package:oriksha_application/presentation/Driver_Vehicle_Details_Page/driver_vehicle_details_screen.dart';
import 'package:oriksha_application/presentation/Forgate_Password_Page/binding/forgate_password_binding.dart';
import 'package:oriksha_application/presentation/Forgate_Password_Page/forgate_password_screen.dart';
import 'package:oriksha_application/presentation/Home_Page/binding/home_binding.dart';
import 'package:oriksha_application/presentation/Home_Page/home_screen.dart';
import 'package:oriksha_application/presentation/Legal_page/binding/legal_bindign.dart';
import 'package:oriksha_application/presentation/Legal_page/legal_screen.dart';
import 'package:oriksha_application/presentation/Lock_Amount_Page/binding/lock_amount_binding.dart';
import 'package:oriksha_application/presentation/Lock_Amount_Page/lock_amount_screen.dart';
import 'package:oriksha_application/presentation/Login_screen/binding/login_binding.dart';
import 'package:oriksha_application/presentation/Login_screen/login_screen.dart';
import 'package:oriksha_application/presentation/MyBankDetails_QRCode_Page/binding/mybankdetails_QRcode_binding.dart';
import 'package:oriksha_application/presentation/MyBankDetails_QRCode_Page/mybankdetails_QRcode_screen.dart';
import 'package:oriksha_application/presentation/Onboarding_screen/binding/onboarding_binding.dart';
import 'package:oriksha_application/presentation/Onboarding_screen/onboarding_screen.dart';
import 'package:oriksha_application/presentation/PostFeedBack_page/binding/postfeedback_binding.dart';
import 'package:oriksha_application/presentation/PostFeedBack_page/postfeedback_screen.dart';
import 'package:oriksha_application/presentation/Profile_Page/binding/profile_binding.dart';
import 'package:oriksha_application/presentation/Profile_Page/profile_screen.dart';
import 'package:oriksha_application/presentation/Recharge_Page/binding/recharge_binding.dart';
import 'package:oriksha_application/presentation/Recharge_Page/recharge_screen.dart';
import 'package:oriksha_application/presentation/Register_screen/binding/register_binding.dart';
import 'package:oriksha_application/presentation/Register_screen/register_screen.dart';
import 'package:oriksha_application/presentation/Send_Amount_Page/binding/send_amount_binding.dart';
import 'package:oriksha_application/presentation/Serch_Page/binding/serch_binding.dart';
import 'package:oriksha_application/presentation/Serch_Page/serch_screen.dart';
import 'package:oriksha_application/presentation/Setting_Page/binding/setting_binding.dart';
import 'package:oriksha_application/presentation/Setting_Page/setting_screen.dart';
import 'package:oriksha_application/presentation/Splash_screen/binding/splash_binding.dart';
import 'package:oriksha_application/presentation/Splash_screen/splash_screen.dart';
import 'package:oriksha_application/presentation/Transaction_Successfully_Page/binding/transaction_successfully_binding.dart';
import 'package:oriksha_application/presentation/Transaction_Successfully_Page/transaction_successfully_screen.dart';
import 'package:oriksha_application/presentation/Transactions_List_Page/binding/transaction_list_binding.dart';
import 'package:oriksha_application/presentation/Transactions_List_Page/transactions_list_screen.dart';
import 'package:oriksha_application/presentation/Transactions_details_page/binding/transactions_details_binding.dart';
import 'package:oriksha_application/presentation/Transactions_details_page/transactions_details_screen.dart';
import 'package:oriksha_application/presentation/Verify_Otp_Page/binding/verify_otp_binding.dart';
import 'package:oriksha_application/presentation/Verify_Otp_Page/verify_otp_screen.dart';
import 'package:oriksha_application/presentation/Wallet_Page/binding/wallet_binding.dart';
import 'package:oriksha_application/presentation/Wallet_Page/wallet_screen.dart';
import 'package:oriksha_application/presentation/Welcome_dailog_page/binding/welcome_dailog_binding.dart';
import 'package:oriksha_application/presentation/Welcome_dailog_page/welcome_dailog_screen.dart';

import '../presentation/Cusrtomer_Details_Page/binding/cusrtomer_details_binding.dart';
import '../presentation/Cusrtomer_Details_Page/customer_details_screen.dart';
import '../presentation/Send_Amount_Page/send_amount_screen.dart';

class AppRoutes {
  static const String splashScreenRoutes = "/splashScreenRoutes";
  static const String onBoardingScreenRoute = "/onBoardingScreenRoute";
  static const String customerDetailsScreenRoutes =
      "/customerDetailsScreenRoutes";
  static const String drivervehicledetailsScreenRoutes =
      "/drivervehicledetailsScreenRoutes";
  static const String loginScreenRoutes = "/loginScreenRoutes";
  static const String registerScreenRoutes = "/registerScreenRoutes";
  static const String driverDetailsScreenRoutes = "/driverDetailsScreenRoutes";
  static const String homeScreenRoutes = "/homeScreenRoutes";
  static const String profileScreenRoutes = "/profileScreenRoutes";
  static const String settingScreenRoutes = "/settingScreenRoutes";
  static const String walletScreenRoutes = "/walletScreenRoutes";
  static const String dashBordScreenRoutes = "/dashBordScreenRoutes";
  static const String serchScreenRoutes = "/serchScreenRoutes";
  static const String verifyOtpScreenRoutes = "/verifyOtpScreenRoutes";
  static const String myBankDetailsScreenRoutes = "/myBankDetailsScreenRoutes";
  static const String transactionListScreenRoutes =
      "/transactionListScreenRoutes";
  static const String transactionDetailsScreenRoutes =
      "/transactionDetailsScreenRoutes";
  static const String postFeedBackScreenRoutes = "/postFeedBackScreenRoutes";
  static const String welcomeDailogScreenRoutes = "/welcomeDailogScreenRoutes";
  static const String legalScreenRoutes = "/legalScreenRoutes";
  static const String rechargeScreenRoutes = "/rechargeScreenRoutes";
  static const String transactionSuccessfullyScreenRoutes = "/transactionSuccessfullyScreenRoutes";
  static const String driverMapScreenRoutes = "/driverMapScreenRoutes";
  static const String lockAmountScreenRoutes = "/lockAmountScreenRoutes";
  static const String sendAmountScreenRoutes = "/sendAmountScreenRoutes";
  static const String forgatePasswordScreenRoutes = "/forgatePasswordScreenRoutes";
  static List<GetPage> page = [
    GetPage(
        name: splashScreenRoutes,
        page: () => const SplashScreen(),
        bindings: [SplashBinding()],
      transitionDuration: Duration.zero,

        ),
    GetPage(
        name: onBoardingScreenRoute,
        page: () => const OnBoardingScreen(),
        bindings: [OnBoardingBinding()],
        transitionDuration: Duration.zero,


       ),
    GetPage(
        name: drivervehicledetailsScreenRoutes,
        page: () => DriverVehicleDetailsScreen(),
        bindings: [DriverVehicleDetailsBinding()],
      transition: Transition.rightToLeft,

        ),
    GetPage(
        name: customerDetailsScreenRoutes,
        page: () => const CustomerDetailsScreen(),
        bindings: [CustomerDetailsBinding()],
      transition: Transition.rightToLeft,

        ),
    GetPage(
        name: loginScreenRoutes,
        page: () => const LogInScreen(),
        bindings: [LogInBinding()],
      transition: Transition.rightToLeft,

       ),
    GetPage(
        name: registerScreenRoutes,
        page: () => const RegisterScreen(),
        bindings: [RegisterBinding()],
      transition: Transition.rightToLeft,

        ),
    GetPage(
        name: driverDetailsScreenRoutes,
        page: () => const DriverDetailsScreen(),
        bindings: [DriverDetailsBinding()],
      transition: Transition.rightToLeft,

        ),
    GetPage(
        name: verifyOtpScreenRoutes,
        page: () => const VerifyOtpScreen(),
        bindings: [VerifyOtpScreenBinding(),],
      transition: Transition.rightToLeft,
        ),
    GetPage(
      name: driverMapScreenRoutes,
      page: () => const DriverMapScreen(),
      bindings: [DriverMapScreenBinding(),],
      transition: Transition.rightToLeft,
    ),
    GetPage(
        name: serchScreenRoutes,
        page: () => const SerchScreen(),
        bindings: [SerchScreenBinding()],
        transition: Transition.rightToLeft,

      ),
    GetPage(
      name: dashBordScreenRoutes,
      page: () => const DashBordScreen(),
      bindings: [DashBordScreenBinding()],

    ),
    GetPage(
      name: homeScreenRoutes,
      page: () => const HomeScreen(),
      bindings: [HomeScreenBinding()],
    ),
    GetPage(
      name: settingScreenRoutes,
      page: () => const SettingScreen(),
      bindings: [SettingScreenBinding()],
    ),
    GetPage(
      name: walletScreenRoutes,
      page: () => const WalletScreen(),
      bindings: [WalletScreenBinding()],
    ),
    GetPage(
      name: profileScreenRoutes,
      page: () => const ProfileScreen(),
      bindings: [ProfileScreenBinding()],
    ),
    GetPage(
      name: myBankDetailsScreenRoutes,
      page: () => const MyBankDetailsScreen(),
      bindings: [MyBankDetailsBinding()],
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: transactionListScreenRoutes,
      page: () => const TransactionListScreen(),
      bindings: [TransactionListBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: transactionDetailsScreenRoutes,
      page: () => const TransactionDetailsScreen(),
      bindings: [TransactionDetailsBinding()],
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: postFeedBackScreenRoutes,
      page: () => const PostFeedBackScreen(),
      bindings: [PostFeedBackBinding()],
    ),
    GetPage(
      name: welcomeDailogScreenRoutes,
      page: () => const WelcomeDailogScreen(),
      bindings: [WelcomeDailogBinding()],
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: legalScreenRoutes,
      page: () => const LegalScreen(),
      bindings: [LegalBinding()],
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: rechargeScreenRoutes,
      page: () =>  RechargeScreen(),
      bindings: [RechargeBinding()],
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: lockAmountScreenRoutes,
      page: () =>  const LockAmountScreen(),
      bindings: [LockAmountScreenBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: sendAmountScreenRoutes,
      page: () =>  const SendAmountScreen(),
      bindings: [SendAmountScreenBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: forgatePasswordScreenRoutes,
      page: () =>  const ForgatePasswordScreen(),
      bindings: [ForgatePasswordScreenBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: transactionSuccessfullyScreenRoutes,
      page: () => const TransactionSuccessfullyScreen(),
      bindings: [TransactionSuccessfullyBinding()],
      showCupertinoParallax: true,
      transitionDuration: const Duration(milliseconds: 500),
      opaque: false,
      transition: Transition.downToUp,
    )

  ];
}
