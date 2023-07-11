import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/data/models/blogs/blogs.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/home/units/homebage/blog.dart';
import 'package:hoga_load/features/subscribtion_details/view.dart';

import '../../../core/widgets/custom_card_title.dart';
import '../../../widgets/widgets/custom_button.dart';
import '../../../widgets/widgets/custom_text.dart';
import '../../dashboard/cubit/UpdateProfile_state.dart';
import '../../dashboard/cubit/updateProfile_cubit.dart';
import '../../plans/view.dart';

class Plans extends StatelessWidget {
  var state;
  Plans(this.state);
  @override
  Widget build(BuildContext context) {
    print('cancelled -------');

    print(UpdateProfileCubit.get(context)
        .subscriptionData);
    print(UpdateProfileCubit.get(context)
        .subscriptionData
        .subscriptionDetails
    );
//    print(UpdateProfileCubit.get(context)
//        .subscriptionData
//        .subscriptionDetails
//        .subscriptionCancelled);
    return
      Column(
        children: [
          SizedBox(
            height: 18.h,
          ),
          CustomCardTitle(
            text:
            '${UpdateProfileCubit.get(context).subscriptionData.userDetails == null ? 'Not Found' : UpdateProfileCubit.get(context).subscriptionData.userDetails!.firstName}'
                ' ${UpdateProfileCubit.get(context).subscriptionData.userDetails == null ? 'Not Found' : UpdateProfileCubit.get(context).subscriptionData.userDetails!.lastName} - '
                '${UpdateProfileCubit.get(context).subscriptionData.packageDetails == null ? 'Not Found' : UpdateProfileCubit.get(context).subscriptionData.packageDetails!.name}',
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                    text: 'Started',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF777777),
                  ),
                  CustomText(
                    text: UpdateProfileCubit.get(context)
                        .subscriptionData
                        .subscriptionDetails ==
                        null
                        ? 'Not Found'
                        : UpdateProfileCubit.get(context)
                        .subscriptionData
                        .subscriptionDetails!
                        .subscriptionTakenOn,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF777777),
                  ),
                ],
              ),
              SizedBox(
                  height: 50.h,
                  child: const Divider(
                    thickness: 1,
                    color: Colors.black,
                  )),
              Column(
                children: [
                  CustomText(
                    text: 'Next Invoice',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF777777),
                  ),
                  CustomText(
                    text: UpdateProfileCubit.get(context)
                        .subscriptionData
                        .subscriptionDetails ==
                        null
                        ? 'Not Found'
                        : UpdateProfileCubit.get(context)
                        .subscriptionData
                        .subscriptionDetails!
                        .subscriptionValidTill,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF777777),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          state is CancelSuccess
              ||
              UpdateProfileCubit.get(context)
                  .subscriptionData
                  .subscriptionDetails!
                  .subscriptionCancelled ==
                  1
              ? Container(
            width: 1.sw,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(253, 197, 47, 0.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 13.h,
                ),
                Container(
                  child: Center(
                    child: CustomText(
                      align: TextAlign.center,
                      text:
                      'You have cancelled your membership. Please subscribe to explore more',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF664D03),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 16.w),
                  child: CustomButton(
                      function: () {
                        MagicRouter.navigateTo(PlanView());
                      },
                      text: 'SUBSCRIPTION PLANS"',
                      color: const Color(0xFFFDC52F)),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          )
              : Container(
            width: 1.sw,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(253, 197, 47, 0.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 13.h,
                ),
                Container(
                  child: Center(
                    child: CustomText(
                      align: TextAlign.center,
                      text: UpdateProfileCubit.get(context)
                          .subscriptionData
                          .packageDetails ==
                          null
                          ? ''
                          : 'Upgrage to ${UpdateProfileCubit.get(context).subscriptionData.packageDetails!.name!.toLowerCase().contains('free') ? 'Bronze' : UpdateProfileCubit.get(context).subscriptionData.packageDetails!.name!.toLowerCase().contains('bronze') ? 'Silver' : 'Gold'}"Plan" and\n enjoy more facilities.',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF664D03),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                InkWell(
                  onTap: () {
                    MagicRouter.navigateTo(PlanView());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 16.w),
                    child: CustomButton(
                        text: UpdateProfileCubit.get(context)
                            .subscriptionData
                            .packageDetails ==
                            null
                            ? ''
                            : 'Upgrade to ${UpdateProfileCubit.get(context).subscriptionData.packageDetails!.name!.toLowerCase().contains('free') ? 'Bronze' : UpdateProfileCubit.get(context).subscriptionData.packageDetails!.name!.toLowerCase().contains('bronze') ? 'Silver' : 'Gold'}" Plan"',
                        color: const Color(0xFFFDC52F)),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ],
      );
  }
}
