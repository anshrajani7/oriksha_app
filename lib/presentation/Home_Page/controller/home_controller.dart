import 'package:oriksha_application/core/Utils/common_constor.dart';
import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/DashBord_Page/controller/dashbord_controller.dart';
import 'package:oriksha_application/presentation/DashBord_Page/dashbord_screen.dart';
import 'package:oriksha_application/presentation/Driver_DashBord_Page/controller/driver_dashbord_controller.dart';
import 'package:oriksha_application/presentation/Driver_DashBord_Page/driver_dashbrord_screen.dart';
import 'package:oriksha_application/presentation/Profile_Page/controller/profile_controller.dart';
import 'package:oriksha_application/presentation/Profile_Page/profile_screen.dart';
import 'package:oriksha_application/presentation/Setting_Page/controller/setting_controller.dart';
import 'package:oriksha_application/presentation/Setting_Page/setting_screen.dart';
import 'package:oriksha_application/presentation/Wallet_Page/controller/wallet_controller.dart';
import 'package:oriksha_application/presentation/Wallet_Page/wallet_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreenController extends GetxController{

  final controller = PersistentTabController(initialIndex: 0 ).obs;
  var selectedIndex = 0.obs;
  void changeIndex(int index) {
      selectedIndex.value = index;
  }
  RxInt status=1.obs;
@override
  onInit(){
   status.value = Constant.instance.dbHelper.driver.get(HiveKeys.status);
  super.onInit();
}
  RxList<Widget> buildScreens() {
    switch (status.value) {
      case 2:
        return [
          GetBuilder<DashBordScreenController>(
            init: DashBordScreenController(),
            builder: (_) => const DashBordScreen(),
          ),
          GetBuilder<ProfileScreenController>(
            init: ProfileScreenController(),
            builder: (_) => const ProfileScreen(),
          ),
          GetBuilder<WalletScreenController>(
            init: WalletScreenController(),
            builder: (_) => const WalletScreen(),
          ),
          GetBuilder<SettingScreenController>(
            init: SettingScreenController(),
            builder: (_) => const SettingScreen(),
          ),
        ].obs;
      case 1:
        return [
          GetBuilder<DriverDashBordScreenController>(
            init: DriverDashBordScreenController(),
            builder: (_) => const DriverDashBordScreen(),
          ),
          GetBuilder<ProfileScreenController>(
            init: ProfileScreenController(),
            builder: (_) => const ProfileScreen(),
          ),
          GetBuilder<WalletScreenController>(
            init: WalletScreenController(),
            builder: (_) => const WalletScreen(),
          ),
          GetBuilder<SettingScreenController>(
            init: SettingScreenController(),
            builder: (_) => const SettingScreen(),
          ),
        ].obs;
      default:
        return [
          GetBuilder<DashBordScreenController>(
            init: DashBordScreenController(),
            builder: (_) => const DashBordScreen(),
          ),
          GetBuilder<ProfileScreenController>(
            init: ProfileScreenController(),
            builder: (_) => const ProfileScreen(),
          ),
          GetBuilder<WalletScreenController>(
            init: WalletScreenController(),
            builder: (_) => const WalletScreen(),
          ),
          GetBuilder<SettingScreenController>(
            init: SettingScreenController(),
            builder: (_) => const SettingScreen(),
          ),
        ].obs;
    }
  }

}