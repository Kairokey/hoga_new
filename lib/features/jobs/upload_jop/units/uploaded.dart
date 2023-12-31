part of'../view.dart';

class Uploaded extends StatefulWidget {
  const Uploaded({Key? key}) : super(key: key);

  @override
  State<Uploaded> createState() => _UploadedState();
}

class _UploadedState extends State<Uploaded> {
  void initState() {
    // TODO: implement initState
    super.initState();
    JopCubit.get(context).addJobCubitTest();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JopCubit, AddJopStates>(
        listener: (BuildContext context, Object? state) {
          if (state is DeleteSuccess || state is EditSuccess) {
          JopCubit.get(context).getJops(self: 1, isFilter: false, context: context);
    }
    }, builder: (context, state) {
      return JopCubit.get(context).testLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,            ))
          : JopCubit.get(context).isAllowed
              ? CustomCard(
                  widget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11.sp),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 18.h,
                        ),
                        CustomCardTitle(
                          text: 'UPLOADED JOB',
                        ),
                        JopCubit.get(context).myJopList.isEmpty
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomNoContainer(text: 'Job'),
                                  ],
                                ),
                              )
                            : const MyJopTable(),
                        Button1()
                      ],
                    ),
                  ),
                )
              :JopCubit.get(context).unAuthProblem? const CustomNotLoggedIn(): Upgrade();
    });
  }
}
