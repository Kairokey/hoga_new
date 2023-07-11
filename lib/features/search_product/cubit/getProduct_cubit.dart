import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/core/data/repository/product_repo.dart';
import 'package:hoga_load/features/search_product/cubit/getProduct__states.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data/api/api.dart';
import '../../../core/data/local/cacheHelper.dart';
import '../../../core/data/models/product/GetProduct_model.dart';
import '../../../core/dialoges/toast.dart';
import '../../../core/keys/keys.dart';

class ProductsCubit extends Cubit<AddProductStates> {
  ProductsCubit() : super(AddProductLoading());
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  File? image;
  File? image1;
  //File? image2;
  static ProductsCubit get(context) => BlocProvider.of(context);
  Connectivity connectivity = Connectivity();

  List<GetProductModel> searchList = [];

  List<GetProductModel> myProductList = [];

  String? img64;
  List<GetProductModel> productList = [];
  bool isAllowed = false;
  bool testLoading = false;
  bool unAuthProblem = false;
  bool myVehiclesLoading = false;
  int page = 1;
  String searchValue = '';

  resetPage() {
    page = 1;
  }

  changePage(int pag) {
    page = pag;
  }

  getPage() {
    if (productList.length == 10) {
      page++;
      emit(AddPage());
    } else {
      page = 1;
      emit(AddPage());
    }
  }

  setSearchVal(String value) {
    searchValue = value;
  }

