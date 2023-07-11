import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/about/view.dart';
import 'package:hoga_load/features/add_update_card/view.dart';
import 'package:hoga_load/features/blogs/view.dart';
import 'package:hoga_load/features/change_password/view.dart';
import 'package:hoga_load/features/contactus/view.dart';
import 'package:hoga_load/features/home/states.dart';
import 'package:hoga_load/features/packages/view.dart';
import 'package:hoga_load/features/subscribtion_details/view.dart';
import 'package:hoga_load/features/upload_product/view.dart';
import 'package:hoga_load/widgets/widgets/custom_button.dart';
import 'package:hoga_load/widgets/widgets/custom_rowdrawer.dart';
import '../../core/data/local/cacheHelper.dart';
import '../../core/keys/keys.dart';
import '../auth/login.dart';
import '../jobs/upload_jop/view.dart';
import '../loads/uploaded_loads/view.dart';
import '../upload_advertisment/view.dart';
import '../vehicles/upload_vehicles/view.dart';
import 'controller.dart';

part 'units/drawer.dart';
part 'units/nav_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Do You want to exit the app?'),
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
                            height: 37.sp,
                            font: 15)),
                    SizedBox(
                      width: 35.sp,
                    ),
                    Expanded(
                        child: CustomButton(
                      function: () => Navigator.pop(context, true),
                      text: 'Yes',
                      height: 37.sp,
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
  static GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print('token');
    print(CacheHelper.getString(SharedKeys.token));
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        drawer: OnDrawer(
          inHome: true,
        ),
        key: scaffoldStateKey,
        bottomNavigationBar: _BottomBar(),
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (_, s) {},
          builder: (context, s) {
            return HomeCubit.get(context)
                .bottomScreens[HomeCubit.get(context).currentIndex];
          },
        ),
      ),
    );
  }
}
