import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../../widgets/widgets/custom_text.dart';
import '../modelSwiper.dart';

class swiper1 extends StatelessWidget {
  const swiper1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        height: 300.h,
        child: Swiper(
          autoplay: true,
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
          ),
          itemCount: swiperList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 200.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                              width: 15.w,
                              height: 15.h,
                              image:
                                  const AssetImage('assets/images/star.png')),
                          Image(
                              width: 15.w,
                              height: 15.h,
                              image:
                                  const AssetImage('assets/images/star.png')),
                          Image(
                              width: 15.w,
                              height: 15.h,
                              image:
                                  const AssetImage('assets/images/star.png')),
                          Image(
                              width: 15.w,
                              height: 15.h,
                              image:
                                  const AssetImage('assets/images/star.png')),
                          Image(
                              width: 15.w,
                              height: 15.h,
                              image:
                                  const AssetImage('assets/images/star.png')),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: swiperList[index].text,
                        align: TextAlign.center,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      CircleAvatar(
                        radius: 40.r,
                        backgroundImage: AssetImage(swiperList[index].img),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: swiperList[index].nameImage,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: swiperList[index].jop,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFA4A4A4),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
