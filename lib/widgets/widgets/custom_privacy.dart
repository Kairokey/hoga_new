import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/router/router.dart';

import '../../../core/color_manager/color_manager.dart';
import '../../../widgets/widgets/custom_text.dart';
import '../../features/vehicles/get_vehicles/cubit/vehicle_cubit.dart';
import 'custom_dialog.dart';

class Privacy extends StatefulWidget {
  Privacy(this.value, {super.key});
  var value;
  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FittedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: VehiclesCubit.get(context).value,
                    onChanged: (val) {
                      setState(() {
                        VehiclesCubit.get(context).value = val!;
                        widget.value = val;
                      });
                    }),
                CustomText(
                  text: 'By logging in, I accept the ',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                InkWell(
                    onTap: () {
                      MagicRouter.navigateTo(const CustomDialog(
                        desc:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse commodo odio et arcu commodo malesuada. Ut a varius leo, nec tincidunt odio. Aliquam eleifend nisl ante, sed scelerisque diam volutpat pharetra. Proin sit amet laoreet nisi, a rhoncus massa. Ut vitae dictum justo, eu pulvinar sem. Duis aliquet vel purus sed bibendum. Nulla accumsan turpis at justo blandit, ac vestibulum nulla dignissim. Aliquam euismod porta eros, sed malesuada dolor condimentum in. Mauris sed suscipit justo, bibendum volutpat est. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce ex erat, ornare interdum metus in, vehicula ultricies turpis. Ut facilisis nisl odio, non venenatis urna condimentum nec. Sed sodales, dolor eu viverra fermentum, lacus orci gravida elit, bibendum mollis tortor dui sed orci.\nInteger et libero dui. Nullam viverra mi turpis, aliquet sagittis nibh tincidunt eget. Etiam nec quam porta, tincidunt dolor a, viverra turpis. Sed venenatis rutrum urna ac accumsan. Morbi nunc nisl, egestas sed velit non, egestas eleifend risus. Proin at massa nunc. Donec in tellus dolor. In sodales sem neque, et maximus nibh imperdiet id. Proin dignissim, erat et fermentum hendrerit, sem felis pretium lectus, a blandit sem sem congue justo. Integer sollicitudin vitae purus ac tempor. Vestibulum dignissim a leo eu lobortis. Nunc sodales tempor dui, eu dictum elit laoreet quis. Curabitur et nisl neque.',
                        title: 'Terms & Conditions',
                      ));
                    },
                    child: CustomText(
                      text: 'Terms of Service',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: ColorManager.yellow,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: ' & acknowledge the',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                InkWell(
                    onTap: () {
                      MagicRouter.navigateTo(const CustomDialog(
                        desc:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse commodo odio et arcu commodo malesuada. Ut a varius leo, nec tincidunt odio. Aliquam eleifend nisl ante, sed scelerisque diam volutpat pharetra. Proin sit amet laoreet nisi, a rhoncus massa. Ut vitae dictum justo, eu pulvinar sem. Duis aliquet vel purus sed bibendum. Nulla accumsan turpis at justo blandit, ac vestibulum nulla dignissim. Aliquam euismod porta eros, sed malesuada dolor condimentum in. Mauris sed suscipit justo, bibendum volutpat est. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce ex erat, ornare interdum metus in, vehicula ultricies turpis. Ut facilisis nisl odio, non venenatis urna condimentum nec. Sed sodales, dolor eu viverra fermentum, lacus orci gravida elit, bibendum mollis tortor dui sed orci.\nInteger et libero dui. Nullam viverra mi turpis, aliquet sagittis nibh tincidunt eget. Etiam nec quam porta, tincidunt dolor a, viverra turpis. Sed venenatis rutrum urna ac accumsan. Morbi nunc nisl, egestas sed velit non, egestas eleifend risus. Proin at massa nunc. Donec in tellus dolor. In sodales sem neque, et maximus nibh imperdiet id. Proin dignissim, erat et fermentum hendrerit, sem felis pretium lectus, a blandit sem sem congue justo. Integer sollicitudin vitae purus ac tempor. Vestibulum dignissim a leo eu lobortis. Nunc sodales tempor dui, eu dictum elit laoreet quis. Curabitur et nisl neque.',
                        title: 'Terms & Conditions',
                      ));
                    },
                    child: CustomText(
                      text: 'Privacy Policy.',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: ColorManager.yellow,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
