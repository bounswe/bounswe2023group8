import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/home/providers/home_provider.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxList<Spot> posts = <Spot>[].obs;

  final routeLoading = true.obs;

  final bottomNavigationController = Get.find<BottomNavigationController>();
  final homeProvider = Get.find<HomeProvider>();

  var searchQuery = ''.obs;
  var searchPosts = <Spot>[].obs;
  var searchUsers = <EnigmaUser>[].obs;
  var searchIas = <InterestArea>[].obs;

  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void onSearchQueryChanged(String value) {
    searchQuery.value = value;
    searchPosts.clear();
    searchUsers.clear();
    searchIas.clear();
    if (value.isNotEmpty) {
      search();
    }
  }

  void search() async {
    try {
      final searchMap = await homeProvider.globalSearch(
          searchKey: searchQuery.value,
          token: bottomNavigationController.token);
      if (searchMap != null) {
        searchPosts.value = searchMap['posts'] ?? [];
        searchUsers.value = searchMap['users'] ?? [];
        searchIas.value = searchMap['interestAreas'] ?? [];
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void navigateToIa(InterestArea ia) {
    Get.toNamed(Routes.interestArea, arguments: {'interestArea': ia});
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
