import 'package:get/get.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/models/movie.dart';

class ActorsController extends GetxController {
  var isLoading = false.obs;
  var mainTopActors = <Actor>[].obs;
  var watchListActors = <Actor>[].obs;
  @override
  void onInit() async {
    isLoading.value = true;
    mainTopActors.value = (await ApiService.getActors())!;
    isLoading.value = false;
    super.onInit();
  }

  bool isInWatchList(Actor actor) {
    return watchListActors.any((a) => a.id == actor.id);
  }

  void addToWatchList(Actor actor) {
    if (watchListActors.any((a) => a.id == actor.id)) {
      watchListActors.remove(actor);
      Get.snackbar('Success', 'removed from favourite actors',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListActors.add(actor);
      Get.snackbar('Success', 'added to favourite actors',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}
