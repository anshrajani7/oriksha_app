
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


class DbHelper {
  late Box<dynamic> driver; // Specify the type of the box
  late Box<dynamic> passenger; // Specify the type of the box

  Future<void> initHive() async {
      final document = await getApplicationDocumentsDirectory();
      Hive.init(document.path);
      driver = await Hive.openBox('DRIVER_BOX');
      passenger = await Hive.openBox('PASSENGER_BOX');
  }

}
