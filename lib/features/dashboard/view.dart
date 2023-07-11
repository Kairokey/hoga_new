import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/core/data/models/UpdateProfile_model.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/auth/login.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_button.dart';
import 'package:hoga_load/widgets/widgets/custom_text_field.dart';

import '../../core/data/local/cacheHelper.dart';
import '../../core/keys/keys.dart';
import '../../core/validator/validator.dart';
import '../../core/widgets/custom_card.dart';
import '../../widgets/widgets/custom_notloggedin.dart';
import '../home/view.dart';
import 'cubit/UpdateProfile_state.dart';
import 'cubit/updateProfile_cubit.dart';

part 'units/form.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  GlobalKey<ScaffoldState> uploadProductScaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  void initState() {
    UpdateProfileCubit.get(context).getUserProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${CacheHelper.getBool(SharedKeys.isLogin)}');
    print(
        '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${UpdateProfileCubit.get(context).notLogged}');
    return SafeArea(
      child: Scaffold(
          key: uploadProductScaffoldKey,
          drawer: OnDrawer(),
          body: !CacheHelper.getBool(SharedKeys.isLogin)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAppbar(
                        title: 'Dashboard',
                        scaffoldKey: uploadProductScaffoldKey),
                    const CustomNotLoggedIn()
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAppbar(
                        title: 'Dashboard',
                        scaffoldKey: uploadProductScaffoldKey),
                    FormView(),
                  ],
                )),
    );
  }
}
