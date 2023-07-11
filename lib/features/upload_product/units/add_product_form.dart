part of '../add_view.dart';

class Form extends StatefulWidget {
  Form(
      {Key? key,
      this.isFilter = false,
      this.productModel,
      this.isEdit = false,
      this.index})
      : super(key: key);
  bool isFilter;
  GetProductModel? productModel;
  bool isEdit;
  int? index;
  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  String country = '';
  String state = '';
  String city = '';
  String product = '';
  String? buyOrSell;
  int? countryId;
  int? stateId;
  String? cityId;
  int? productId;
  List productType = ['Buy', 'Sell'];
  bool loading = false;
  String? imageFile;

  @override
  void initState() {
    super.initState();
    buyOrSell = null;
    product = '';
    ProductsCubit.get(context).nameController.text = '';
    ProductsCubit.get(context).priceController.text = '';
    ProductsCubit.get(context).descController.text = '';

    if (widget.isEdit) {
      print('@@@@@@@@@@@@@@@@${widget.productModel!.toJson()}');
      buyOrSell = widget.productModel!.buyOrSell;
      ProductsCubit.get(context).priceController.text =
          widget.productModel!.price!;
      ProductsCubit.get(context).nameController.text =
          widget.productModel!.productName!;
      ProductsCubit.get(context).descController.text =
          widget.productModel!.description == null
              ? ""
              : widget.productModel!.description!;
      city = widget.productModel!.city == null
          ? 'other'
          : widget.productModel!.city!.title!;
      country = widget.productModel!.country == null
          ? 'other'
          : widget.productModel!.country!.title!;
      state = widget.productModel!.state == null
          ? 'other'
          : widget.productModel!.state!.title!;
      product = (widget.productModel!.productType == null
          ? null
          : widget.productModel!.productType!.title!)!;
      productId = widget.productModel!.productType == null
          ? null
          : widget.productModel!.productType!.id!;
      cityId = widget.productModel!.city == null
          ? null
          : widget.productModel!.city!.id!.toString();
      countryId = widget.productModel!.country == null
          ? null
          : widget.productModel!.country!.id!;
      stateId = widget.productModel!.state == null
          ? null
          : widget.productModel!.state!.id!;

      imageFile = widget.productModel!.productImage!;
      ProductsCubit.get(context).img64 = widget.productModel!.productImage!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, AddProductStates>(
        listener: (BuildContext context, state) {
      if (state is GetSearchSuccess || state is EditSuccess) {
        Navigator.pop(context);
      }
    }, builder: (BuildContext context, s) {
      return CustomCard(
        widget: BlocConsumer<DataFormCubit, AddDataFormStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, s) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            widget.isEdit
                                ? MagicRouter.navigateTo(
                                    const UploadProductsView())
                                : Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_sharp,
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            text: widget.isEdit
                                ? "EDIT PRODUCT"
                                : widget.isFilter
                                    ? 'SEARCH PRODUCT'
                                    : 'ADD PRODUCT ',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  CustomTextField(
                      height: 64.h,
                      readOnly: true,
                      lines: 1,
                      name: 'Product for',
                      hintText: buyOrSell ?? 'Select Purpose',
                      suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView.builder(
                                  itemCount: productType.length,
                                  itemBuilder: (context, index) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                buyOrSell = productType[index];
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: productType[index] == null
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.green,
                                                      ),
                                                    )
                                                  : Text(
                                                      productType[index],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.sp),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                          );
                        },
                        child: Icon(
                          Icons.expand_more,
                          size: 30.sp,
                          color: ColorManager.blackColor,
                        ),
                      )),
                  CustomTextField(
                    // name: '',
                    height: 64.h,
                    lines: 1,
                    hintText: 'Name of the Product',
                    controller: ProductsCubit.get(context).nameController,
                    color: Colors.grey,
                  ),
                  CustomTextField(
                      height: 64.h,
                      readOnly: true,
                      name: 'Country',
                      hintText: country == '' ? 'Select a Country' : country,
                      suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView.builder(
                                  itemCount: DataFormCubit.get(context)
                                      .countryList
                                      .length,
                                  itemBuilder: (context, index) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                countryId =
                                                    DataFormCubit.get(context)
                                                        .countryList[index]
                                                        .id!;
                                                country =
                                                    DataFormCubit.get(context)
                                                        .countryList[index]
                                                        .title!;
                                                Navigator.of(context).pop();
                                                city = '';
                                                state = '';
                                              });
                                              DataFormCubit.get(context)
                                                  .getState(
                                                      DataFormCubit.get(context)
                                                          .countryList[index]
                                                          .id!);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DataFormCubit.get(context)
                                                          .countryList[index]
                                                          .title ==
                                                      null
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.green,
                                                      ),
                                                    )
                                                  : Text(
                                                      DataFormCubit.get(context)
                                                          .countryList[index]
                                                          .title!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.sp),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                          );
                        },
                        child: Icon(
                          Icons.expand_more,
                          size: 30.sp,
                          color: ColorManager.blackColor,
                        ),
                      )),
                  s is GetStateLoading
                      ? CustomText(
                          text: 'Loading....',
                        )
                      : CustomTextField(
                          height: 64.h,
                          readOnly: true,
                          name: 'state',
                          hintText: state == '' ? 'Select a state' : state,
                          suffixIcon: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ListView.builder(
                                      itemCount: DataFormCubit.get(context)
                                          .stateList
                                          .length,
                                      itemBuilder: (context, index) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    stateId = DataFormCubit.get(
                                                            context)
                                                        .stateList[index]
                                                        .id!;
                                                    state = DataFormCubit.get(
                                                            context)
                                                        .stateList[index]
                                                        .title!;
                                                    Navigator.of(context).pop();
                                                    city = '';
                                                  });
                                                  DataFormCubit.get(context)
                                                      .getCity(
                                                          DataFormCubit.get(
                                                                  context)
                                                              .stateList[index]
                                                              .title!);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: DataFormCubit.get(
                                                                  context)
                                                              .stateList[index]
                                                              .title ==
                                                          null
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.green,
                                                          ),
                                                        )
                                                      : Text(
                                                          DataFormCubit.get(
                                                                  context)
                                                              .stateList[index]
                                                              .title!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20.sp),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ));
                                },
                              );
                            },
                            child: Icon(
                              Icons.expand_more,
                              size: 30.sp,
                              color: ColorManager.blackColor,
                            ),
                          )),
                  s is GetCityLoading
                      ? CustomText(
                          text: 'Loading....',
                        )
                      : CustomTextField(
                          height: 64.h,
                          readOnly: true,
                          name: 'City',
                          hintText: city == '' ? 'Select a city' : city,
                          suffixIcon: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return DataFormCubit.get(context)
                                          .cityList
                                          .isEmpty
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              city = 'other';
                                              Navigator.of(context).pop();
                                              cityId = 'other';
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 0.4.sh,
                                                right: 8,
                                                left: 8),
                                            child: Text(
                                              'other',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.sp),
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: DataFormCubit.get(context)
                                              .cityList
                                              .length,
                                          itemBuilder: (context, index) =>
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        cityId =
                                                            DataFormCubit.get(
                                                                    context)
                                                                .cityList[index]
                                                                .id!
                                                                .toString();
                                                        city =
                                                            DataFormCubit.get(
                                                                    context)
                                                                .cityList[index]
                                                                .title!;
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DataFormCubit.get(
                                                                      context)
                                                                  .cityList[
                                                                      index]
                                                                  .title ==
                                                              null
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            )
                                                          : Text(
                                                              DataFormCubit.get(
                                                                      context)
                                                                  .cityList[
                                                                      index]
                                                                  .title!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      20.sp),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                },
                              );
                            },
                            child: Icon(
                              Icons.expand_more,
                              size: 30.sp,
                              color: ColorManager.blackColor,
                            ),
                          )),
                  CustomTextField(
                      height: 64.h,
                      readOnly: true,
                      name: 'Product Type',
                      hintText:
                          product == '' ? 'Select a product type' : product,
                      suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView.builder(
                                  itemCount: DataFormCubit.get(context)
                                      .productList
                                      .length,
                                  itemBuilder: (context, index) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                productId =
                                                    DataFormCubit.get(context)
                                                        .productList[index]
                                                        .id!;
                                                product =
                                                    DataFormCubit.get(context)
                                                        .productList[index]
                                                        .title!;
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DataFormCubit.get(context)
                                                          .productList[index]
                                                          .title ==
                                                      null
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.green,
                                                      ),
                                                    )
                                                  : Text(
                                                      DataFormCubit.get(context)
                                                          .productList[index]
                                                          .title!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.sp),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                          );
                        },
                        child: Icon(
                          Icons.expand_more,
                          size: 30.sp,
                          color: ColorManager.blackColor,
                        ),
                      )),
                  CustomTextField(
                    height: 64.h,
                    hintText: 'Price (CAD)',
                    keyboardType: TextInputType.number,
                    controller: ProductsCubit.get(context).priceController,
                  ),
                  widget.isFilter
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 14.w),
                          child: Container(
                            height: 64.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorManager.greyColor),
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: InkWell(
                              onTap: () {
                                ProductsCubit.get(context)
                                    .pickFromGallery(context);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 64.h,
                                    width: 106.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Center(
                                      child: Text(
                                        'Choose File',
                                        style: TextStyle(
                                            color: const Color(0xFF757575),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        widget.isEdit
                                            ? imageFile != null
                                                ? imageFile!
                                                : '    No File chosen'
                                            : ProductsCubit.get(context)
                                                        .image !=
                                                    null
                                                ? '${ProductsCubit.get(context).image.toString().split('/data/user/0/com.example.hoga_load/cache/image_picker')}'
                                                : '    No File chosen',
                                        style: TextStyle(
                                            color: const Color(0xFF757575),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 1.sw,
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  CustomTextField(
                    height: 147.h,
                    lines: 6,
                    controller: ProductsCubit.get(context).descController,
                    hintText: 'Description',
                  ),
                  BlocListener<ProductsCubit, AddProductStates>(
                    listener: (BuildContext context, state) {
                      if (state is AddProductLoading) {
                        setState(() {
                          loading = true;
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                      }
                      if (state is AddSuccess) {
                        ProductsCubit.get(context).getProduct(self: 1);
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.sp, bottom: 15.sp),
                      child: loading
                          ? Center(
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: const CircularProgressIndicator()))
                          : CustomButton(
                              text: widget.isEdit
                                  ? 'Edit Product'
                                  : widget.isFilter
                                      ? 'Filter'
                                      : 'Add new product',
                              color: ColorManager.yellow,
                              function: () async {
                                if (widget.isEdit) {
                                  await ProductsCubit.get(context)
                                      .editProductCubit(GetProductModel(
                                          id: widget.productModel!.id,
                                          buyOrSell: buyOrSell,
                                          productName:
                                              ProductsCubit.get(context)
                                                  .nameController
                                                  .text,
                                          priceInt: ProductsCubit.get(context)
                                                  .priceController
                                                  .text
                                                  .isEmpty
                                              ? null
                                              : int.parse(
                                                  ProductsCubit.get(context)
                                                      .priceController
                                                      .text),
                                          productTypeId: productId,
                                          countryPost: countryId,
                                          statePost: stateId,
                                          cityPost: cityId,
                                          description:
                                              ProductsCubit.get(context)
                                                  .descController
                                                  .text,
                                          productImage:
                                              ProductsCubit.get(context)
                                                  .image));
                                } else if (widget.isFilter) {
                                  await ProductsCubit.get(context)
                                      .searchProducts(GetProductModel(
                                    buyOrSell: buyOrSell,
                                    productTypeId: productId,
                                    countryPost: countryId,
                                    statePost: stateId,
                                    cityPost: cityId,
                                  ));
                                } else {
                                  print('!!!!!!!!!!!!!!!!!!!!!!!');
                                  print(ProductsCubit.get(context)
                                      .priceController
                                      .text);
                                  print(cityId);
                                  print(ProductsCubit.get(context)
                                      .priceController);
                                  print(GetProductModel(
                                          buyOrSell: buyOrSell,
                                          productName:
                                              ProductsCubit.get(context)
                                                  .nameController
                                                  .text,
                                          priceInt: ProductsCubit.get(context)
                                                  .priceController
                                                  .text
                                                  .isNotEmpty
                                              ? int.parse(
                                                  ProductsCubit.get(context)
                                                      .priceController
                                                      .text)
                                              : null,
                                          productTypeId: productId,
                                          countryPost: countryId,
                                          statePost: stateId,
                                          cityPost: cityId,
                                          description:
                                              ProductsCubit.get(context)
                                                  .descController
                                                  .text,
                                          productImage:
                                              ProductsCubit.get(context).image)
                                      .toJson());
                                  await ProductsCubit.get(context)
                                      .addProductCubit(
                                          context: context,
                                          productModel: GetProductModel(
                                              buyOrSell: buyOrSell,
                                              productName:
                                                  ProductsCubit.get(context)
                                                      .nameController
                                                      .text,
                                              priceInt: ProductsCubit.get(context)
                                                      .priceController
                                                      .text
                                                      .isNotEmpty
                                                  ? int.parse(
                                                      ProductsCubit.get(context)
                                                          .priceController
                                                          .text)
                                                  : null,
                                              productTypeId: productId,
                                              countryPost: countryId,
                                              statePost: stateId,
                                              cityPost: cityId.toString(),
                                              description:
                                                  ProductsCubit.get(context)
                                                      .descController
                                                      .text,
                                              productImage:
                                                  ProductsCubit.get(context)
                                                      .image));
                                }
                              },
                            ),
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              );
            }),
      );
    });
  }
}
