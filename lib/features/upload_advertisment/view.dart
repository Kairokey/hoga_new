import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/features/home/view.dart';
import 'package:hoga_load/features/search_product/cubit/getProduct_cubit.dart';
import 'package:hoga_load/features/upload_advertisment/units/table_data.dart';
import 'package:hoga_load/features/upload_product/units/button.dart';
import 'package:hoga_load/features/upload_product/units/table_data.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_scaffold.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
import 'package:hoga_load/widgets/widgets/upgrade_member_ship.dart';
import '../../core/color_manager/color_manager.dart';
import '../../core/data/local/cacheHelper.dart';
import '../../core/keys/keys.dart';
import '../../core/widgets/custom_card.dart';
import '../../core/widgets/custom_card_title.dart';
import '../../core/widgets/custom_no_container.dart';
import '../../widgets/widgets/custom_notloggedin.dart';
import '../auth/units/cant_login.dart';
import '../packages/cubit/package_cubit.dart';
import '../search_product/cubit/getProduct__states.dart';
part 'units/uploaded.dart';

class UploadAdvertismentsView extends StatefulWidget {
  const UploadAdvertismentsView({Key? key}) : super(key: key);

  @override
  State<UploadAdvertismentsView> createState() => _UploadAdvertismentsViewState();
}

class _UploadAdvertismentsViewState extends State<UploadAdvertismentsView> {
  GlobalKey<ScaffoldState> uploadedProductsScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: uploadedProductsScaffoldKey,
        drawer: OnDrawer(),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(
              title: 'ADVERTISEMENTS',
              scaffoldKey: uploadedProductsScaffoldKey,
            ),
           ! CacheHelper.getBool(SharedKeys.isLogin)?const CustomNotLoggedIn(): const Expanded(child: Uploaded()),
          ],
        ),
      ),
    );
  }
}
