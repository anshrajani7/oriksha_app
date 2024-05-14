import 'package:oriksha_application/presentation/PostFeedBack_page/controller/postfeedback_controller.dart';
import 'package:get/get.dart';

class PostFeedBackBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PostFeedBackController());
  }

}