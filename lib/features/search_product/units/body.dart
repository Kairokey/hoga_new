part of '../view.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  List titlesList = ['Buy / Sell', 'Product', 'Type', 'Price', ' '];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.65.sh,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Container(
                  height: 43.h,
                  width: 0.2.sw * 7,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 0.2.sw,
                          child: CustomText(
                            text: titlesList[index],
                            fontSize: 12.sp,
                            align: TextAlign.start,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 0.2.sw * 7,
                  child: RefreshIndicator(
                    color: Colors.orange,
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      print('refresh');
                      await ProductsCubit.get(context).resetPage();
                      print("page is " + '${ProductsCubit.get(context).page}');
                      await ProductsCubit.get(context)
                          .getProduct(page: ProductsCubit.get(context).page);
                    },
                    child: BlocConsumer<ProductsCubit, AddProductStates>(
                      builder: (context, state) {
                        if (state is GetProductsFailed &&
                            state is GetSearchFailed) {
                          return Center(child: CustomText(text: state.msg));
                        } else if (state is GetSearchSuccess) {
                          return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.productList.length + 1,
                              itemBuilder: (context, index) {
                                if (index == state.productList.length) {
                                  print('condition true');
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
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
                                                      page:
                                                          ProductsCubit.get(
                                                                  context)
                                                              .page,
                                                      val: ProductsCubit.get(
                                                              context)
                                                          .searchValue);
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
                                                      page:
                                                          ProductsCubit.get(
                                                                  context)
                                                              .page,
                                                      val: ProductsCubit.get(
                                                              context)
                                                          .searchValue);
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
                                        const SizedBox(width: 5),
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
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () {
                                            int page =
                                                ProductsCubit.get(context).page;

                                            if (ProductsCubit.get(context)
                                                    .productList
                                                    .length
                                                    .remainder(10) ==
                                                0) {
                                              ProductsCubit.get(context)
                                                  .changePage(page + 1);

                                              ProductsCubit.get(context)
                                                  .getProduct(
                                                      page:
                                                          ProductsCubit.get(
                                                                  context)
                                                              .page,
                                                      val: ProductsCubit.get(
                                                              context)
                                                          .searchValue);
                                            }
                                          },
                                          child: Icon(
                                            Icons.chevron_right_outlined,
                                            color: ProductsCubit.get(context)
                                                        .productList
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
                                } else {
                                  return Container(
                                    color: index.isEven
                                        ? Colors.grey[300]
                                        : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: InkWell(
                                        onTap: () {
                                          MagicRouter.navigateTo(Detail(
                                              ProductsCubit.get(context)
                                                  .productList[index]));
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              width: 0.2.sw,
                                              text: state
                                                  .productList[index].buyOrSell,
                                              align: TextAlign.start,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            CustomText(
                                                width: 0.2.sw,
                                                text: state.productList[index]
                                                        .productName ??
                                                    'other',
                                                //   text: '',

                                                align: TextAlign.start,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                            CustomText(
                                                width: 0.2.sw,
                                                text: state.productList[index]
                                                            .productType ==
                                                        null
                                                    ? 'other'
                                                    : state.productList[index]
                                                        .productType!.title,
                                                align: TextAlign.start,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                            CustomText(
                                                width: 0.2.sw,
                                                text:
                                                    '\$ ${state.productList[index].price!} ' ??
                                                        'other',
                                                fontSize: 12.sp,
                                                align: TextAlign.start,
                                                fontWeight: FontWeight.w500),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image(
                                                height: 50,
                                                width: 0.2.sw,
                                                image: NetworkImage(state
                                                            .productList[index]
                                                            .productImage ==
                                                        null
                                                    ? 'https://hegaload.com/uploads/product-images/1657431690.jpg'
                                                    : state.productList[index]
                                                        .productImage!),
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 0.2.sw,
                                                    child: const Center(
                                                        child:
                                                            Icon(Icons.error)),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              });
                        } else if (state is GetProductsSuccess) {
                          return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.productList.length + 1,
                              itemBuilder: (context, index) {
                                if (index == state.productList.length) {
                                  print('condition true');
                                  print(index);
                                  print(state.productList.length);

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
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
                                                      page: ProductsCubit.get(
                                                              context)
                                                          .page);
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
                                                      page: ProductsCubit.get(
                                                              context)
                                                          .page);
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
                                        const SizedBox(width: 5),
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
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () {
                                            int page =
                                                ProductsCubit.get(context).page;

                                            if (ProductsCubit.get(context)
                                                    .productList
                                                    .length
                                                    .remainder(10) ==
                                                0) {
                                              ProductsCubit.get(context)
                                                  .changePage(page + 1);

                                              ProductsCubit.get(context)
                                                  .getProduct(
                                                      page: ProductsCubit.get(
                                                              context)
                                                          .page);
                                            }
                                          },
                                          child: Icon(
                                            Icons.chevron_right_outlined,
                                            color: ProductsCubit.get(context)
                                                        .productList
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
                                } else {
                                  print('condition false');

                                  return Container(
                                    color: index.isEven
                                        ? Colors.grey[300]
                                        : Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        MagicRouter.navigateTo(Detail(
                                            ProductsCubit.get(context)
                                                .productList[index]));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            width: 0.2.sw,
                                            text: state
                                                .productList[index].buyOrSell,
                                            align: TextAlign.start,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          CustomText(
                                              width: 0.2.sw,
                                              text: state.productList[index]
                                                      .productName ??
                                                  'other',
                                              align: TextAlign.start,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                          CustomText(
                                              width: 0.2.sw,
                                              text: state.productList[index]
                                                          .productType ==
                                                      null
                                                  ? 'other'
                                                  : state.productList[index]
                                                      .productType!.title,
                                              align: TextAlign.start,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                          CustomText(
                                              width: 0.2.sw,
                                              text:
                                                  '\$ ${state.productList[index].price!} ' ??
                                                      'other',
                                              fontSize: 12.sp,
                                              align: TextAlign.start,
                                              fontWeight: FontWeight.w500),
                                          CachedNetworkImage(
                                            height: 50,
                                            width: 0.2.sw,
                                            imageUrl: state.productList[index]
                                                .productImage!,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              });
                        } else if (state is AddProductLoading) {
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
                        } else {
                          return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  ProductsCubit.get(context).productList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: index.isEven
                                      ? Colors.grey[300]
                                      : Colors.white,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: InkWell(
                                      onTap: () {
                                        MagicRouter.navigateTo(Detail(
                                            ProductsCubit.get(context)
                                                .productList[index]));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            width: 0.2.sw,
                                            text: ProductsCubit.get(context)
                                                .productList[index]
                                                .buyOrSell,
                                            align: TextAlign.start,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          CustomText(
                                              width: 0.2.sw,
                                              text: ProductsCubit.get(context)
                                                      .productList[index]
                                                      .productName ??
                                                  'other',
                                              //   text: '',

                                              align: TextAlign.start,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                          CustomText(
                                              width: 0.2.sw,
                                              text: ProductsCubit.get(context)
                                                          .productList[index]
                                                          .productType ==
                                                      null
                                                  ? 'other'
                                                  : ProductsCubit.get(context)
                                                      .productList[index]
                                                      .productType!
                                                      .title,
                                              align: TextAlign.start,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                          CustomText(
                                              width: 0.2.sw,
                                              text:
                                                  '\$ ${ProductsCubit.get(context).productList[index].price!} ',
                                              fontSize: 12.sp,
                                              align: TextAlign.start,
                                              fontWeight: FontWeight.w500),
                                          Image(
                                              height: 50,
                                              width: 0.2.sw,
                                              image: NetworkImage(ProductsCubit
                                                              .get(context)
                                                          .productList[index]
                                                          .productImage ==
                                                      null
                                                  ? 'https://hegaload.com/uploads/product-images/1657431690.jpg'
                                                  : ProductsCubit.get(context)
                                                      .productList[index]
                                                      .productImage!))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                      listener: (BuildContext context, Object? state) {},
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
