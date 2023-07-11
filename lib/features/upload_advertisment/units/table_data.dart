import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/features/packages/cubit/package_cubit.dart';
import 'package:hoga_load/features/packages/cubit/package_states.dart';
import 'package:hoga_load/features/search_product/cubit/getProduct_cubit.dart';
import 'package:hoga_load/features/upload_advertisment/units/table_product_title.dart';
import 'package:hoga_load/features/upload_product/add_view.dart';
import 'package:hoga_load/features/upload_product/units/table_product_title.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/color_manager/color_manager.dart';
import '../../../core/dialoges/delete_dialoge.dart';
import '../../../core/router/router.dart';
import '../../../core/widgets/custom_no_container.dart';
import '../../../widgets/widgets/custom_text.dart';
import '../../packages/view.dart';
import '../../search_product/cubit/getProduct__states.dart';
import 'add_product_form.dart';

class MyAdvertismentTable extends StatefulWidget {
   MyAdvertismentTable({super.key});

  @override
  State<MyAdvertismentTable> createState() => _MyAdvertismentTableState();
}

class _MyAdvertismentTableState extends State<MyAdvertismentTable> {
  @override
  void initState() {
    PackageCubit.get(context).fromdate='';
    PackageCubit.get(context).todate='';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 0.7.sh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: Center(
                    child: CustomText(
                      text: 'UPLOADED ADVERTISEMENTS',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    MagicRouter.navigateTo(const FormAdvertisment() );
                  },
                  child: Center(
                    child: CustomText(
                      text: '[ Add + ]',
                      fontSize: 18.sp,
                      color: ColorManager.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )],
            ),

            BlocConsumer<PackageCubit, PackageStates>(
                listener: (BuildContext context, Object? state) {},
                builder: (context, state) {
                  var package = PackageCubit.get(context).getPackageList;
                  if (state is GetPackageLoading) {
                    return Expanded(child: PackageShimmer());
                  } else {
                    return package.isEmpty? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomNoContainer(text: 'advertisements'),
                      ),
                    ):
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Container(
                                height: 43.h,
                                width: 1.sw,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex:1,
                                      child: CustomText(
                                        text: "#",
                                        fontSize: 11.sp,
                                        align: TextAlign.start,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Expanded(
                                      flex:2,
                                      child: CustomText(
                                        text: "Start Date",
                                        fontSize: 11.sp,
                                        align: TextAlign.start,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Expanded(
                                      flex:2,
                                      child: CustomText(
                                        text: "End Date",
                                        fontSize: 11.sp,
                                        align: TextAlign.start,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),


                                  ],
                                )

                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                            child:const Divider(thickness: 1,),
                          ),

                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: PackageCubit.get(context).getPackageList.length,
                                itemBuilder: (context, index) {
                                  {
                                 return Container(
                                      color:  Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 5),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomText(
                                                    text: '${index + 1}',
                                                    align: TextAlign.start,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomText(
                                                    text: package[index].startDate == null
                                                        ? 'other'
                                                        : package[index]
                                                            .startDate
                                                            .toString(),
                                                    align: TextAlign.start,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomText(
                                                    text: package[index].endDate == null
                                                        ? 'other'
                                                        : package[index].endDate.toString(),
                                                    align: TextAlign.start,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                            child: const Divider(
                                              thickness: 1,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    )
                        ;

                  }
                }),
          ],
        ),
      ),
    );
  }

  ListView PackageShimmer() {
    return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      color: index.isEven ? Colors.grey[300] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Shimmer.fromColors(
                                  enabled: true,
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: Container(
                                      width: 0.2.sw,
                                      height: 12.sp,
                                      color: Colors.grey[300]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Shimmer.fromColors(
                                    enabled: true,
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Container(
                                        width: 0.2.sw,
                                        height: 12.sp,
                                        color: Colors.grey[300])),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Shimmer.fromColors(
                                    enabled: true,
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Container(
                                        width: 0.2.sw,
                                        height: 12.sp,
                                        color: Colors.grey[300])),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
  }
}
