import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
import 'package:hoga_load/widgets/widgets/custom_text_field.dart';
import '../../features/packages/cubit/package_cubit.dart';

class CustomPackage extends StatefulWidget {
  CustomPackage({
    Key? key,
    this.text2,
    required this.index,
    this.price,
    this.text1,
    this.conttext1,
    this.totalprice,
    this.conttext2,
  }) : super(key: key);
  int index;
  var text1;
  var text2;
  var price;
  var conttext1;
  var conttext2;
  var totalprice;
  TextEditingController? textController = TextEditingController();
  TextEditingController? textController2 = TextEditingController();
  String day = '';
  String month = '';
  String year = '';
  String fromDate = '';
  String toDate = '';

  @override
  State<CustomPackage> createState() => _CustomPackageState();
}

class _CustomPackageState extends State<CustomPackage> {
  @override
  Widget build(BuildContext context) {
    print(PackageCubit.get(context).fromdate);
    print('PackageCubit.get(context).fromdate');

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    PackageCubit.get(context)
                        .changeSelectedPackage(widget.index);
                    setState(() {});
                  },
                  child: Radio(
                      activeColor: Colors.orange,
                      focusColor: Colors.orange,
                      value: widget.index,
                      groupValue: PackageCubit.get(context).selectedPackage,
                      onChanged: (value) {
                        PackageCubit.get(context)
                            .changeSelectedPackage(widget.index);
                      }),
                ),
                CustomText(
                  text: widget.text1,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF777777),
                )
              ],
            ),
            Row(
              children: [
                CustomText(
                  text: widget.price,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: const Color(0xFFFDC52F),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 42.w, right: 14.w),
          child: Container(
            width: 1.sw,
            child: CustomText(
              align: TextAlign.start,
              text: widget.text2,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF777777),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        widget.conttext1 != null
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 42.w, right: 14.w),
                    child: CustomTextField(
                      height: 50.h,
                      enabled: false,
                      readOnly: true,
                      hintText: PackageCubit.get(context).fromdate == '' ||
                              PackageCubit.get(context).fromdate == null
                          ? 'dd-mm-yy'
                          : PackageCubit.get(context).fromdate,

                      //controller: widget.textController!,
                      suffixIcon: InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000),
                                initialDate: DateTime.now());
                            if (newDate == null) return;
                            setState(() {
                              widget.day = newDate.day.toString();
                              widget.month = newDate.month.toString();
                              widget.year = newDate.year.toString();

                              widget.fromDate =
                                  '${widget.day}/${widget.month}/${widget.year}';
                              PackageCubit.get(context).fromdate =
                                  widget.fromDate;
                              PackageCubit.get(context).fromdate2 = newDate;
                            });
                          },
                          child: const Icon(Icons.date_range_outlined)),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                      child: CustomText(
                    text: 'to',
                    fontSize: 16.sp,
                    color: const Color(0xFF777777),
                    fontWeight: FontWeight.w500,
                  )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 42.w, right: 14.w),
                    child: CustomTextField(
                      height: 50.h,
                      readOnly: true,
                      // enabled: false,
                      hintText: PackageCubit.get(context).todate == '' ||
                              PackageCubit.get(context).todate == null
                          ? 'dd-mm-yy'
                          : PackageCubit.get(context).todate,

                      //controller: widget.textController!,
                      suffixIcon: InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000),
                                initialDate: DateTime.now());
                            if (newDate == null) return;
                            setState(() {
                              widget.day = newDate.day.toString();
                              widget.month = newDate.month.toString();
                              widget.year = newDate.year.toString();

                              widget.toDate =
                                  '${widget.day}/${widget.month}/${widget.year}';
                              PackageCubit.get(context).todate = widget.toDate;
                            });
                          },
                          child: const Icon(Icons.date_range_outlined)),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 42.w, right: 14.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Total Payable',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF777777),
                        ),
                        CustomText(
                          text: widget.totalprice,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF777777),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    width: 1.sw,
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w, right: 14.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: 'Total Payable',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF777777),
                        ),
                        CustomText(
                          text: widget.totalprice,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF777777),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
        SizedBox(
          width: 1.sw,
          child: const Divider(
            thickness: 1,
          ),
        ),
        SizedBox(
          height: 15.h,
        )
      ],
    );
  }
}
