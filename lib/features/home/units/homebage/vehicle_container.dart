import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';

import '../../../../core/color_manager/color_manager.dart';

class VehicleContainer extends StatelessWidget {
  VehicleContainer(
      this.image, this.pageRoute, this.text, this.hint, this.more, this.color,
      {this.isColor = false, this.function});
  var image;
  String text;
  String hint;
  String more;
  Color color;
  bool isColor;
  var pageRoute;
  var function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 15.w, right: 15.w, bottom: 22.h, top: 22.h),
      child: Container(
        height: 278.h,
        width: 1.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 0,
                color: color.withOpacity(1),
              ),
            ],
            color: Colors.white
            //  color: Colors.transparent,

            ),
        child: Container(
          height: 268.h,
          width: 1.sw,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () async {
                  await function;
                  MagicRouter.navigateTo(pageRoute);
                },
                //splashColor: color.withOpacity(0.5),
                highlightColor: color.withOpacity(0.4),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: isColor
                                ? const Color(0xFFff8c09).withOpacity(0.3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image(
                            height: 80, width: 80, image: AssetImage(image)),
                      ),
                      Expanded(
                        child: CustomText(
                          text: text,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          text: hint,
                          fontSize: 16.sp,
                          align: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: more,
                              color: color,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            Icon(
                              Icons.arrow_right_alt,
                              color: color,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
