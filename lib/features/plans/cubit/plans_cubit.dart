import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/core/data/repository/plans_repo.dart';
import '../../../core/data/api/api.dart';
import '../../../core/data/local/cacheHelper.dart';
import '../../../core/data/models/plans/plans_model.dart';
import '../../../core/dialoges/toast.dart';
import '../../../core/keys/keys.dart';
import 'plans_states.dart';

class PlansCubit extends Cubit<PlansStates> {
  PlansCubit() : super(PlansLoading());

  static PlansCubit get(context) => BlocProvider.of(context);
  Connectivity connectivity = Connectivity();
  List<PlansModel> plansList = [];
  bool isFreeTrial = true;
  getPlansCubit() {
    emit(PlansLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        PlansRepo.getPlans(isFreeTrial)
            .then((value) => {
                  print('..................................'),
                  plansList = value,
                  print("this value--------Plans"),
                  print(value),
                  emit(GetPlansSuccess(value)),
                })
            .onError((error, stackTrace) =>
                {emit(GetPlansFailed(error.toString())), print(error)});
      }
    });
  }

  checkPlansCubit() async {
    print('kkkkkkkkkkkkkkkkkkkkkkkkk');

    var token = await CacheHelper.getString(SharedKeys.token);

    emit(PlansLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        var response = await Api()
            .getHttp(url: 'profile/current-subscription', authToken: token);
        print(response);
        print('==============================');
      }
    });
  }

  subscribePlan(id) {
    emit(SubscribeLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        PlansRepo.subscribePlan(id)
            .then((value) => {
                  print('..................................'),
                  print("this value--------SUBSCRIBEPlans"),
                  print(value),
                  emit(SubscribeSuccess()),
                  showToast(msg: 'Done', state: ToastedStates.SUCCESS),
                })
            .catchError((error, stackTrace) => {
                  emit(SubscribeFailed()),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print(error)
                });
      }
    });
  }
}
