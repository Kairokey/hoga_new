import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoga_load/core/data/models/Packages.dart';
import 'package:hoga_load/core/data/repository/package_repo.dart';
import 'package:hoga_load/features/packages/cubit/package_states.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data/models/Packages_detail.dart';
import '../../../core/data/repository/plans_repo.dart';
import '../../../core/dialoges/toast.dart';

class PackageCubit extends Cubit<PackageStates> {
  PackageCubit() : super(PackageLoading());

  static PackageCubit get(context) => BlocProvider.of(context);

  bool isAllowed = false;
  bool testLoading = false;
  bool unAuthProblem = false;
  bool packageLoading = false;

  Connectivity connectivity = Connectivity();
  List<Packages> packageList = [];
  List<PackagesDetail> getPackageList = [];
  List<PackagesDetail> uploadPackageList = [];
  TextEditingController linkController = TextEditingController();

  String? fromdate;
  String? todate;

  DateTime? fromdate2;
  var imageDesktop;
  var imageMobile;
  int selectedPackage = 0;
  changeSelectedPackage(int index) {
    print(index);
    selectedPackage = index;
    emit(GetPackageSuccess(packageList));
  }

  getPackageCubit() {
    packageLoading = true;
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        PackageRepo.getPackage()
            .then((value) => {
                  print('..................................'),
                  print(value),
                  packageList = value,
                  packageLoading = false,
                  emit(GetPackageSuccess(value))
                })
            .onError((error, stackTrace) => {
                  emit(GetPackageFailed(error.toString())),
                  packageLoading = false,
                  print(error)
                });
      }
    });
  }

  advertisementCubit() {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        emit(GetPackageLoading());
        PackageRepo.advertisement()
            .then((value) => {
                  print('..................................'),
                  print(value),
                  getPackageList = value,
                  emit(PackageSuccess(value))
                })
            .onError((error, stackTrace) =>
                {emit(PackageFailed(error.toString())), print(error)});
      }
    });
  }

  subscribePackage(id, context, {firstDate, endDate}) {
    emit(PackageSubscribeLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        PlansRepo.subscribePackage(id, context,
                fistDate: firstDate, endDate: endDate)
            .then((value) => {
                  print('..................................'),
                  print("this value--------Plans"),
                  print(value),
                  emit(PackageSubscribeSuccess()),
                  showToast(msg: 'Done', state: ToastedStates.SUCCESS),
                })
            .catchError((error) => {
                  emit(PackageSubscribeFailed()),
                  print("this value--------Plans Failed"),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print(error)
                });
      }
    });
  }

  uploadPackageCubit(context) {
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
      } else {
        emit(UploadPackageLoading());
        String fileName =
            imageMobile != null ? imageMobile!.path.split('/').last : '';
        String fileName2 =
            imageDesktop != null ? imageDesktop!.path.split('/').last : '';

        FormData formData = FormData.fromMap({
          "desktop_banner": imageDesktop != null
              ? await MultipartFile.fromFile(imageDesktop!.path,
                  filename: fileName2)
              : '',
          "mobile_banner": imageMobile != null
              ? await MultipartFile.fromFile(imageMobile!.path,
                  filename: fileName)
              : '',
          "link": linkController.text
        });
        PackageRepo.uploadPackage(formData)
            .then((value) => {
                  print('..................................'),
                  print(value),
                  emit(UploadPackageSuccess()),
                  showToast(
                      msg: 'Upload Success', state: ToastedStates.SUCCESS),
                  print('Upload Success'),
                  imageDesktop == null,
                  imageMobile == null,
                  linkController.clear(),
                })
            .catchError((error) => {
                  emit(UploadPackageFailed(error.toString())),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                  print(error)
                });
      }
    });
  }

  SubscribePackageTest({context}) {
    testLoading = true;
    isAllowed = false;
    emit(PackageTestLoading());
    connectivity.checkConnectivity().then((value) async {
      if (ConnectivityResult.none == value) {
        emit(NetworkFailed("Check your internet connection and try again"));
        showToast(
            msg: 'Check your internet connection and try again',
            state: ToastedStates.ERROR);
      } else {
        PackageRepo.SubscribePackageTest(context: context)
            .then((value) => {
                  print('then'),
                  testLoading = false,
                  print(value['record']['subscription']['can_upload_ad']),
                  if (value['record']['subscription']['can_upload_ad'] ==
                          null ||
                      value['record']['subscription']['can_upload_ad'] == 'no')
                    {
                      isAllowed = false,
                      emit(PackageTestSuccess()),
                    }
                  else
                    {
                      print("addPACKAGECubitTest"),
                      isAllowed = true,
                      emit(PackageTestSuccess()),
                    }
                })
            .catchError((error) => {
                  if (error.toString().contains('401')) {unAuthProblem = true},
                  print('erorr >>>>>>>>$error'),
                  print(error),
                  isAllowed = false,
                  testLoading = false,
                  emit(PackageTestFailed()),
                  print('Add PACKAGE Test Failed'),
                  showToast(msg: error.toString(), state: ToastedStates.ERROR),
                });
      }
    });
  }

  pickFromGalleryMobile(BuildContext context) async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageMobile = File(
      img!.path,
    );

    emit(ImageGalleryMobile());
  }

  pickFromGalleryDesktop(BuildContext context) async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageDesktop = File(
      img!.path,
    );

    emit(ImageGalleryDesktop());
  }
}
