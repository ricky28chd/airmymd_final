import 'package:airmymd/app/app.dart';

class InsuranceListWidget extends StatelessWidget {
  const InsuranceListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InsuranceListController>(builder: (controller) {
      return SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Column(
              children: [
                controller.allInsuranceList.isEmpty
                    ? Center(
                        child: SizedBox(
                            height: Get.height / 1.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.insuranceListError,
                                  textAlign: TextAlign.center,
                                ),
                                AppSizeBox.height_3,
                                controller.insuranceListError == ''
                                    ? Container()
                                    : GlobalButtons().primaryButton(
                                        text: 'Add New',
                                        onTap: () {
                                          NavigateTo.goToAddInsuranceScreen(
                                            id: "0",
                                            navigateFrom: 'insuranceList',
                                          );
                                        },
                                      )
                              ],
                            )),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.allInsuranceList[index].phone
                                      .toString()),
                                  Text(controller
                                      .allInsuranceList[index].provider
                                      .toString())
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      NavigateTo.goToAddInsuranceScreen(
                                        id: controller
                                            .allInsuranceList[index].id
                                            .toString(),
                                        navigateFrom: 'insuranceList',
                                        memberId: controller
                                            .allInsuranceList[index].phone,
                                        groupNumber: controller
                                            .allInsuranceList[index]
                                            .groupNumber,
                                        providerName: controller
                                            .allInsuranceList[index].provider,
                                        image: controller
                                            .allInsuranceList[index].image
                                            .toString(),
                                      );
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyles.extraBoldBlue13,
                                    ),
                                  ),
                                  const VerticalDivider(),
                                  GestureDetector(
                                    onTap: () {
                                      Utility.showAlertDialogue(
                                          'Are you sure you want to delete this Insurance?',
                                          'Delete Insurance', () {
                                        controller.deleteInsuranceCard(
                                          insuranceId: controller
                                              .allInsuranceList[index].id
                                              .toString(),
                                        );
                                      });
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyles.extraBoldRed13,
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 1,
                            height: 30,
                          );
                        },
                        itemCount: controller.allInsuranceList.length),
                AppSizeBox.height_10,
                controller.allInsuranceList.isEmpty
                    ? Container()
                    : insuranceListButtonWidget(),
                AppSizeBox.height_5,
              ],
            ),
          ));
    });
  }
}
