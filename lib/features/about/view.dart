import 'package:flutter/material.dart';
import 'package:hoga_load/core/app_images/app_images.dart';
import 'package:hoga_load/core/color_manager/color_manager.dart';
import 'package:hoga_load/features/about/units/value_container.dart';
import 'package:hoga_load/widgets/widgets/custom_appbar.dart';
import 'package:hoga_load/widgets/widgets/custom_scaffold.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../home/view.dart';
import 'units/small_container.dart';
part 'units/body.dart';
part 'units/contact.dart';
part 'units/our_values.dart';
part 'units/video.dart';

class AboutUsView extends StatelessWidget {
  AboutUsView({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> passScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: OnDrawer(),
        key: passScaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(
              title: 'About Us',
              scaffoldKey: passScaffoldKey,
            ),
            SizedBox(
              height: 22.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Body(),
                    SizedBox(
                      height: 38.h,
                    ),
                    const Video(),
                    const Values(),
                    const Contact()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
