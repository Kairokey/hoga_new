import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/core/data/models/jobs/get_jop.dart';
import 'package:hoga_load/core/widgets/custom_card.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/data/local/cacheHelper.dart';
import '../../core/keys/keys.dart';
import '../../features/search_product/units/login_details.dart';
import '../../features/search_product/units/upgrade_details.dart';

class CustomContainerJop extends StatelessWidget {
  final GetJop jop;
  const CustomContainerJop(this.jop, {Key? key}) : super(key: key);
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchURl(email) async {
    final Uri params = Uri(scheme: 'mailto', path: email);
    Uri url = params;
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      print(url);
    } else {
      print('could mot launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomCard(
        paddingInEnd: 0,
        paddingInStart: 0,
        bottomPadding: 0,
        widget: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w, top: 25.h, bottom: 25.h),
                child: Row(
                  children: [
                    CustomText(
                      text: jop.title == null ? 'other' : jop.title.toString(),
                      fontSize: 18.sp,
                      align: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: ColorManager.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomText(
                              text: jop.user == null
                                  ? 'other'
                                  : jop.user!.username.toString(),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            color: ColorManager.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: CustomText(
                              align: TextAlign.start,
                              text: jop.shiftTime,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/Chat_Circle_Dots.svg',
                            height: 20.h,
                            width: 20.w,
                            fit: BoxFit.cover,
                            color: ColorManager.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: CustomText(
                              text:
                                  '${jop.category?.title} → ${jop.jobType!.title}' ??
                                      'other',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (jop.description != null)
                Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: CustomText(
                      text: jop.description,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      align: TextAlign.start,
                      fontSize: 16.sp,
                    )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 7.h,
                  width: 1.sw,
                  child: const Divider(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.h, top: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(text: 'CONTACT DETAILS'),
                        ],
                      ),
                    ),
                    !CacheHelper.getBool(SharedKeys.isLogin)
                        ? const LoginDetails()
                        : jop.user == null
                            ? const UpgradeDetails()
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.email_outlined,
                                            color: ColorManager.primaryColor,
                                            size: 20.h,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                _launchURl(jop.user!.email!);
                                              },
                                              child: CustomText(
                                                text: jop.user == null
                                                    ? 'other'
                                                    : jop.user!.email,
                                                align: TextAlign.left,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_callback,
                                          color: ColorManager.primaryColor,
                                          size: 20.h,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _makePhoneCall(
                                                    jop.user!.contactNumber!)
                                                .toString();
                                          },
                                          child: CustomText(
                                            text: jop.user == null
                                                ? 'other'
                                                : jop.user!.contactNumber!
                                                    .toString(),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
