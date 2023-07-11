part of '../view.dart';

class Uploaded extends StatefulWidget {
  const Uploaded({Key? key}) : super(key: key);

  @override
  State<Uploaded> createState() => _UploadedState();
}

class _UploadedState extends State<Uploaded> {
  @override
  void initState() {
    //PackageCubit.get(context).SubscribePackageTest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      widget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.sp),
        child: Column(
          children: [
            SizedBox(
              height: 18.h,
            ),
            CustomCardTitle(
              text: 'ADVERTISEMENTS',
            ),
             MyAdvertismentTable(),

          ],
        ),
      ),
    );
  }
}
