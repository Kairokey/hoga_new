import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/core/data/repository/vehicle_repo.dart';
import 'package:hoga_load/core/keys/keys.dart';
import 'package:hoga_load/features/home/view.dart';
import '../../../../core/data/models/vehicle/Addvehicle_model.dart';
import '../../../../core/data/models/vehicle/vehicles.dart';
import '../../../../core/dialoges/toast.dart';
import '../../../../core/master_cubit/getDataForm_cubit.dart';
import '../../../loads/cubit/getLoad_cubit.dart';
import 'vehicle_states.dart';

class VehiclesCubit extends Cubit<VehicleStates> {
  VehiclesCubit() : super(VehicleLoading());

  static VehiclesCubit get(context) => BlocProvider.of(context);
  TextEditingController weightController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  Connectivity connectivity = Connectivity();
  List<AddVehicle> attributesList = [];
  List<AddVehicle> equipmentList = [];
  List<AddVehicle> vehicleSizeList = [];
  List<AddVehicle> vehiclesTypeList = [];
  List<Vehicles> searchList = [];
  List<Vehicles> vehicleList = [];
  List<Vehicles> myVehicleList = [];

  //checkBoxlist
  List equipmentType = [];
  List attributes = [];
  List vehcleType = [];
  List vehcleSize = [];
  bool? value=false;
  var valueType;

  bool isAllowed = false;
  bool testLoading = false;
  bool unAuthProblem = false;

  bool myVehiclesLoading = true;

