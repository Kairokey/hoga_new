import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/core/dialoges/toast.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:hoga_load/features/home/view.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_button.dart';

import 'package:hoga_load/widgets/widgets/custom_text.dart';
import 'package:hoga_load/widgets/widgets/custom_text_field.dart';

import '../../core/data/local/cacheHelper.dart';
import '../../core/data/models/card_model.dart';
import '../../core/data/models/vehicle/vehicles.dart';
import '../../core/keys/keys.dart';
import '../../core/master_cubit/getDataForm_cubit.dart';
import '../../core/master_cubit/getDataForm_state.dart';
import '../../core/validator/validator.dart';
import '../../core/widgets/custom_card.dart';
import '../../core/widgets/custom_card_title.dart';
import '../../widgets/widgets/custom_notloggedin.dart';
import '../auth/login.dart';
import 'cubit/addCard_cubit.dart';
import 'cubit/addCard_states.dart';
part 'units/form.dart';

class AddUpdateCardView extends StatefulWidget {
  AddUpdateCardView({Key? key}) : super(key: key);

  @override
  State<AddUpdateCardView> createState() => _AddUpdateCardViewState();
}

class _AddUpdateCardViewState extends State<AddUpdateCardView> {
  GlobalKey<ScaffoldState> passScaffoldKey = GlobalKey<ScaffoldState>();
@override
  void initState() {
  AddCardCubit.get(context).getCard();
    AddCardCubit.get(context).profileData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: passScaffoldKey,
        drawer:  OnDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(
              title: 'Add / Update Card Details',
              scaffoldKey: passScaffoldKey,
            ),
            !CacheHelper.getBool(SharedKeys.isLogin)
                ? const CustomNotLoggedIn()
                : const Expanded(
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 22.0),
                          child: FormCard(),
                        ))),
          ],
        ),
      ),
    );
  }
}
