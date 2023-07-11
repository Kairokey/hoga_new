import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/color_manager/color_manager.dart';
import '../../../core/router/router.dart';
import '../../../widgets/widgets/custom_text.dart';
import 'add_product_form.dart';
class UploadedTableAdvertisment extends StatelessWidget {
  UploadedTableAdvertisment({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return  Expanded(
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
                  flex: 1,
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
                  child: Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomText(
                        text: '[ Add + ]',
                        fontSize: 18.sp,
                        color: ColorManager.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )],
            ),

            child

          ],
        ),

      ),
    );
  }
}