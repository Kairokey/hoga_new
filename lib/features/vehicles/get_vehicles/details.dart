import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/widgets/widgets/custom_rowdrawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/data/models/vehicle/vehicles.dart';
import '../../../widgets/widgets/custom_appbar.dart';
import '../../../widgets/widgets/custom_container_vehicle_detail.dart';
import '../../../widgets/widgets/custom_scaffold.dart';
import '../../home/view.dart';
class Detail extends StatelessWidget {
  Detail(this.vehicle, {super.key}) ;
  Vehicles? vehicle;
  GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:scaffoldKey ,
        drawer:  OnDrawer(),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(title: 'View Vehicles',scaffoldKey: scaffoldKey,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: CustomContainerVehicle(vehicle!)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
