import 'package:airmymd/app/app.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (contr) {
      return Scaffold(
        //backgroundColor: Colors.grey[200],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            contr.clearChache();
            await Get.to(const AddNoteScreen());
          },
          child: const Icon(
            Icons.add,
            size: 25,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: AppTextStyle.appBarHeading,
          ),
        ),
        body: const NotesWidget(),
      );
    });
  }
}
