import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/auth/login.dart';
import 'package:hoga_load/widgets/widgets/custom_button.dart';
import '../../core/color_manager/color_manager.dart';
import '../../core/widgets/custom_card.dart';
import '../../core/widgets/custom_card_title.dart';
import 'custom_text.dart';

class CustomFailedWidget extends StatelessWidget {
  String? errorText;
  bool loginProblem = false;

  CustomFailedWidget({super.key, this.errorText, this.loginProblem = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: CustomCard(
          widget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 18.h,
                ),
                CustomCardTitle(
                  text: 'Warning!!',
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 135.h,
                      width: 1.sw,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(253, 197, 47, 0.3),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomText(
                            align: TextAlign.center,
                            text: errorText,
                            fontSize: 16.sp,
                            textHeight: 1.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF664D03),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 27.h, top: 27.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      text: loginProblem ? 'Login' : 'Back',
                      color: ColorManager.yellow,
                      function: () {
                        loginProblem
                            ? MagicRouter.navigateTo(Login())
                            : Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
