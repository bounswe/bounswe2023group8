import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/interestArea/providers/ia_provider.dart';

import '../../../routes/app_pages.dart';

class InterestAreaController extends GetxController {
  final bottomNavigationController = Get.find<BottomNavigationController>();
  final iaProvider = Get.find<IaProvider>();

  var routeLoading = true.obs;
  late final InterestArea interestArea;

  void getInterestArea() async {
    // id will be taken as route argument
    try {
      final ia = await iaProvider.getIa(
        id: 27,
        token: bottomNavigationController.token,
      );
      if (ia != null) {
        interestArea = ia;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
    routeLoading.value = false;
  }

  void navigateToEdit() {
    Get.toNamed(Routes.editIa, arguments: {'interestArea': interestArea});
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();

    getInterestArea();
  }


  RxList<Spot> posts = <Spot>[].obs;


  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void fetchData() {
  }

  @override
  void onClose() {}
}
