import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hoga_load/features/search_product/cubit/getProduct_cubit.dart';
import 'package:hoga_load/features/upload_product/add_view.dart';
import 'package:hoga_load/features/upload_product/units/table_product_title.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/color_manager/color_manager.dart';
import '../../../core/dialoges/delete_dialoge.dart';
import '../../../core/router/router.dart';
import '../../../widgets/widgets/custom_text.dart';
import '../../search_product/cubit/getProduct__states.dart';

class MyProductTable extends StatelessWidget {
  const MyProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    return UploadedTableProduct(
        child: RefreshIndicator(
      color: Colors.orange,
      backgroundColor: Colors.white,
      onRefresh: () async {
        print('refresh');
        await ProductsCubit.get(context).resetPage();
        print("page is " + '${ProductsCubit.get(context).page}');
        await ProductsCubit.get(context)
            .getProduct(page: ProductsCubit.get(context).page, self: 1);
      },
      child: BlocConsumer<ProductsCubit, AddProductStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (context, state) {

    if (state is AddProductLoading) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              color: index.isEven
                  ? Colors.grey[300]
                  : Colors.white,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                          enabled: true,
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: Container(
                              width: 0.2.sw,
                              height: 12.sp,
                              color: Colors.grey[300]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                            enabled: true,
                            baseColor: Colors.grey[300]!,
                            highlightColor:
                            Colors.grey[400]!,
                            child: Container(
                                width: 0.2.sw,
                                height: 12.sp,
                                color: Colors.grey[300])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                            enabled: true,
                            baseColor: Colors.grey[300]!,
                            highlightColor:
                            Colors.grey[400]!,
                            child: Container(
                                width: 0.2.sw,
                                height: 12.sp,
                                color: Colors.grey[300])),
                      ),

                    ],
                  ),
                ),
              ),
            );
          });
    }else{
      return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: ProductsCubit.get(context).myProductList.length+1,
          itemBuilder: (context, index) {
            print('condition');
            print(index);
            print(ProductsCubit.get(context).myProductList.length);


            if (index == ProductsCubit.get(context).myProductList.length) {
              print('condition true');
              return Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (ProductsCubit.get(context)
                            .page >
                            1) {
                          ProductsCubit.get(context)
                              .resetPage();
                          ProductsCubit.get(context)
                              .getProduct(
                            self: 1,
                            page:
                            ProductsCubit.get(
                                context)
                                .page,
                          );
                        }
                      },
                      child: Icon(
                        Icons.skip_previous_rounded,
                        color: ProductsCubit.get(context)
                            .page >
                            1
                            ? Colors.grey[600]
                            : Colors.grey[400],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (ProductsCubit.get(context)
                            .page >
                            1) {
                          ProductsCubit.get(context)
                              .changePage(
                              ProductsCubit.get(context)
                                  .page -
                                  1);
                          ProductsCubit.get(context)
                              .getProduct(
                            self: 1,
                            page:
                            ProductsCubit.get(
                                context)
                                .page,
                          );
                        }
                      },
                      child: Icon(
                        Icons.chevron_left_outlined,
                        color: ProductsCubit.get(context)
                            .page >
                            1
                            ? Colors.grey[600]
                            : Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      height: 24,
                      width: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius:
                        BorderRadius.circular(3),
                      ),
                      child: Text(
                        ProductsCubit.get(context)
                            .page
                            .toString(),
                        style:
                        const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        int page =
                            ProductsCubit.get(context).page;

                        if (ProductsCubit.get(context)
                            .myProductList
                            .length
                            .remainder(10) ==
                            0) {
                          ProductsCubit.get(context)
                              .changePage(page + 1);

                          ProductsCubit.get(context)
                              .getProduct(
                            self: 1,
                            page:
                            ProductsCubit.get(
                                context)
                                .page,
                          );
                        }
                      },
                      child: Icon(
                        Icons.chevron_right_outlined,
                        color: ProductsCubit.get(context)
                            .myProductList
                            .length
                            .remainder(10) ==
                            0
                            ? Colors.grey[600]
                            : Colors.grey[400],
                      ),
                    ),
                    Icon(
                      Icons.skip_next,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              );
            }else {
              return Container(
                color: index.isEven ? Colors.grey[300] : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomText(
                          text: '${index + 1}',
                          align: TextAlign.start,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomText(
                          text: ProductsCubit
                              .get(context)
                              .myProductList[index]
                              .productName,
                          align: TextAlign.start,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomText(
                          text: ProductsCubit
                              .get(context)
                              .myProductList[index]
                              .productType == null ?
                          'other' : ProductsCubit
                              .get(context)
                              .myProductList[index]
                              .productType!
                              .title,
                          align: TextAlign.start,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DeleteEditDialog(
                                          function: () {
                                            Navigator.pop(context);
                                            MagicRouter.navigateTo(
                                                AddProductsView(
                                                    isEdit: true,
                                                    productModel:
                                                    ProductsCubit
                                                        .get(
                                                        context)
                                                        .myProductList[
                                                    index],
                                                    index: index));
                                          },
                                          btnText: 'Edit',
                                        ));
                              },
                              child: CustomText(
                                text: 'Edit',
                                align: TextAlign.start,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w200,
                                color: ColorManager.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            InkWell(
                              onTap: () {
                                print('id');
                                print(ProductsCubit
                                    .get(context)
                                    .myProductList[index]
                                    .id);
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DeleteEditDialog(
                                          function: () {
                                            ProductsCubit.get(context)
                                                .deleteProductCubit(
                                                ProductsCubit
                                                    .get(
                                                    context)
                                                    .myProductList[
                                                index]
                                                    .id);
                                          },
                                          btnText: 'Delete',
                                        ));
                              },
                              child: CustomText(
                                text: 'Delete',
                                align: TextAlign.start,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w200,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          });

    }

          }),
    ));
  }
}
