part of '../view.dart';

class PlanBody extends StatefulWidget {
  @override
  State<PlanBody> createState() => _PlanBodyState();
}

class _PlanBodyState extends State<PlanBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PlansCubit.get(context).checkPlansCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlansCubit, PlansStates>(
        listener: (BuildContext context, state) {
      if (state is NotFreeTrial) {
        print('notFree');
      }
    }, builder: (BuildContext context, state) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: CustomText(
            text: 'SUBSCRIPTION PLANS',
            align: TextAlign.center,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFDC52F),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: CustomText(
            text: 'CHECK OUR PRICING POLICY',
            align: TextAlign.center,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF000000),
          ),
        ),
        BlocConsumer<PlansCubit, PlansStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MediaQuery.of(context).orientation == Orientation.portrait
                  ? ListView.builder(
                      itemCount: PlansCubit.get(context).plansList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 500.sp,
                          child: BuyContainer(
                              text: PlansCubit.get(context)
                                  .plansList[index]
                                  .title,
                              loadsNo: PlansCubit.get(context)
                                  .plansList[index]
                                  .totalNumberOfLoads,
                              vehiclesNo: PlansCubit.get(context)
                                  .plansList[index]
                                  .totalNumberOfVehicles,
                              jobsNo: PlansCubit.get(context)
                                  .plansList[index]
                                  .totalNumberOfJobs,
                              productNo: PlansCubit.get(context)
                                  .plansList[index]
                                  .totalNumberOfProducts,
                              price: PlansCubit.get(context)
                                  .plansList[index]
                                  .price,
                              basePrice: PlansCubit.get(context)
                                  .plansList[index]
                                  .basePrice,
                              id: PlansCubit.get(context).plansList[index].id,
                              image:
                                  'https://hegaload.com/uploads/subscription-images/${PlansCubit.get(context).plansList[index].image}'),
                        );
                      })
                  : GridView.builder(
                      itemCount: PlansCubit.get(context).plansList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.8),
                      itemBuilder: (context, index) => BuyContainer(
                          text: PlansCubit.get(context).plansList[index].title,
                          loadsNo: PlansCubit.get(context)
                              .plansList[index]
                              .totalNumberOfLoads,
                          vehiclesNo: PlansCubit.get(context)
                              .plansList[index]
                              .totalNumberOfVehicles,
                          jobsNo: PlansCubit.get(context)
                              .plansList[index]
                              .totalNumberOfJobs,
                          productNo: PlansCubit.get(context)
                              .plansList[index]
                              .totalNumberOfProducts,
                          price: PlansCubit.get(context).plansList[index].price,
                          basePrice: PlansCubit.get(context)
                              .plansList[index]
                              .basePrice,
                          id: PlansCubit.get(context).plansList[index].id,
                          image:
                              'https://hegaload.com/uploads/subscription-images/${PlansCubit.get(context).plansList[index].image}'));
            }),
      ]);
    });
  }
}
