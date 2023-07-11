import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_card_title.dart';
import '../../../widgets/widgets/custom_text.dart';
import '../../dashboard/cubit/UpdateProfile_state.dart';
import '../../dashboard/cubit/updateProfile_cubit.dart';
class Facilities extends StatelessWidget {
  const Facilities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileStates>(
      listener: (context,state){},
      builder:(context,state)=> Column(
        children: [
          CustomCardTitle(text: 'FACILITIES',),
          SizedBox(height: 30.h,),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: name2.length,
              itemBuilder: (context, index) {
                List detail2 = [
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null?'Not Found': UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalLoadsAllowed.toString()),
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null?'Not Found': UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalVehiclesAllowed.toString()),
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null? 'Not Found':UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalProductsAllowed.toString()),
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null?'Not Found': UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalJobsAllowed.toString()),
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null?'Not Found':UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalLoadsRemain.toString()),
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null?'Not Found':UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalVehiclesRemain.toString()),
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null?'Not Found':UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalProductsRemain.toString()),
                  (UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails==null?'Not Found':UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.totalJobsRemain.toString())
                ];
                return Padding(
                  padding:
                  EdgeInsets.only(bottom: 17.h, left: 9.w, right: 9.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomText(
                            text: name2[index],
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF777777),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CustomText(
                            text: detail2[index],
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF777777),
                          )

                        ],
                      ),
                    ],
                  ),
                );
              }),      ],
      ),
    );
  }
}
List name2 = [
  'Loads to Upload',
  'Vehicles to Upload',
  'Products to Upload',
  'Jobs to Upload',
  'Loads Remains',
  'Vehicles Remains',
  'Products Remains',
  'Jobs Remains'
];
