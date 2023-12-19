import 'package:get/get.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/geolocation_model.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/wiki_tag.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../../routes/app_pages.dart';

class VisitorExploreController extends GetxController {
  RxList<Spot> posts = <Spot>[].obs;

  final routeLoading = true.obs;

  //final bottomNavigationController = Get.find<BottomNavigationController>();
  //final homeProvider = Get.find<HomeProvider>();

  var searchQuery = ''.obs;
  var searchPosts = <Spot>[].obs;
  var searchUsers = <EnigmaUser>[].obs;
  var searchIas = <InterestArea>[].obs;

  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails, arguments: {'post': post, 'visitor': true});
  }

  /*void onSearchQueryChanged(String value) {
    searchQuery.value = value;
    searchPosts.clear();
    searchUsers.clear();
    searchIas.clear();
    if (value.isNotEmpty) {
      search();
    } else {
      fetchData();
    }
  }*/

  /*void search() async {
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
  }*/

  void navigateToProfile(int id) {
    Get.toNamed(Routes.profile, arguments: {'userId': id});
  }

  void navigateToIa(InterestArea ia) {
    Get.toNamed(Routes.interestArea, arguments: {'interestArea': ia});
  }

  void fetchData() async {
    /*try {
      posts.value = await homeProvider.getHomePage(
              token: bottomNavigationController.token) ??
          [];
      routeLoading.value = false;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }*/
    posts = RxList(dummySpots);
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {}

  final dummySpots = <Spot>[
    Spot(
      id: 50001,
      enigmaUser: EnigmaUser(
        id: 70001,
        username: "marcolphin",
        name: "Meriç Keskin",
        email: "mericyk@gmail.com",
        birthday: "11.08.2001",
        createTime: "15.12.2023",
      ),
      interestArea: InterestArea(
        id: 30001,
        enigmaUserId: 70001,
        accessLevel: "public",
        name: "Sample Bunch",
        nestedInterestAreas: [],
        wikiTags: [],
        createTime: DateTime.now(),
        description:
            "description description description description description description description description description description description description",
      ),
      sourceLink: "www.sample-source-link.com",
      title: "Sample Spot",
      wikiTags: [
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
      ],
      label: "Sample Label",
      content:
          "content content content content content content content content content content content content content content content content content",
      geolocation:
          Geolocation(latitude: 26.0, longitude: 39.0, address: "Turkey"),
      createTime: "17.12.2023",
      commentCount: 5,
      upvoteCount: 5,
      downvoteCount: 5,
    ),
    Spot(
      id: 50001,
      enigmaUser: EnigmaUser(
        id: 70001,
        username: "marcolphin",
        name: "Meriç Keskin",
        email: "mericyk@gmail.com",
        birthday: "11.08.2001",
        createTime: "15.12.2023",
      ),
      interestArea: InterestArea(
        id: 30001,
        enigmaUserId: 70001,
        accessLevel: "public",
        name: "Sample Bunch",
        nestedInterestAreas: [],
        wikiTags: [],
        createTime: DateTime.now(),
        description:
            "description description description description description description description description description description description description",
      ),
      sourceLink: "www.sample-source-link.com",
      title: "Sample Spot",
      wikiTags: [
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
      ],
      label: "Sample Label",
      content:
          "content content content content content content content content content content content content content content content content content",
      geolocation:
          Geolocation(latitude: 26.0, longitude: 39.0, address: "Turkey"),
      createTime: "17.12.2023",
      commentCount: 5,
      upvoteCount: 5,
      downvoteCount: 5,
    ),
    Spot(
      id: 50001,
      enigmaUser: EnigmaUser(
        id: 70001,
        username: "marcolphin",
        name: "Meriç Keskin",
        email: "mericyk@gmail.com",
        birthday: "11.08.2001",
        createTime: "15.12.2023",
      ),
      interestArea: InterestArea(
        id: 30001,
        enigmaUserId: 70001,
        accessLevel: "public",
        name: "Sample Bunch",
        nestedInterestAreas: [],
        wikiTags: [],
        createTime: DateTime.now(),
        description:
            "description description description description description description description description description description description description",
      ),
      sourceLink: "www.sample-source-link.com",
      title: "Sample Spot",
      wikiTags: [
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
      ],
      label: "Sample Label",
      content:
          "content content content content content content content content content content content content content content content content content",
      geolocation:
          Geolocation(latitude: 26.0, longitude: 39.0, address: "Turkey"),
      createTime: "17.12.2023",
      commentCount: 5,
      upvoteCount: 5,
      downvoteCount: 5,
    ),
    Spot(
      id: 50001,
      enigmaUser: EnigmaUser(
        id: 70001,
        username: "marcolphin",
        name: "Meriç Keskin",
        email: "mericyk@gmail.com",
        birthday: "11.08.2001",
        createTime: "15.12.2023",
      ),
      interestArea: InterestArea(
        id: 30001,
        enigmaUserId: 70001,
        accessLevel: "public",
        name: "Sample Bunch",
        nestedInterestAreas: [],
        wikiTags: [],
        createTime: DateTime.now(),
        description:
            "description description description description description description description description description description description description",
      ),
      sourceLink: "www.sample-source-link.com",
      title: "Sample Spot",
      wikiTags: [
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
      ],
      label: "Sample Label",
      content:
          "content content content content content content content content content content content content content content content content content",
      geolocation:
          Geolocation(latitude: 26.0, longitude: 39.0, address: "Turkey"),
      createTime: "17.12.2023",
      commentCount: 5,
      upvoteCount: 5,
      downvoteCount: 5,
    ),
    Spot(
      id: 50001,
      enigmaUser: EnigmaUser(
        id: 70001,
        username: "marcolphin",
        name: "Meriç Keskin",
        email: "mericyk@gmail.com",
        birthday: "11.08.2001",
        createTime: "15.12.2023",
      ),
      interestArea: InterestArea(
        id: 30001,
        enigmaUserId: 70001,
        accessLevel: "public",
        name: "Sample Bunch",
        nestedInterestAreas: [],
        wikiTags: [],
        createTime: DateTime.now(),
        description:
            "description description description description description description description description description description description description",
      ),
      sourceLink: "www.sample-source-link.com",
      title: "Sample Spot",
      wikiTags: [
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
      ],
      label: "Sample Label",
      content:
          "content content content content content content content content content content content content content content content content content",
      geolocation:
          Geolocation(latitude: 26.0, longitude: 39.0, address: "Turkey"),
      createTime: "17.12.2023",
      commentCount: 5,
      upvoteCount: 5,
      downvoteCount: 5,
    ),
    Spot(
      id: 50001,
      enigmaUser: EnigmaUser(
        id: 70001,
        username: "marcolphin",
        name: "Meriç Keskin",
        email: "mericyk@gmail.com",
        birthday: "11.08.2001",
        createTime: "15.12.2023",
      ),
      interestArea: InterestArea(
        id: 30001,
        enigmaUserId: 70001,
        accessLevel: "public",
        name: "Sample Bunch",
        nestedInterestAreas: [],
        wikiTags: [],
        createTime: DateTime.now(),
        description:
            "description description description description description description description description description description description description",
      ),
      sourceLink: "www.sample-source-link.com",
      title: "Sample Spot",
      wikiTags: [
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
        WikiTag(
          id: "90001",
          label: "sampletag",
          description: "description",
          isValidTag: true,
        ),
      ],
      label: "Sample Label",
      content:
          "content content content content content content content content content content content content content content content content content",
      geolocation:
          Geolocation(latitude: 26.0, longitude: 39.0, address: "Turkey"),
      createTime: "17.12.2023",
      commentCount: 5,
      upvoteCount: 5,
      downvoteCount: 5,
    ),
  ];

  final dummyUsers = <EnigmaUser>[
    EnigmaUser(
      id: 70001,
      username: "username",
      name: "Sample User",
      email: "sample@user.com",
      birthday: "01.01.2001",
      createTime: "15.12.2023",
    ),
    EnigmaUser(
      id: 70001,
      username: "username",
      name: "Sample User",
      email: "sample@user.com",
      birthday: "01.01.2001",
      createTime: "15.12.2023",
    ),
    EnigmaUser(
      id: 70001,
      username: "username",
      name: "Sample User",
      email: "sample@user.com",
      birthday: "01.01.2001",
      createTime: "15.12.2023",
    ),
    EnigmaUser(
      id: 70001,
      username: "username",
      name: "Sample User",
      email: "sample@user.com",
      birthday: "01.01.2001",
      createTime: "15.12.2023",
    ),
    EnigmaUser(
      id: 70001,
      username: "username",
      name: "Sample User",
      email: "sample@user.com",
      birthday: "01.01.2001",
      createTime: "15.12.2023",
    ),
    EnigmaUser(
      id: 70001,
      username: "username",
      name: "Sample User",
      email: "sample@user.com",
      birthday: "01.01.2001",
      createTime: "15.12.2023",
    ),
    EnigmaUser(
      id: 70001,
      username: "username",
      name: "Sample User",
      email: "sample@user.com",
      birthday: "01.01.2001",
      createTime: "15.12.2023",
    ),
  ];
}
