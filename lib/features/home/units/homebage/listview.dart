import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';

import '../modelList.dart';

class WaveShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 20;
    final highPoint = size.height - 40;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class TeamList extends StatelessWidget {
  const TeamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Container(
          // height: 1800.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          ClipPath(
                            clipper: WaveShape(),
                            child: SizedBox(
                              width: 1.sw,
                              height: 315.h,
                              child: Image(image: AssetImage(list[index].img)),
                            ),
                          ),
                          CustomText(
                            align: TextAlign.center,
                            text: list[index].name,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          CustomText(
                            align: TextAlign.center,
                            text: list[index].jop,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFAEAEAE),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          CustomText(
                            align: TextAlign.center,
                            text: list[index].desc,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF858585),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                        ],
                      ))
              : Container(
                  // height: 800,
                  child: GridView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.9),
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipPath(
                                    clipper: WaveShape(),
                                    child: SizedBox(
                                      width: 1.sw,
                                      height: 315.h,
                                      child: Image(
                                          image: AssetImage(list[index].img)),
                                    ),
                                  ),
                                ),
                                CustomText(
                                  align: TextAlign.center,
                                  text: list[index].name,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                CustomText(
                                  align: TextAlign.center,
                                  text: list[index].jop,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFAEAEAE),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                CustomText(
                                  align: TextAlign.center,
                                  text: list[index].desc,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF858585),
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                              ],
                            ),
                          )),
                )),
    );
  }
}
