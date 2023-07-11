import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/core/dialoges/toast.dart';
import 'package:hoga_load/core/widgets/custom_card_title.dart';
import 'package:hoga_load/features/home/view.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_package.dart';
import '../../core/data/local/cacheHelper.dart';
import '../../core/keys/keys.dart';
import '../../core/widgets/custom_card.dart';
import '../../widgets/widgets/custom_button.dart';
import '../../widgets/widgets/custom_notloggedin.dart';
import 'cubit/package_cubit.dart';
import 'cubit/package_states.dart';
part 'units/body.dart';

GlobalKey<ScaffoldState> packagesScaffoldKey = GlobalKey<ScaffoldState>();

class PackagesView extends StatelessWidget {
  const PackagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: packagesScaffoldKey,
        drawer: OnDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(
              title: 'Packages',
              scaffoldKey: packagesScaffoldKey,
            ),
            // ignore: prefer_const_constructors
            !CacheHelper.getBool(SharedKeys.isLogin)
                ? const CustomNotLoggedIn()
                : const Expanded(
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: PackageBody())),
          ],
        ),
      ),
    );
  }
}
