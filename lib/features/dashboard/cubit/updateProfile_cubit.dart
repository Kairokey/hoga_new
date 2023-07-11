import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/api/api.dart';
import '../../../core/data/local/cacheHelper.dart';
import '../../../core/data/models/subscribtion/Subscribtion_model.dart';
import '../../../core/data/models/vehicle/user.dart';
import '../../../core/data/repository/vehicle_repo.dart';
import '../../../core/dialoges/toast.dart';
import '../../../core/keys/keys.dart';
import '../../../core/master_cubit/getDataForm_state.dart';
import 'UpdateProfile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  UpdateProfileCubit() : super(UpdateProfileLoading());

  static UpdateProfileCubit get(context) => BlocProvider.of(context);
  Connectivity connectivity = Connectivity();
  List<User>? profileList = [];
  User profileData = User();
  User profileData2 = User();
 bool notLogged=false;
  bool loading=false;
  bool unSubscribe=false;

  SubscriptionModel subscriptionData = SubscriptionModel();
  updateProfile(updateProfileModel,) async {
    var token = await CacheHelper.getString(SharedKeys.token);
    var response = Api().postHttp(
        url: 'profile/update',
        data: updateProfileModel.toJson(),
        authToken: token);
    emit(UpdateLoading());
    print(response);
    response
        .then((value) => {
      print(value),
      profileData2 = User.fromJson(value['record']),
      emit(UpdateProfileSuccess(User.fromJson(value['record']))),
      showToast(
          msg: 'update Profile successfully',
          state: ToastedStates.SUCCESS),
    })
        .onError((error, stackTrace) => {
      emit(UpdateProfileFailed()),
      print(error),
    });
  }

  getUserProfileData()  async {

    loading=true;
    emit(GetUserProfileLoading());

    var token = await CacheHelper.getString(SharedKeys.token);
    var response = Api().getHttp(
      url: 'profile',
      authToken: token,
    );

    print(response);
  await  response
        .then((value) => {
      print('getUserProfileDataSuccess'),
      print(value),
      profileData = User.fromJson(value['record']),

    loading=false,
        emit(GetUserProfileSuccess(User.fromJson(value['record']))),
      profileData = User.fromJson(value['record']),
    })
        .onError((error, stackTrace) => {
      loading=false,

      if(error.toString().contains('401')){
        notLogged=true,
      },

        emit(GetUserProfileFailed(error.toString())),
      print('getUserProfileDataFailed'),
      showToast(
          msg: error.toString(), state: ToastedStates.ERROR),
      print(error),
    });
  }


  getSubscriptionData() {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(FailedNetwork("Check your internet connection and try again"));
      } else {
        emit(GetSubscriptionLoading());
        var token = await CacheHelper.getString(SharedKeys.token);

        var response = Api().getHttp(
          url: 'profile/current-subscription',
          authToken: token,
        );
        response
            .then((value) => {
          print('subscriptionData'),
          print(value),
          if(value['record']['subscription_details']['subscription_id']==null){
            unSubscribe=true,
            emit(UnSubscribe()),
          }else{
            unSubscribe=false,

            subscriptionData = SubscriptionModel.fromJson(value['record']),
            emit(GetSubscriptionSuccess(SubscriptionModel.fromJson(value))),
          }

        })
            .catchError((error) =>
        {

          if(error.toString().contains('401')){
            notLogged=true,
          },
          emit(GetSubscriptionFailed(error.toString())),

          showToast(
              msg: error.toString(), state: ToastedStates.ERROR),
          print(error)});

      }
    });
  }

  cancelSubscriptionCubit() {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(FailedNetwork("Check your internet connection and try again"));
      } else {
        emit(CancelLoading());
        VehicleRepo.cancel()
            .then((value) => {
          print('Cancel Success'),
          print(value),
          emit(CancelSuccess()),
          showToast(
              msg: 'Cancel Success', state: ToastedStates.SUCCESS),
        })
            .catchError((error, stackTrace) => {
          emit(CancelFailed()),
          print(error),
          showToast(msg: error.toString(), state: ToastedStates.ERROR),
          print('Cancel  Failed'),
        });
      }
    });
  }
}