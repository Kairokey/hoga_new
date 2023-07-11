import '../../keys/keys.dart';
import '../api/api.dart';
import '../local/cacheHelper.dart';
import '../models/jobs/GetJop_model.dart';
import '../models/jobs/get_jop.dart';

class JobsRepo {
  static addJopTest({context}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    print('token is >>>>>>>>>>>>>>>>>>>>>>>>>>>>$token');
    return await Api()
        .getHttp(url: "profile/current-subscription", authToken: token);
  }

  static Future<List<GetJop>> getJop(url, self,
      {GetJop? productModel,
      titleController,
      page,
      city2,
      country2,
      state2,
      jopTypeId,
      jopCategortId,
      isFilter}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    print('page is $page');
    var response;
    print(city2);
    print(jopCategortId);
    print(state2);
    print(country2);
    print(jopTypeId);
    print(token);
    print(url);
    print(self);
    if (isFilter) {
      response =
          await Api().getHttp(url: url, authToken: token, self: self, data: {
        "per_page": 10,
        "page": page,
        "city": city2,
        "country": country2,
        "state": state2,
        "job_types": jopTypeId,
        "categories": jopCategortId,
        "search": titleController.text
      });
    } else {
      response = await Api().getHttp(
          url: url,
          authToken: token,
          self: self,
          data: {"per_page": 10, "page": page,"paginate":1});
    }

    List<GetJop> productsList = [];
    if (response != null) {
      for (int i = 0; i < response['records'].length; i++) {
        GetJop blogModel = GetJop.fromJson(response['records'][i]);
        productsList.add(blogModel);
      }
    }

    return productsList;
  }

  static deleteJop(productId) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    print('token is >>>>>>>>>>>>>>>>>>>>>>>>>>>>$token');
    print('Id is >>>>>>>>>>>>>>>>>>>>>>>>>>>>$productId');

    return await Api()
        .getHttp(url: "jobs/delete", authToken: token, data: {"id": productId});
  }

  static Future<List<GetJop>> getJop2(url) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    var response = await Api().getHttp(url: url, authToken: token);

    List<GetJop> productsList = [];
    for (int i = 0; i < response['records'].length; i++) {
      GetJop blogModel = GetJop.fromJson(response['records'][i]);
      productsList.add(blogModel);
    }
    return productsList;
  }

  static editJop(GetJopModel? productModel) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    print('token is >>>>>>>>>>>>>>>>>>>>>>>>>>>>$token');
    print('Id is >>>>>>>>>>>>>>>>>>>>>>>>>>>>${productModel!.id}');
    return await Api().postHttp(
        url: "jobs/update", authToken: token, data: productModel!.toJson());
  }

  static addJop({context, GetJopModel? jopModel}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    return await Api()
        .postHttp(url: "jobs/add", authToken: token, data: jopModel!.toJson());
  }

  static Future<List<GetJopModel>> searchJob(url, self,
      {GetJopModel? productModel}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    var response = await Api()
        .getHttp(url: url, authToken: token, data: productModel!.toJson());

    List<GetJopModel> productsList = [];
    for (int i = 0; i < response['records'].length; i++) {
      GetJopModel blogModel = GetJopModel.fromJson(response['records'][i]);
      productsList.add(blogModel);
    }
    return productsList;
  }
}
