import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/core/data/models/vehicle/vehicles.dart';
import 'package:hoga_load/core/data/repository/vehicle_repo.dart';
import 'package:hoga_load/features/vehicles/get_vehicles/cubit/vehicle_cubit.dart';
import '../../../core/data/models/loads/GetLoads_model.dart';
import '../../../core/data/repository/load_repo.dart';
import '../../../core/dialoges/toast.dart';
import 'getLoad_states.dart';

class LoadsCubit extends Cubit<AddLoadStates> {
  LoadsCubit() : super(AddLoadLoading());
  TextEditingController weightController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  static LoadsCubit get(context) => BlocProvider.of(context);
  Connectivity connectivity = Connectivity();

  List<Vehicles> searchList = [];
  List<Vehicles> loadList = [];
  List<Vehicles> myloadList = [];

//  List equipmentType = [];
//  List attributes = [];
//  List vehcleType = [];
//  List vehcleSize = [];

  bool isAllowed = false;
  bool testLoading = false;
  bool unAuthProblem = false;
  bool myVehiclesLoading = true;

  int page = 1;
  getPage() {
    if (loadList.length == 10) {
      page++;
      emit(AddPage());
    } else {
      page = 1;
      emit(AddPage());
    }
  }

  String searchValue = '';

  resetPage() {
    page = 1;
  }

  changePage(int pag) {
    page = pag;
  }

  setSearchVal(String value) {
    searchValue = value;
  }

  getLoad(
      {self,
      val,
      pag,
      equipmentSize2,
      attributes2,
      vehicleSize2,
      vehicleType2,
      isFilter=false,
      context}) {
    myVehiclesLoading = true;
    emit(AddLoadLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        print('^^^^^^^^^^^^^^^^^^^^$page');
        print('^^^^^^^^^^^^^^^^^^^^$self');

        LoadsRepo.getLoads(self,
                page: page,
                val: val,
                context: context,
                isFilter: isFilter,
                vehicleSize: vehicleSize2,
                vehicleType: vehicleType2,
                attributes: attributes2,
                equipmentSize: equipmentSize2)
            .then((value) => {
                  myVehiclesLoading = false,
                  print('value'),
                  if (self == 1)
                    {
                      print('load self'),

                      myloadList = value,
                      print(myloadList.length),

                      //myVehicleLoadList=value,
                      emit(GetLoadsSuccess(value)),

                      print('Get Vehice Response'),
                      print('**********************'),
                      print(myloadList.length),
                    }
                  else
                    {
                      loadList = value,
                      print('**********************'),
                      print('loadList.length'),
                      print(loadList.length),
                      emit(GetLoadsSuccess(value)),
                     // VehiclesCubit.get(context).vehicleClearData(context),

                      if (isFilter = true)
                        {
                         // VehiclesCubit.get(context).vehicleClearData(context),

                          // showToast(msg: 'Success', state: ToastedStates.SUCCESS)
                        }
                    },
                })
            .onError((error, stackTrace) => {
                  myVehiclesLoading = true,

                  emit(GetLoadsFailed(error.toString())),
                  print(error),
                  // vehicleClearData(context),
                });
      }
    });
  }

  deleteLoadsCubit(vehicleId) {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        LoadsRepo.deleteLoads(vehicleId)
            .then((value) => {
                  print('Delete Vehicle Success'),
                  print(value),
                  emit(DeleteSuccess()),
                  showToast(
                      msg: 'Delete Success', state: ToastedStates.SUCCESS),
                })
            .catchError((error) => {
                  emit(DeleteFailed()),
                  print(error),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print('Delete Vehicle Failed'),
                });
      }
    });
  }

  editLoadsCubit({context, vehicleId}) {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        LoadsRepo.editLoads(context: context, vehicleId: vehicleId)
            .then((value) => {
                  print('Edit  Success'),
                  print(value),
                  emit(EditSuccess()),
                  showToast(msg: 'Edit Success', state: ToastedStates.SUCCESS),
                })
            .catchError((error, stackTrace) => {
                  emit(EditFailed()),
                  print(error),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print('Edit  Failed'),
                });
      }
    });
  }



  addLoadCubitTest({context}) {
    testLoading = true;
    isAllowed=false;
    emit(CheckAddLoadLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.ERROR);
      } else {
        LoadsRepo.addLoadsTest(context: context)
            .then((value) => {
          print('then'),
          testLoading = false,
          print(value['record']['subscription_details']['total_loads_remain']),
          if(value['record']['subscription_details']['total_loads_remain']==null||
              value['record']['subscription_details']['total_loads_remain']==0){
            isAllowed=false,
            emit(AddTestSuccess()),

          }else{
            print("addVehicleCubitTest"),
            isAllowed=true,
            emit(AddTestSuccess()),

          }

        })
            .catchError((error) => {
          if(error.toString().contains('401')){
            unAuthProblem=true
          },
          print('erorr >>>>>>>>$error'),
          print(error),
          isAllowed=false,
          testLoading = false,
          emit(AddTestFailed(error.toString())),
          print('Add Vehicle Test Failed'),
          showToast(msg: error.toString(), state: ToastedStates.ERROR),

        });

      }
    });
  }


  addLoadsCubit({context}) {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: "Check your internet connection and try again",
            state: ToastedStates.ERROR);
      } else {
        print('((((((((((((');
        emit(AddingLoad());
        LoadsRepo.addLoads(context: context)
            .then((value) => {
                  print('Add Load Success'),
                  print(value),
                  emit(AddSuccess()),
                  //VehiclesCubit.get(context).vehicleClearData(context),

                  showToast(msg: 'Add Success', state: ToastedStates.SUCCESS),
                })
            .catchError((error) => {
                  emit(AddFailed()),
                  // VehiclesCubit.get(context).vehicleClearData(context),

                  print('Add Load Failed'),
                  print(error),
                });
      }
    });
  }

  searchLoads(context,
      {val, equipmentSize2, attributes2, vehicleSize2, vehicleType2}) {
    emit(AddLoadLoading());
    searchList.clear();
    print("cubit");
    print(equipmentSize2);
    print(vehicleSize2);

    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        LoadsRepo.searchLoads(
                search: val,
                equipmentSize: equipmentSize2,
                vehicleSize: vehicleSize2,
                attributes: attributes2,
                vehicleType: vehicleType2,
                context: context)
            .then((value) => {
                  print('..................................'),
                  print(value),
                  print("value2"),
                  if (value.isNotEmpty)
                    {
                      print("value"),
                      print('...................####...............'),
                      print(value),
                      searchList = value,
                      emit(GetSearchSuccess(searchList)),
                      VehiclesCubit.get(context).vehicleClearData(context),
                    }
                  else
                    {
                      emit(GetSearchFailed('Nothing found try again')),
                      VehiclesCubit.get(context).vehicleClearData(context),
                    }
                })
            .onError((error, stackTrace) => {
                  emit(GetSearchFailed(error.toString())),
                  VehiclesCubit.get(context).vehicleClearData(context),
                  print(error)
                });
      }
    });
  }
}
