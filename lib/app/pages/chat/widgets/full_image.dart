import 'package:airmymd/app/app.dart';

class DetailedImageView extends StatelessWidget {
  const DetailedImageView({super.key, required this.imageName});
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Text(
                'Done',
                style: AppTextStyle.appBarHeading,
              ),
            ),
          ),
          AppSizeBox.width_5,
        ],
      ),
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                fit: BoxFit.contain, image: NetworkImage(imageName))),
      ),
    );
  }
}
