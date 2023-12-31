import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hoga_load/core/app_images/app_images.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/core/widgets/custom_card.dart';
import 'package:hoga_load/features/blogs/blog_details.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';

import '../../core/data/models/blogs/blogs.dart';
import '../../core/router/router.dart';

class CustomContainerBlog extends StatelessWidget {
  final Blogs blogs;
  Widget? widgetDetails;
  CustomContainerBlog(this.blogs, {Key? key, this.widgetDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      paddingInEnd: 0,
      paddingInStart: 0,
      bottomPadding: 0,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? 166.h
                : 266,
            width: 1.sw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: const Image(
              image: AssetImage(AppImages.blog),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 13.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: blogs.title,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          OrientationBuilder(builder: (context, orientation) {
            return Padding(
              padding: EdgeInsets.only(top: 8.h, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: orientation == Orientation.portrait ? 0 : 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                          size: 20.h,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: 'Admin',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: orientation == Orientation.portrait ? 2 : 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                          size: 20.h,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          align: TextAlign.start,
                          text: blogs.createdAt!
                              .substring(0, blogs.createdAt!.indexOf('T')),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: orientation == Orientation.portrait ? 2 : 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Chat_Circle_Dots.svg',
                          height: 20.h,
                          width: 20.w,
                          fit: BoxFit.cover,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: CustomText(
                                    align: TextAlign.start,
                                    text: '${blogs.enableComment} Comment(s)',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.topLeft,
                                child: CustomText(
                                  align: TextAlign.start,
                                  text: '${blogs.enableComment} Comment(s)',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: 7.h,
          ),
          widgetDetails ??
              Padding(
                padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                child: InkWell(
                  onTap: () {
                    MagicRouter.navigateTo(BlogDetails(blogs: blogs));
                  },
                  child: Container(
                    height: 48.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: ColorManager.primaryColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: CustomText(
                        text: 'Read More',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.whiteColor,
                      ),
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }
}
