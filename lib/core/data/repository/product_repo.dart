import 'package:hoga_load/core/data/models/jobs/GetJop_model.dart';

import '../../keys/keys.dart';
import '../api/api.dart';
import '../local/cacheHelper.dart';
import '../models/jobs/get_jop.dart';
import '../models/product/GetProduct_model.dart';

class ProductRepo {
  static Future<List<GetProductModel>> getProducts(url, self,
      {GetProductModel? productModel, val, page}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    print(token);
    var response =
        await Api().getHttp(url: url, authToken: token, self: self, data: {
      "search": val,
      "per_page": 10,
      "page": page,
    });

    List<GetProductModel> productsList = [];
    for (int i = 0; i < response['records'].length; i++) {
      GetProductModel blogModel =
          GetProductModel.fromJson(response['records'][i]);
      productsList.add(blogModel);
    }
    return productsList;
  }

  static Future<List<GetProductModel>> searchProduct(url, self,
      {GetProductModel? productModel}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    var response = await Api().getHttp(
        url: url, authToken: token, self: self, data: productModel!.toJson());

    List<GetProductModel> productsList = [];
    for (int i = 0; i < response['records'].length; i++) {
      GetProductModel blogModel =
          GetProductModel.fromJson(response['records'][i]);
      productsList.add(blogModel);
    }
    return productsList;
  }

  static addProduct({context, GetProductModel? productModel}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api().postHttp(
        url: "products/add", authToken: token, data: productModel!.toJson());
  }

  static addProductTest({context}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api()
        .getHttp(url: "profile/current-subscription", authToken: token);
  }

  static delete(productId) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api().getHttp(
        url: "products/delete", authToken: token, data: {"id": productId});
  }

  static editVehicle(GetProductModel? productModel) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api().postHttp(
        url: "products/update", authToken: token, data: productModel!.toJson());
  }
}
