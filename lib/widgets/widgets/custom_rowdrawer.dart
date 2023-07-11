import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';

import '../../core/router/router.dart';
import '../../features/auth/login.dart';
import '../../features/home/view.dart';
import 'custom_button.dart';

class CustomRowDrawer extends StatelessWidget {
  CustomRowDrawer(
      {Key? key,
      required this.text,
      this.beforeNavigate,
      this.ontap,
      this.icon,
      this.isHome = false,
      this.inHome = false,
      this.navigatename})
      : super(key: key);
  String text;
  Function? beforeNavigate;
  bool isHome = false;
  bool inHome = false;

  var icon;
  var navigatename;
  var ontap;
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Do You want to log out?'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 35.sp,
                    ),
                    Expanded(
                        child: CustomButton(
                            function: () => Navigator.pop(context, false),
                            text: 'No',
                            height: 40.sp,
                            font: 15)),
                    SizedBox(
                      width: 35.sp,
                    ),
                    Expanded(
                        child: CustomButton(
                      function: () => MagicRouter.navigateAndPopAll(Login()),
                      text: 'Yes',
                      height: 40.sp,
                      font: 15,
                    )),
                    SizedBox(
                      width: 35.sp,
                    ),
                  ],
                ),
              ),
            ],
          ));
  @override
  Widget build(BuildContext context) {
    return ontap == true
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                if (beforeNavigate != null) {
                  beforeNavigate!();
                }
                //  ontap;
                final shouldPop = await showWarning(context);
                shouldPop ?? false;
                print(isHome);
                print("isHome");

                if (isHome && Home.scaffoldStateKey.currentState != null) {
                  print('close drawer');
                  Home.scaffoldStateKey.currentState!.closeDrawer();
                }
                if (Scaffold.of(context).isDrawerOpen) {
                  print('close drawer');

                  Scaffold.of(context).closeDrawer();
                }
              },
              child: Row(
                children: [
                  icon == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            height: 30.h,
                            width: 25.w,
                            image: const AssetImage(
                              'assets/images/blog.png',
                            ),
                            color: ColorManager.yellow,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            icon,
                            color: ColorManager.yellow,
                          ),
                        ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                print(inHome);
                print("isHome");
                print(isHome);
                if (!inHome) {
                  MagicRouter.navigateAndPopUntilFirstPage(navigatename);
                }
                if (beforeNavigate != null) {
                  beforeNavigate!();
                }
                if (isHome && Home.scaffoldStateKey.currentState != null) {
                  print('close drawer');
                  Home.scaffoldStateKey.currentState!.closeDrawer();
                  print('is home true');
                  print(isHome);
                }
                if (Scaffold.of(context).isDrawerOpen) {
                  print('close drawer');

                  Scaffold.of(context).closeDrawer();
                }
              },
              child: Row(
                children: [
                  icon == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            height: 30.h,
                            width: 25.w,
                            image: const AssetImage(
                              'assets/images/blog.png',
                            ),
                            color: ColorManager.yellow,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            icon,
                            color: ColorManager.yellow,
                          ),
                        ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
