import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/dialoges/toast.dart';
import 'package:hoga_load/features/packages/cubit/package_cubit.dart';
import 'package:hoga_load/features/packages/cubit/package_states.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
import 'package:hoga_load/widgets/widgets/custom_text_field.dart';
import '../../../core/color_manager/color_manager.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../widgets/widgets/custom_button.dart';
import '../../dashboard/cubit/updateProfile_cubit.dart';
import '../../home/view.dart';
import '../../packages/view.dart';

class FormAdvertisment extends StatefulWidget {
  const FormAdvertisment({
    Key? key,
  }) : super(key: key);

  @override
  State<FormAdvertisment> createState() => _FormAdvertismentState();
}

class _FormAdvertismentState extends State<FormAdvertisment> {
  GlobalKey<ScaffoldState> uploadedProductsScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PackageCubit.get(context).SubscribePackageTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: OnDrawer(),
        key: uploadedProductsScaffoldKey,
        body: BlocConsumer<PackageCubit, PackageStates>(
            listener: (context, state) {
          if (state is UploadPackageSuccess) {
            PackageCubit.get(context).advertisementCubit();
            PackageCubit.get(context).imageDesktop == null;
            PackageCubit.get(context).imageMobile == null;
          }
        }, builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppbar(
                title: 'UPLOAD ADVERTISEMENT BANNER',
                font: 18.sp,
                scaffoldKey: uploadedProductsScaffoldKey,
              ),
              PackageCubit.get(context).testLoading
                  ? const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                      color: Colors.orange,
                    )))
                  : PackageCubit.get(context).isAllowed
                      ? Expanded(
                          child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: CustomCard(
                                    widget: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 14.w),
                                            child: Column(
                                              //   mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          'Banner for Desktop Devices',
                                                      align: TextAlign.start,
                                                      color: Colors.grey,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 50.h,
                                                  width: 1.sw,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .greyColor),
                                                      color: ColorManager
                                                          .whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r)),
                                                  child: InkWell(
                                                    onTap: () {
                                                      PackageCubit.get(context)
                                                          .pickFromGalleryDesktop(
                                                              context);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 64.h,
                                                          width: 106.w,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.r)),
                                                          child: Center(
                                                            child: Text(
                                                              'Choose File',
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xFF757575),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.sp),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              PackageCubit.get(
                                                                              context)
                                                                          .imageDesktop ==
                                                                      null
                                                                  ? '    No File chosen'
                                                                  : '${PackageCubit.get(context).imageDesktop.toString().split('/data/user/0/com.example.hoga_load/cache/image_picker')}',
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xFF757575),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.sp),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                CustomText(
                                                  text:
                                                      'Should have a size of 925px width and 200px height',
                                                  align: TextAlign.start,
                                                  color: Colors.grey,
                                                  fontSize: 10.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 14.w),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          'Banner for Mobile Devices',
                                                      align: TextAlign.start,
                                                      color: Colors.grey,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 50.h,
                                                  width: 1.sw,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .greyColor),
                                                      color: ColorManager
                                                          .whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r)),
                                                  child: InkWell(
                                                    onTap: () {
                                                      PackageCubit.get(context)
                                                          .pickFromGalleryMobile(
                                                              context);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 64.h,
                                                          width: 106.w,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.r)),
                                                          child: Center(
                                                            child: Text(
                                                              'Choose File',
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xFF757575),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.sp),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              PackageCubit.get(
                                                                              context)
                                                                          .imageMobile ==
                                                                      null
                                                                  ? '    No File chosen'
                                                                  : '${PackageCubit.get(context).imageDesktop.toString().split('/data/user/0/com.example.hoga_load/cache/image_picker')}',
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xFF757575),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.sp),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                CustomText(
                                                  text:
                                                      'Should have a size of 925px width and 200px height',
                                                  align: TextAlign.start,
                                                  color: Colors.grey,
                                                  fontSize: 10.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 5.h,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 14.w),
                                                  child: Row(
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Link to Redirect Users',
                                                        align: TextAlign.start,
                                                        color: Colors.grey,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                CustomTextField(
                                                  height: 50.h,
                                                  hintText:
                                                      'Please enter link with http:// or https://',
                                                  keyboardType:
                                                      TextInputType.url,
                                                  controller:
                                                      PackageCubit.get(context)
                                                          .linkController,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.h, left: 14.w),
                                            child: Container(
                                                height: 100.h,
                                                width: 1.sw,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomText(
                                                    align: TextAlign.start,
                                                    color: Colors.grey[800],
                                                    fontSize: 10.sp,
                                                    text:
                                                        'NOTE : Please note your advertisement will be published by admin only. If there is any communication required, our team will contact with you at ${UpdateProfileCubit.get(context).profileData.email ?? ''} and ${UpdateProfileCubit.get(context).profileData.contactNumber ?? ''}',
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                            child: const Divider(
                                              thickness: 1,
                                            ),
                                          ),
                                          state is UploadPackageLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.orange,
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15.h, top: 10.h),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: CustomButton(
                                                      height: 75.sp,
                                                      text:
                                                          'UPLOAD\n ADVERTISEMENT',
                                                      icon: Icons.add,
                                                      color:
                                                          ColorManager.yellow,
                                                      function: () {
                                                        if (PackageCubit.get(
                                                                        context)
                                                                    .imageDesktop ==
                                                                null ||
                                                            PackageCubit.get(
                                                                        context)
                                                                    .imageMobile ==
                                                                null) {
                                                          showToast(
                                                              msg:
                                                                  'You must add a banner',
                                                              state:
                                                                  ToastedStates
                                                                      .ERROR);
                                                        }

                                                        PackageCubit.get(
                                                                context)
                                                            .uploadPackageCubit(
                                                                context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              )))
                      : const Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: PackageBody())),
            ],
          );
        }));
  }
}
/*

 */
