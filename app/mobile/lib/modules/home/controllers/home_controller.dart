import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/home/providers/home_provider.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxList<Spot> posts = <Spot>[].obs;

  final routeLoading = true.obs;

  final bottomNavigationController = Get.find<BottomNavigationController>();
  final homeProvider = Get.find<HomeProvider>();

  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void fetchData() async {
    try {
      posts.value = await homeProvider.getHomePage(
              token: bottomNavigationController.token) ??
          [];
      routeLoading.value = false;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {}
}
