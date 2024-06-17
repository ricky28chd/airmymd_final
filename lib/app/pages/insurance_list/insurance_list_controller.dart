import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/get_insurance_list_response.dart';

class InsuranceListController extends GetxController {
  InsuranceListController(this._insuranceListPresenter);
  final InsuranceListPresenter _insuranceListPresenter;

  List<Datum> allInsuranceList = [];

  var insuranceListError = '';

  Future<void> getInsuranceList() async {
    try {
      allInsuranceList.clear();
      var response = await _insuranceListPresenter.getInsuranceList(
        isLoading: true,
      );
      if (response.data != null) {
        if (response.data!.isEmpty) {
          insuranceListError = 'Looks like you haven’t added any insurance yet';
        }
        allInsuranceList = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  Future<void> deleteInsuranceCard({
    required String insuranceId,
  }) async {
    Utility.closeSnackBar();
    Utility.closeDialog();
    Utility.closeLoader();
    var response = await _insuranceListPresenter.deleteInsuranceCard(
      insuranceId: insuranceId,
      isLoading: true,
    );
    if (response.data != null) {
      await getInsuranceList();
      Utility.showMessage(
        'Insurance deleted successfully',
        MessageType.information,
        () => Utility.closeSnackBar(),
        'Okay',
      );
    }
  }

  Future<void> onRefreshInsurance() async => getInsuranceList();

  Future<void> readNotification() async {
    var response = await _insuranceListPresenter.readNotification(
      isLoading: true,
    );
    if (response.data != null) {
      notificationCount = 0;
      update();
    }
  }

  Future<void> unreadMessages() async {
    var response = await _insuranceListPresenter.unreadMessages(
      isLoading: true,
    );
    if (response.data != null) {
      unreadMessage = response.data!;
    }
    update();
  }

  Future<void> readMessages() async {
    var response = await _insuranceListPresenter.readMessages(
      isLoadig: true,
    );
    if (response.data != null) {
      unreadMessage = 0;
      update();
    }
  }

  Future<void> getNotificationList() async {
    var response = await _insuranceListPresenter.getNotificationList(
      isLoading: false,
    );
    if (response.data != null) {
      notificationCount = response.data!.unreadCount!;
    }
    update();
  }

  @override
  void onInit() {
    print('helloooooooooooooooo');
    getInsuranceList();
    super.onInit();
    getNotificationList();
    unreadMessages();
  }
}
