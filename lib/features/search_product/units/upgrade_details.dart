import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/widgets/widgets/custom_button.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';

import '../../plans/view.dart';

class UpgradeDetails extends StatelessWidget {
  const UpgradeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomButton(
          width: 0.5.sw,
          text: 'Upgrade MemberShip',
          function: () {
            MagicRouter.navigateTo(PlanView());
          },
          font: 14.sp,
          colortext: Colors.white,
          color: Colors.orange,
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomText(
          text:
              '** You need to upgrade your membership to get the contact details '
              'of the advertiser.',
          fontSize: 10.sp,
          align: TextAlign.start,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }
}
