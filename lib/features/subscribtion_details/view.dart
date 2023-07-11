import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/features/home/view.dart';
import 'package:hoga_load/features/subscribtion_details/units/details.dart';
import 'package:hoga_load/features/subscribtion_details/units/facilities.dart';
import 'package:hoga_load/features/subscribtion_details/units/plans.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import '../../core/data/local/cacheHelper.dart';
import '../../core/keys/keys.dart';
import '../../core/widgets/custom_card.dart';
import '../../widgets/widgets/custom_notloggedin.dart';
import '../../widgets/widgets/upgrade_member_ship.dart';
import '../dashboard/cubit/UpdateProfile_state.dart';
import '../dashboard/cubit/updateProfile_cubit.dart';

part 'units/body.dart';

GlobalKey<ScaffoldState> subscriptionScaffoldKey = GlobalKey<ScaffoldState>();

class SubscriptionDetailsView extends StatefulWidget {
  const SubscriptionDetailsView({Key? key}) : super(key: key);

  @override
  State<SubscriptionDetailsView> createState() => _SubscriptionDetailsViewState();
}

class _SubscriptionDetailsViewState extends State<SubscriptionDetailsView> {
  @override
  void initState() {
    UpdateProfileCubit.get(context).getSubscriptionData();

super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: subscriptionScaffoldKey,
        drawer:  OnDrawer(),
        body:  BlocConsumer<UpdateProfileCubit, UpdateProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
     //       print('cancelled -------');
   // print(UpdateProfileCubit.get(context).subscriptionData.subscriptionDetails!.subscriptionCancelled);
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppbar(
            title: 'Subscription Details',
            scaffoldKey: subscriptionScaffoldKey,
          ),
          !CacheHelper.getBool(SharedKeys.isLogin) || UpdateProfileCubit
              .get(context)
              .notLogged
              ? const CustomNotLoggedIn()
              : Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(), child: Body(state))),
        ],
      );
    }

        ),
      ),
    );
  }
}
