import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/custom_card.dart';
import '../../core/widgets/custom_card_title.dart';
import '../../core/widgets/custom_no_container.dart';
import '../../features/upload_product/units/button.dart';

class UpgradeMember extends StatelessWidget {
  bool isUpgradeMember = true;
  bool isSubscriptionPage;
  UpgradeMember(this.text, {super.key, this.isSubscriptionPage = false});

  String text;
  @override
  Widget build(BuildContext context) {
    print(isSubscriptionPage);
    print("isSubscriptionPage");

    return CustomCard(
      widget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.sp),
        child: Column(
          children: [
            SizedBox(
              height: 18.h,
            ),
            CustomCardTitle(
              text: isSubscriptionPage ? 'Subscription' : 'UPLOADED $text',
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomNoContainer(
                      isSubscriptionPage: isSubscriptionPage,
                      text: text,
                      isUpgradeMember: isUpgradeMember),
                ],
              ),
            ),
            Button(isUpgradeMember: isUpgradeMember),
          ],
        ),
      ),
    );
  }
}