  getAttributesCubit() {
    attributesList.clear();
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        VehicleRepo.getData('masters/attributes')
            .then((value) => {
                  print('..................................'),
                  print(value),
                  attributesList = value,
          attributesList.add(AddVehicle(title: 'other')),

          emit(GetAttributesSuccess(value)),
                  //  attributesBoxValue=List.filled(attributesList.length, false),
                })
            .onError((error, stackTrace) =>
                {emit(GetAttributesFailed(error.toString())), print(error)});
      }
    });
  }

  getEquipmentsCubit() {
    equipmentList.clear();
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        VehicleRepo.getData('masters/equipment-types')
            .then((value) => {
                  print('..................................'),
                  print(value),
                  equipmentList = value,
          equipmentList.add(AddVehicle(title: 'other')),
                  emit(GetEquipmentSuccess(value)),
                  //equipmentBoxValue=List.filled(equipmentList.length, false),
                })
            .onError((error, stackTrace) =>
                {emit(GetEquipmentFailed(error.toString())), print(error)});
      }
    });
  }

  getVehicleSizesCubit() {
    vehicleSizeList.clear();
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        VehicleRepo.getData('masters/vehicle-sizes')
            .then((value) => {
                  print('..................................'),
                  print(value),
                  vehicleSizeList = value,
          vehicleSizeList.add(AddVehicle(title: 'other')),

          emit(GetVehicleSizeSuccess(value)),
//                   vehcleSizeBoxValue=List.filled(vehicleSizeList.length, false),

                })
            .onError((error, stackTrace) =>
                {emit(GetVehicleSizeFailed(error.toString())), print(error)});
      }
    });
  }

  getVehicleTypesCubit() {
    vehiclesTypeList.clear();
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        VehicleRepo.getData('masters/vehicle-types')
            .then((value) => {
                  print('..................................'),
                  print(value),
                  vehiclesTypeList = value,
          vehiclesTypeList.add(AddVehicle(title: 'other')),
                  emit(GetVehiclesTypeSuccess(value)),
                  //vehcleTypeBoxValue=List.filled(vehiclesTypeList.length, false),
                })
            .onError((error, stackTrace) =>
                {emit(GetVehiclesTypeFailed(error.toString())), print(error)});
      }
    });
  }

  vehicleClearData(context) {
    print('clear vehcle data');
    equipmentType.clear();
    attributes.clear();
    vehcleType.clear();
    vehcleSize.clear();
    weightController.clear();
    instructionsController.clear();
    DataFormCubit.get(context).cityOriginID = '';
    DataFormCubit.get(context).countryOriginID = '';
    DataFormCubit.get(context).countryDestinationID = '';
    DataFormCubit.get(context).stateDestinationID = '';
    DataFormCubit.get(context).stateOriginID = '';
    DataFormCubit.get(context).cityDestinationID = '';
    print('length >>>>>>>>>>>${vehcleSize.length}');
  }

  changeCheckBox(boxKey, index, val) {


    if (boxKey == MasterKeys.vehicleSize.name) {
      print('zzzzzzz ${vehcleSize.length}');
      val
          ? vehcleSize.add(vehicleSizeList[index].id??'other')
          : vehcleSize.remove(vehicleSizeList[index].id??'other');
    }

    if (boxKey == MasterKeys.vehicleTypes.name) {
      val
          ? vehcleType.add(vehiclesTypeList[index].id??'other')
          : vehcleType.remove(vehiclesTypeList[index].id??'other');
    }
    if (boxKey == MasterKeys.attributes.name) {
      val
          ? attributes.add(attributesList[index].id??'other')
          : attributes.remove(attributesList[index].id??'other');
    }
    if (boxKey == MasterKeys.equipmentTypes.name) {
      val
          ? equipmentType.add(equipmentList[index].id??'other')
          : equipmentType.remove(equipmentList[index].id??'other');
    }
    // emit(ChangeBox());

    print('vehcleSize $vehcleSize');
    print('attributes $attributes');
    print("equipmentType $equipmentType");
    print('vehcleType $vehcleType');

    print('+++++++++++++++++++++++++++++++++++');
  }

  int page = 1;
  getPage() {
    if (vehicleList.length == 10) {
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

  getVehicleCubit(
      context,
      {self,
      page,
      val,
      equipmentSize2,
      attributes2,
      vehicleSize2,
      vehicleType2,
      isFilter,
      }) {
    myVehiclesLoading = true;
    emit(VehicleLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        VehicleRepo.getVehicles(
          context,
            self,
                page: page,
                val: val,
                isFilter: isFilter,
                vehicleSize: vehicleSize2,
                vehicleType: vehicleType2,
                attributes: attributes2,
                equipmentSize: equipmentSize2)
            .then((value) => {
                  myVehiclesLoading = false,
                  print(value),
                  print('selffffff >>>> $self'),
                  if (self == 1)
                    {
                      myVehicleList = value,
                      emit(GetVehicleSuccess(value)),
                      print('Get Vehice Response'),
                      print(myVehicleList.length),
                      //vehicleClearData(context)
                    }
                  else
                    {
                      vehicleList = value,
                      print('length >>>> ${vehicleList.length}'),
                      emit(GetVehicleSuccess(value)),
                      //vehicleClearData(context),
                    },
                })
            .onError((error, stackTrace) => {
                  myVehiclesLoading = true,
                  emit(GetVehicleFailed(error.toString())),
                  print(stackTrace),
                  print('erorr >>>>>>>>$error'),
                });
      }
    });
  }

  deleteVehicleCubit(vehicleId) {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        VehicleRepo.deleteVehicle(vehicleId)
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

  editVehicleCubit({context, vehicleId}) {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {

        VehicleRepo.editVehicle(context: context, vehicleId: vehicleId)
            .then((value) => {
                  print('Edit Vehicle Success'),
                  print(value),
                  emit(EditSuccess()),
                 // vehicleClearData(context),
                  showToast(msg: 'Edit Success', state: ToastedStates.SUCCESS),
                })
            .catchError((error, stackTrace) => {
                  emit(EditFailed()),
                  print(error),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print('Edit Vehicle Failed'),
                });
      }
    });
  }

  addVehicleCubitTest({context}) {
    testLoading = true;
    isAllowed=false;
    emit(CheckAddVehicleLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.ERROR);
      } else {
        VehicleRepo.addVehicleTest(context: context)
            .then((value) => {
              print('then'),
          testLoading = false,
          print(value['record']['subscription_details']['total_vehicles_remain']),
             if(value['record']['subscription_details']['total_vehicles_remain']==null||
                 value['record']['subscription_details']['total_vehicles_remain']==0){
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

  addVehicleCubit({context, isLoad}) {
    emit(AddingLoad());

    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: "Check your internet connection and try again",
            state: ToastedStates.ERROR);
      } else {
        VehicleRepo.addVehicle(context: context, isLoad: isLoad)
            .then((value) => {
                  print('Add Vehicle Success'),
                  print(value),
                  emit(AddSuccess()),
                  if (isLoad)
                    LoadsCubit.get(context).getLoad(self: 1, isFilter: false),
                 // vehicleClearData(Home.scaffoldStateKey.currentContext),
          vehicleClearData(context),

          showToast(msg: 'Add Success', state: ToastedStates.SUCCESS),
                })
            .catchError((error, stack) => {
                  emit(AddFailed(error.toString())),
          showToast(msg: error.toString(), state: ToastedStates.ERROR),

         // vehicleClearData(context),
                  print('Add Vehicle Failed'),
                  print(error),
                });
      }
    });
  }


}
