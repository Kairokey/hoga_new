import 'package:hoga_load/core/data/models/plans/plans_model.dart';
import 'package:hoga_load/features/packages/cubit/package_cubit.dart';
import 'package:hoga_load/features/plans/cubit/plans_cubit.dart';
import '../../keys/keys.dart';
import '../api/api.dart';
import '../local/cacheHelper.dart';
import 'package:intl/intl.dart';

class PlansRepo {
  static Future<List<PlansModel>> getPlans(isFreeTrial) async {
    var response = await Api().getHttp(url: 'subscription-plans');

    List<PlansModel> plansList = [];

    for (int i = 0; i < response['records'].length; i++) {
      print('freeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      print('freeeeeeeeeeeeeeeeeeeeeeeeeeeeee11');

      PlansModel plansModel = PlansModel.fromJson(response['records'][i]);
      plansList.add(plansModel);
    }
    print(response.length);
    print(plansList.length);
    return plansList;
  }

  static subscribePlan(id) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    print('id>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$id');
    return await Api().postHttp(
        url: "subscribe/regular-plan", authToken: token, data: {'id': id});
  }

  static subscribePackage(id, context, {fistDate, endDate}) async {
    String token = await CacheHelper.getString(SharedKeys.token);
    print('id>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$id');
    print(fistDate == null);
    print(DateFormat('mm-dd-yyyy').format(DateTime.now()));
    print(PackageCubit.get(context).fromdate2);
    return fistDate == null || endDate == null
        ? await Api().postHttp(
            url: "subscribe/advertisement-plan",
            authToken: token,
            data: {'id': id})
        : await Api().postHttp(
            url: "subscribe/advertisement-plan",
            authToken: token,
            data: {'id': id, 'from_date': fistDate, 'to_date': endDate});
  }
}
