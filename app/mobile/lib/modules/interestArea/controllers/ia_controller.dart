import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/interestArea/providers/ia_provider.dart';

import '../../../routes/app_pages.dart';

class InterestAreaController extends GetxController {
  final bottomNavigationController = Get.find<BottomNavigationController>();
  final iaProvider = Get.find<IaProvider>();

  var routeLoading = true.obs;
  InterestArea interestArea = Get.arguments['interestArea'];
  RxList<Spot> posts = <Spot>[].obs;
  RxList<EnigmaUser> followers = <EnigmaUser>[].obs;
  RxList<InterestArea> nestedIas = <InterestArea>[].obs;



  void navigateToEdit() {
    Get.toNamed(Routes.editIa, arguments: {'interestArea': interestArea});
  }

  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void fetchData() async {
    try {
      posts.value = await iaProvider.getPosts(
              id: interestArea.id, token: bottomNavigationController.token) ??
          [];
      followers.value = await iaProvider.getFollowers(
              id: interestArea.id, token: bottomNavigationController.token) ??
          [];
      nestedIas.value = await iaProvider.getNestedIas(
              id: interestArea.id, token: bottomNavigationController.token) ??
          [];
      routeLoading.value = false;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void navigateToIa(InterestArea ia) {
    routeLoading.value = true;
    interestArea = ia;
    fetchData();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {}
}
