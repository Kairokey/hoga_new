import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/core/widgets/custom_card.dart';
import 'package:hoga_load/features/search_product/units/login_details.dart';
import 'package:hoga_load/features/search_product/units/upgrade_details.dart';
import 'package:hoga_load/widgets/widgets/custom_text.dart';
import '../../core/data/local/cacheHelper.dart';
import '../../core/data/models/product/GetProduct_model.dart';
import '../../core/keys/keys.dart';

class CustomContainerProduct extends StatelessWidget {
  final GetProductModel product;
  const CustomContainerProduct(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      paddingInEnd: 0,
      paddingInStart: 0,
      bottomPadding: 15,
      widget: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              height: 200.h,
              child: Image(
                image: NetworkImage(product.productImage!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.network(
                    'https://hegaload.com/uploads/product-images/1657431690.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                left: 8.r,
                right: 8.r,
              ),
              child: Center(
                  child: CustomText(
                align: TextAlign.center,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                text: product.productName,
              )),
            ),
            SizedBox(
              height: 10.h,
              child: const Divider(),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          align: TextAlign.center,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          text: ' productType: ',
                        ),
                        Expanded(
                          child: CustomText(
                            align: TextAlign.start,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                            text: '${product.productType!.title}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0.w),
                    child: Row(
                      children: [
                        CustomText(
                          align: TextAlign.center,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          text: ' Purpose: For ',
                        ),
                        Expanded(
                          child: CustomText(
                            align: TextAlign.start,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                            text: '${product.buyOrSell}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0.w),
                    child: Row(
                      children: [
                        CustomText(
                          align: TextAlign.center,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          text: ' Posted On: ',
                        ),
                        Expanded(
                          child: CustomText(
                            align: TextAlign.start,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                            text: product.status.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0.w),
                    child: Row(
                      children: [
                        CustomText(
                          align: TextAlign.center,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          text: ' Price: ',
                        ),
                        Expanded(
                          child: CustomText(
                            align: TextAlign.start,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                            text: '\$ ${product.price}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 7.h,
                width: 1.sw,
                child: const Divider(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 12.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'CONTACT DETAILS',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: !CacheHelper.getBool(SharedKeys.isLogin)
                  ? const LoginDetails()
                  : product.user != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              product.user!.profilePicture != null
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 8.0.w),
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          height: 50,
                                          width: 50,
                                          clipBehavior: Clip.antiAlias,
                                          child: Image.network(
                                            product.user!.profilePicture,
                                            fit: BoxFit.cover,
                                          )),
                                    )
                                  : Container(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0.w),
                                child: Row(
                                  children: [
                                    CustomText(
                                      align: TextAlign.center,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      text: ' Firstname: ',
                                    ),
                                    Expanded(
                                      child: CustomText(
                                          align: TextAlign.center,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black38,
                                          text: '${product.user!.firstName}'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0.w),
                                child: Row(
                                  children: [
                                    CustomText(
                                      align: TextAlign.center,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      text: ' Lastname: ',
                                    ),
                                    Expanded(
                                      child: CustomText(
                                          align: TextAlign.center,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black38,
                                          text: '${product.user!.lastName}'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0.w),
                                child: Row(
                                  children: [
                                    CustomText(
                                      align: TextAlign.center,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      text: ' Email: ',
                                    ),
                                    Expanded(
                                      child: CustomText(
                                          align: TextAlign.start,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black38,
                                          text: '${product.user!.email}'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0.w),
                                child: Row(
                                  children: [
                                    CustomText(
                                      align: TextAlign.center,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      text: ' Contact Number: ',
                                    ),
                                    Expanded(
                                      child: CustomText(
                                          align: TextAlign.start,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black38,
                                          text:
                                              '${product.user!.contactNumber}'),
                                    ),
                                  ],
                                ),
                              ),
                              product.user!.address != null
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 8.0.w),
                                      child: Row(
                                        children: [
                                          CustomText(
                                            align: TextAlign.center,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            text: ' Address: ',
                                          ),
                                          Expanded(
                                            child: CustomText(
                                                align: TextAlign.center,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black38,
                                                text:
                                                    '${product.user!.address}'),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(height: 30)
                            ],
                          ),
                        )
                      : const UpgradeDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
