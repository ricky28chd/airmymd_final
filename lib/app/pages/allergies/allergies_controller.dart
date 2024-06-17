import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/domain/domain.dart';

class AllergiesController extends GetxController {
  AllergiesController(this._allergiesPresenter);
  final AllergiesPresenter _allergiesPresenter;
  var reactionList = <Widget>[];
  var foodAllergyList = <Widget>[];
  var typeList = <String>[];
  var nameControllerList = <TextEditingController>[];
  var nameControllerListError = '';
  var commentControllerList = <TextEditingController>[];
  var commentControllerListError = '';

  Widget addReaction({String title = "", String comment = ""}) {
    var drugController = TextEditingController();
    var commentController = TextEditingController();
    typeList.add('Reaction');
    nameControllerList.add(drugController);
    commentControllerList.add(commentController);
    drugController.text = title;
    commentController.text = comment;
    return reactionField(
      drugController: drugController,
      commentController: commentController,
    );
  }

  Widget addFoodAllergies({String title = "", String comment = ""}) {
    var foodNameController = TextEditingController();
    var commController = TextEditingController();
    typeList.add('Allergy');
    nameControllerList.add(foodNameController);
    commentControllerList.add(commController);
    foodNameController.text = title;
    commController.text = comment;
    return allergiesField(
      foodNameController: foodNameController,
      commController: commController,
    );
  }

  void removeReaction(index) {
    reactionList.removeAt(index);
    update();
  }

  void removeFoodAllergy(index) {
    foodAllergyList.removeAt(index);
    update();
  }

  var navigateFrom = Get.arguments['NavigateFrom'];

  ///This method will only hit api when [nameControllerList[index=0]] and
  /// [commentControllerList[index=0]]
  Future<void> onSaveButtonClicked() async {
    var allergies = <Map<String, dynamic>>[];
    var totalLength = reactionList.length + foodAllergyList.length;
    for (int i = 0; i < totalLength; i++) {
      var type = typeList[i];
      var name = nameControllerList[i].text;
      var comment = commentControllerList[i].text;
      allergies.add({'type': type, 'name': name, 'comment': comment});
    }
    if (nameControllerList[0].text != '' &&
        commentControllerList[0].text != '') {
      var response = await _allergiesPresenter.allergyUserModel(map: allergies);
      if (response.data != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage(
            'Allergies Updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToMedicalHistoryScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _allergiesPresenter.allergyUserModel(map: allergies);
        NavigateTo.goToProfileSettingScreen();
        Utility.showMessage(
          'Allergies Updated successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        NavigateTo.goToMedicalHistoryScreen();
      }
      update();
    }
  }

  bool isLoading = false;

  Future<void> getAllergies() async {
    isLoading = true;
    try {
      var response = await _allergiesPresenter.getAllergy(
        isLoading: true,
      );
      if (response.data!.isNotEmpty) {
        foodAllergyList.clear();
        reactionList.clear();
        for (var val in response.data!) {
          (val.type == 'Allergy')
              ? foodAllergyList.add(addFoodAllergies(
                  title: val.name.toString(), comment: val.comment.toString()))
              : reactionList.add(addReaction(
                  title: val.name.toString(), comment: val.comment.toString()));
        }
      } else {
        reactionList.add(addReaction());
        foodAllergyList.add(addFoodAllergies());
      }
    } finally {
      isLoading = false;
    }
    update();
  }

  @override
  void onInit() {
    if (navigateFrom == 'Setting Screen') {
      getAllergies();
    } else {
      reactionList.add(addReaction());
      foodAllergyList.add(addFoodAllergies());
    }

    super.onInit();
  }
}
