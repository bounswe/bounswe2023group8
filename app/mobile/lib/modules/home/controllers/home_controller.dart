import 'package:get/get.dart';
import 'package:mobile/data/models/spot.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxList<Spot> posts = <Spot>[].obs;



  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void fetchData() {
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {}
}
