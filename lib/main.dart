import 'package:oriksha_application/core/Utils/hive_keys.dart';
import 'package:oriksha_application/localization/AppTranslation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/Utils/common_constor.dart';
import 'core/app_export.dart';
import 'core/services/notification_services.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Constant.instance.dbHelper.initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NotificationService.initialize();
  await NotificationService.firebaseCloudMessagingListener();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var data=Constant.instance.dbHelper.driver.get(HiveKeys.language)??'en_GB';
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true, scaffoldBackgroundColor: Theme.of(context).customBackgroundColor),
      debugShowCheckedModeBanner: false,
      locale: Locale(data??"en_GB"),
      translationsKeys: AppTranslation.translationsKeys,
      getPages: AppRoutes.page,
      transitionDuration: const Duration(microseconds: 250),
      initialRoute: AppRoutes.splashScreenRoutes,
    );
  }
}
