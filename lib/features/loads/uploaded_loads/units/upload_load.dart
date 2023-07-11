part of '../view.dart';

class UploadedLoad extends StatefulWidget {
  const UploadedLoad({Key? key}) : super(key: key);

  @override
  State<UploadedLoad> createState() => _UploadedLoadState();
}

class _UploadedLoadState extends State<UploadedLoad> {
  @override
  void initState() {
    print('init upload Load Test');
    super.initState();
    LoadsCubit.get(context).addLoadCubitTest();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadsCubit, AddLoadStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (context, state) {
          print("is access token ${LoadsCubit.get(context).isAllowed}");

          return LoadsCubit.get(context).testLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.orange,
                ))
              : LoadsCubit.get(context).isAllowed
                  ? CustomCard(
                      widget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 11.sp),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 18.h,
                            ),
                            CustomCardTitle(
                              text: 'UPLOADED LOADS',
                            ),
                            LoadsCubit.get(context).myloadList.isEmpty
                                ? Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomNoContainer(text: 'loads'),
                                      ],
                                    ),
                                  )
                                : const MyTable(),
                            Button()
                          ],
                        ),
                      ),
                    )
                  : LoadsCubit.get(context).unAuthProblem
                      ? const CustomNotLoggedIn()
                      : UpgradeMember('Loads');
        });
  }
}
