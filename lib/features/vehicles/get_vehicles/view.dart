import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/router/router.dart';
import 'package:shimmer/shimmer.dart';
import 'cubit/vehicle_cubit.dart';
import 'cubit/vehicle_states.dart';
import 'details.dart';
import 'filter_page.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_row.dart';
import 'package:hoga_load/widgets/widgets/custom_scaffold.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
part 'units/body.dart';

class VehiclesView extends StatefulWidget {
  const VehiclesView({Key? key}) : super(key: key);

  @override
  State<VehiclesView> createState() => _VehiclesViewState();
}

class _VehiclesViewState extends State<VehiclesView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VehiclesCubit.get(context).page = 1;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(title: 'Vehicles'),
            SizedBox(
              height: 22.h,
            ),
            CustomSearchRow(
              1,
              function: () {
                MagicRouter.navigateTo(FilterVehicle());
              },
            ),
            SizedBox(
              height: 21.h,
            ),
            Expanded(child:
            Body())
          ],
        ),
      ),
    );
  }
}
