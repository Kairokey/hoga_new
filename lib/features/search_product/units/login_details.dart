import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/auth/login.dart';
import 'package:hoga_load/widgets/widgets/custom_button.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';

import '../../plans/view.dart';

class LoginDetails extends StatelessWidget {
  const LoginDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomButton(
          width: 0.5.sw,
          text: 'Login To HegaLoad',
          function: () {
            MagicRouter.navigateTo(Login());
          },
          font: 14.sp,
          colortext: Colors.white,
          color: Colors.orange,
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomText(
          text: '** You need to log into your account to view contact details, '
              'in case you are still not a member then click here to create a new account.',
          fontSize: 10.sp,
          align: TextAlign.start,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }
}
