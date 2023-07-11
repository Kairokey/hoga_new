part of '../view.dart';

class PackageBody extends StatelessWidget {
  const PackageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageCubit, PackageStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is PackageSubscribeSuccess) {
          Navigator.of(context, rootNavigator: true).pop(context);
        }
      },
      builder: (context, state) {
        return CustomCard(
          widget: Column(
            children: [
              SizedBox(
                height: 18.h,
              ),
              CustomCardTitle(
                text: 'PURCHASE ADVERTISEMENT PACKAGE',
              ),
              SizedBox(
                height: 8.h,
              ),
              BlocConsumer<PackageCubit, PackageStates>(
                builder: (context, state) {
                  if (PackageCubit.get(context).packageLoading) {
                    return SizedBox(
                        height: .5.sh,
                        width: 1.sw,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        )));
                  } else {
                    return SizedBox(
                      height: .57.sh,
                      width: 1.sw,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              PackageCubit.get(context).packageList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CustomPackage(
                                  index: index,
                                  text1: PackageCubit.get(context)
                                      .packageList[index]
                                      .title,
                                  price:
                                      '${PackageCubit.get(context).packageList[index].pricePerDay} / Day',
                                  text2: PackageCubit.get(context)
                                      .packageList[index]
                                      .description,
                                  conttext1: PackageCubit.get(context)
                                              .packageList[index]
                                              .title ==
                                          "Per Day Package"
                                      ? '2022-08-07'
                                      : null,
                                  conttext2: PackageCubit.get(context)
                                              .packageList[index]
                                              .title ==
                                          "Per Day Package"
                                      ? 'Total Payable'
                                      : null,
                                  totalprice:
                                      '${PackageCubit.get(context).packageList[index].duration! * int.parse(PackageCubit.get(context).packageList[index].pricePerDay!)}',
                                ),
                                index ==
                                        PackageCubit.get(context)
                                                .packageList
                                                .length -
                                            1
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 41.w, right: 13.w),
                                              child: state
                                                      is PackageSubscribeLoading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                      color: ColorManager
                                                          .primaryColor,
                                                    ))
                                                  : CustomButton(
                                                      function: () async {
                                                        print(
                                                            '++++++++++++++++++++++++++++++++++++++');
                                                        if (PackageCubit.get(
                                                                    context)
                                                                .selectedPackage ==
                                                            0) {
                                                          if (PackageCubit.get(
                                                                          context)
                                                                      .fromdate ==
                                                                  null ||
                                                              PackageCubit.get(
                                                                          context)
                                                                      .todate ==
                                                                  null) {
                                                            showToast(
                                                                msg:
                                                                    'Add Valid Date',
                                                                state:
                                                                    ToastedStates
                                                                        .ERROR);
                                                          } else {
                                                            print(
                                                                'first date is ${PackageCubit.get(context).fromdate}');
                                                            print(
                                                                'end date is ${PackageCubit.get(context).fromdate}');

                                                            await PackageCubit.get(context).subscribePackage(
                                                                PackageCubit.get(
                                                                        context)
                                                                    .packageList[
                                                                        PackageCubit.get(context)
                                                                            .selectedPackage]
                                                                    .id,
                                                                context,
                                                                endDate:
                                                                    PackageCubit.get(
                                                                            context)
                                                                        .todate,
                                                                firstDate: PackageCubit
                                                                        .get(
                                                                            context)
                                                                    .fromdate);
                                                          }
                                                        } else {
                                                          await PackageCubit
                                                                  .get(context)
                                                              .subscribePackage(
                                                            PackageCubit.get(
                                                                    context)
                                                                .packageList[
                                                                    PackageCubit.get(
                                                                            context)
                                                                        .selectedPackage]
                                                                .id,
                                                            context,
                                                          );
                                                        }
                                                      },
                                                      text: 'BUY NOW',
                                                      colortext: const Color(
                                                          0xFFFDC52F),
                                                      colorborder: const Color(
                                                          0xFFFDC52F),
                                                      color: Colors.white,
                                                    )),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                        ],
                                      )
                                    : Container()
                              ],
                            );
                          }),
                    );
                  }
                },
                listener: (BuildContext context, state) {},
              ),
            ],
          ),
        );
      },
    );
  }
}