  getProduct({self, val, page}) {
    emit(AddProductLoading());
    myVehiclesLoading = true;
    print('%%%%%%%%%%%%% $page');
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        ProductRepo.getProducts('products', self, val: val, page: page)
            .then((value) => {
                  myVehiclesLoading = false,
                  print('..................................'),
                  print(value),
                  if (self == 1)
                    {
                      myProductList = value,
                      myVehiclesLoading = false,
                      emit(GetProductsSuccess(value)),
                      print('Get My Product Response'),
                      print(myProductList.length),
                    }
                  else
                    {
                      productList = value,
                      emit(GetProductsSuccess(value)),
                      print('Get My Product Response'),
                      print(productList.length),
                    }
                })
            .onError((error, stackTrace) => {
                  myVehiclesLoading = true,
                  emit(GetProductsFailed(error.toString())),
                  print(error)
                });
      }
    });
  }

  searchProducts(GetProductModel productModel) {
    emit(AddProductLoading());

    searchList.clear();
    print("cubit search product");

    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        ProductRepo.searchProduct('products', 0, productModel: productModel)
            .then((value) => {
                  print('..................................'),
                  print(value),
                  print("value2"),
                  if (value.isNotEmpty)
                    {
                      print("value"),
                      print('..................................'),
                      print(value),
                      searchList = value,
                      emit(GetSearchSuccess(searchList)),
                    }
                  else
                    {
                      emit(GetSearchFailed('Nothing found try again')),
                      showToast(msg: 'success', state: ToastedStates.SUCCESS)
                    }
                })
            .onError((error, stackTrace) => {
                  emit(GetSearchFailed(error.toString())),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print(error)
                });
      }
    });
  }

  addProductCubit({context, GetProductModel? productModel}) async {
    print(
        '###################################################### ${productModel!.toJson()}');

    emit(AddProductLoading());
    String fileName = image != null ? image!.path.split('/').last : '';

    FormData formData = FormData.fromMap({
      "product_image": image != null
          ? await MultipartFile.fromFile(image!.path, filename: fileName)
          : '',
      "buy_or_sell": productModel.buyOrSell,
      "product_name": productModel.productName,
      "product_type": productModel.productTypeId,
      "country": productModel.countryPost,
      "city": productModel.cityPost,
      "state": productModel.statePost,
      "price": productModel.priceInt,
      "description": productModel.description
    });
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api()
        .postHttp(url: "products/add", authToken: token, data: formData)
        .then((value) => {
              print('Add Product Success'),
              print(value),
              emit(AddSuccess()),
              priceController.clear(),
              descController.clear(),
              nameController.clear(),
              img64 = '',
              image = null,
              showToast(msg: 'Add Success', state: ToastedStates.SUCCESS),
            })
        .catchError((error) {
      emit(AddFailed());
      if (error.toString().contains('Unauthorized Access') ||
          error.toString().contains('no credit left')) {}
      print('Add Product Failed');
      print(error);
      showToast(msg: error.toString(), state: ToastedStates.ERROR);
    });
  }

  pickFromGallery(BuildContext context) async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    var img2 = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(
      img!.path,
    );
    image1 = File(
      img2!.path,
    );

    print(image
        .toString()
        .split('/data/user/0/com.example.hoga_load/cache/image_picker'));
    final bytes = image!.readAsBytesSync();
    img64 = "data:image/png;base64," + base64Encode(bytes);
    emit(ImageGallery());
    print('img64' + img64!);
  }

  addProductCubitTest({context}) {
    testLoading = true;
    isAllowed = false;
    emit(CheckAddProductLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.ERROR);
      } else {
        ProductRepo.addProductTest(context: context)
            .then((value) => {
                  print('then'),
                  testLoading = false,
                  print(value['record']['subscription_details']
                      ['total_products_remain']),
                  if (value['record']['subscription_details']
                              ['total_products_remain'] ==
                          null ||
                      value['record']['subscription_details']
                              ['total_products_remain'] ==
                          0)
                    {
                      isAllowed = false,
                      emit(AddTestSuccess()),
                    }
                  else
                    {
                      print("addVehicleCubitTest"),
                      isAllowed = true,
                      emit(AddTestSuccess()),
                    }
                })
            .catchError((error) => {
                  if (error.toString().contains('401')) {unAuthProblem = true},
                  print('erorr >>>>>>>>$error'),
                  print(error),
                  isAllowed = false,
                  testLoading = false,
                  emit(AddTestFailed(error.toString())),
                  print('Add Vehicle Test Failed'),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                });
      }
    });
  }

  editProductCubit(GetProductModel? productModel) async {
    print(
        '###################################################### ${productModel!.toJson()}');
    print('###################################################### ${image}');

    String fileName = image != null ? image!.path.split('/').last : '';
    FormData formData;
    image != null
        ? formData = FormData.fromMap({
            "product_image":
                await MultipartFile.fromFile(image!.path, filename: fileName),
            "buy_or_sell": productModel.buyOrSell,
            "product_name": productModel.productName,
            "product_type": productModel.productTypeId,
            "country": productModel.countryPost,
            "city": productModel.cityPost,
            "state": productModel.statePost,
            "price": productModel.priceInt,
            "description": productModel.description,
            "id": productModel.id
          })
        : formData = FormData.fromMap({
            "buy_or_sell": productModel.buyOrSell,
            "product_name": productModel.productName,
            "product_type": productModel.productTypeId,
            "country": productModel.countryPost,
            "city": productModel.cityPost,
            "state": productModel.statePost,
            "price": productModel.priceInt,
            "id": productModel.id,
            "description": productModel.description
          });
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api()
        .postHttp(url: "products/update", authToken: token, data: formData)
        .then((value) => {
              print('Edit Vehicle Success'),
              print(value),
              emit(EditSuccess()),
              showToast(msg: 'Edit Success', state: ToastedStates.SUCCESS),
              priceController.clear(),
              descController.clear(),
              nameController.clear(),
              img64 = '',
              image = null,
            })
        .catchError((error, stackTrace) => {
              emit(EditFailed()),
              print(error),
              showToast(msg: error.toString(), state: ToastedStates.ERROR),
              print('Edit Vehicle Failed'),
            });
  }

  deleteProductCubit(productId) {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        ProductRepo.delete(productId)
            .then((value) => {
                  print('Delete Vehicle Success'),
                  print(value),
                  emit(DeleteSuccess()),
                  showToast(
                      msg: 'Delete Success', state: ToastedStates.SUCCESS),
                })
            .catchError((error, stackTrace) => {
                  emit(DeleteFailed()),
                  print(error),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print('Delete Vehicle Failed'),
                });
      }
    });
  }
}
