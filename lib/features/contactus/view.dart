import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/app_images/app_images.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_button.dart';
import 'package:hoga_load/widgets/widgets/custom_scaffold.dart';
import 'package:hoga_load/widgets/widgets/custom_text_field.dart';

import '../../core/widgets/custom_card.dart';
import '../about/units/small_container.dart';
import '../home/view.dart';

part 'units/contact.dart';
part 'units/form.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> passScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: OnDrawer(),
        key: passScaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppbar(
                title: 'Contact Us',
                scaffoldKey: passScaffoldKey,
              ),
              SizedBox(
                height: 22.h,
              ),
              const Form(),
              SizedBox(
                height: 22.h,
              ),
              const contact(),
            ],
          ),
        ),
      ),
    );
  }
}
