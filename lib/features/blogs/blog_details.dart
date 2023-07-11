import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/features/auth/units/customer_button.dart';
import 'package:hoga_load/features/auth/units/customer_text_field.dart';
import 'package:hoga_load/features/blogs/bloc/blog_cubit.dart';
import 'package:hoga_load/widgets/widgets/custom_container_blog.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
import '../../../../widgets/widgets/custom_button.dart' as custom;

import '../../core/data/local/cacheHelper.dart';
import '../../core/data/models/blogs/blogs.dart';
import '../../core/keys/keys.dart';
import '../../core/router/router.dart';
import '../../core/widgets/custom_card.dart';
import '../../core/widgets/custom_card_title.dart';
import '../auth/login.dart';

class BlogDetails extends StatelessWidget {
  TextEditingController comment = TextEditingController();
  TextEditingController website = TextEditingController();

  final Blogs? blogs;
  BlogDetails({super.key, this.blogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomContainerBlog(blogs!,
            widgetDetails: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SingleChildScrollView(
                      child: CustomText(
                    text: blogs!.blogContent!,
                    color: ColorManager.darkGrey,
                  )),
                  const Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 10),
                    child: Divider(
                      color: ColorManager.greyColor,
                      thickness: 2,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.folder_open,
                              color: ColorManager.primaryColor,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            CustomText(
                              text: blogs!.blogCategory!,
                              fontWeight: FontWeight.normal,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bookmark_border,
                              color: ColorManager.primaryColor,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            CustomText(
                              text: blogs!.keywords!,
                              fontWeight: FontWeight.normal,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: CustomText(
                        text: 'Leave a Reply',
                        color: ColorManager.darkGrey,
                        fontSize: 18.sp,
                        align: TextAlign.start,
                      ),
                    ),
                  ),
                  !CacheHelper.getBool(SharedKeys.isLogin)
                      ? CustomCard(
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.sp),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                CustomCardTitle(
                                  text: 'Not Logged IN',
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 135.h,
                                      width: 1.sw,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              253, 197, 47, 0.3),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: CustomText(
                                            align: TextAlign.center,
                                            text: "you  must log in first",
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
                                  padding:
                                      EdgeInsets.only(bottom: 27.h, top: 27.h),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: custom.CustomButton(
                                      text: 'Login',
                                      icon: Icons.add,
                                      color: ColorManager.yellow,
                                      function: () {
                                        MagicRouter.navigateTo(Login());
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            CustomTextFormField(
                              hintText: 'Your WebSite (optional)',
                              controller: website,
                            ),
                            CustomTextFormField(
                              hintText: 'Yout Comment (required)',
                              controller: comment,
                            ),
                            CustomButton(
                                text: 'Send',
                                function: () async {
                                  await BlogsCubit.get(context).addComment(
                                      comment.text, blogs!.id,
                                      website: website.text);
                                  Navigator.pop(context);
                                })
                          ],
                        )
                ],
              ),
            )),
      ),
    );
  }
}
