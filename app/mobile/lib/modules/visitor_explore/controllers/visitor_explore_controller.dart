import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/modules/opening/controllers/opening_controller.dart';
import 'package:mobile/modules/visitor_explore/providers/explore_provider.dart';

//import '../../../routes/app_pages.dart';

class VisitorExploreController extends GetxController {
  RxList<Spot> spots = <Spot>[].obs;
  RxList<EnigmaUser> users = <EnigmaUser>[].obs;
  RxList<InterestArea> bunches = <InterestArea>[].obs;

  final routeLoading = true.obs;

  final exploreProvider = Get.find<ExploreProvider>();

  final _openingController = Get.find<OpeningController>();

  /*void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails, arguments: {'post': post, 'visitor': true});
  }

  void navigateToProfile(int id) {
    Get.toNamed(Routes.profile, arguments: {'userId': id});
  }

  void navigateToIa(InterestArea ia) {
    Get.toNamed(Routes.interestArea, arguments: {'interestArea': ia});
  }*/

  void navigateToSignUp() {
    _openingController.backToAuth(false);
  }

  void navigateToLogIn() {
    _openingController.backToAuth(true);
  }

  void fetchData() async {
    try {
      final res = await exploreProvider.getExplore();
      if (res != null) {
        spots.value = res['posts']! as List<Spot>;
        users.value = res['profiles']! as List<EnigmaUser>;
        bunches.value = res['bunches']! as List<InterestArea>;
      }
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
