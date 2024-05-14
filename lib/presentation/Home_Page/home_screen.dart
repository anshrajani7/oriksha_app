import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Home_Page/controller/home_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          controller.changeIndex(0);
          controller.controller.value.index = 0;
          return false; // Returning false will prevent the default back button behavior
        }
        return true;
      },
      child: PersistentTabView(
            backgroundColor: ColorConstant.primaryOrg,
            context,

            navBarStyle: NavBarStyle.style3,
            screens: controller.buildScreens(),
            controller: controller.controller.value,
            items: navBarsItems(),
          confineInSafeArea: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          handleAndroidBackButtonPress: true,
          // hideNavigationBarWhenKeyboardShows: true,
      ),
    );

  }
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon:
        Obx(
              ()=> SvgPicture.asset(
            "assets/icons/HomeIcon.svg",
            color: controller.selectedIndex.value == 0
                ? Colors.black // Set the active color here
                : Colors.white, // Set the inactive color here
          ),
        ),
        onPressed: (p0) {
          controller.changeIndex(0);
          controller.controller.value.index=0;
          // controller.controller[0];
        },
        inactiveColorPrimary: Colors.white,
        activeColorPrimary: Colors.black,
        iconSize: 35,
      ),
      PersistentBottomNavBarItem(
        icon:  Obx(
      ()=> SvgPicture.asset(
            "assets/icons/ProfileIcon.svg",
            color: controller.selectedIndex.value == 1
                ? Colors.black // Set the active color here
                : Colors.white, // Set the inactive color here
          ),
        ),
        onPressed: (p0) {
          controller.changeIndex(1);
          controller.controller.value.index=1;

        },
        inactiveColorPrimary: Colors.white,
        activeColorPrimary: Colors.black,
        iconSize: 35,
      ),
      PersistentBottomNavBarItem(
        icon: Obx(
    ()=> SvgPicture.asset(
            "assets/icons/Wallet.svg",
            color: controller.selectedIndex.value == 2
                ? Colors.black // Set the active color here
                : Colors.white, // Set the inactive color here
          ),
        ),
        onPressed: (p0) {
          controller.changeIndex(2);
          controller.controller.value.index=2;

        },
        inactiveColorPrimary: Colors.white,
        activeColorPrimary: Colors.black,
        iconSize: 35,
      ),
      PersistentBottomNavBarItem(
        icon: Obx(
    ()=> SvgPicture.asset(
            "assets/icons/Setting.svg",
            color:controller.selectedIndex.value == 3
                ? Colors.black // Set the active color here
                : Colors.white, // Set the inactive color here
          ),
        ),
        onPressed: (p0) {
          controller.changeIndex(3);
          controller.controller.value.index=3;
        },
        inactiveColorPrimary: Colors.white,
        activeColorPrimary: Colors.black,
        iconSize: 35,
      ),
    ];
  }
}

