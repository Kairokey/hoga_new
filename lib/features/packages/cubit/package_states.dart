

import 'package:hoga_load/core/data/models/Packages.dart';

import '../../../core/data/models/Packages_detail.dart';
import '../../../core/data/models/Upload_adv.dart';

abstract class PackageStates{}

class PackageLoading extends PackageStates{}
class PackageSubscribeSuccess extends PackageStates{}
class PackageSubscribeFailed extends PackageStates{}
class PackageSubscribeLoading extends PackageStates{}
class ImageGalleryDesktop extends PackageStates{}
class ImageGalleryMobile extends PackageStates{}

class PackageTestLoading extends PackageStates{}
class PackageTestSuccess extends PackageStates{}
class PackageTestFailed extends PackageStates{}


class GetPackageSuccess extends PackageStates{

  List<Packages>attributesList=[];
  GetPackageSuccess(this.attributesList);
}

class GetPackageFailed extends PackageStates{

  final String msg;
  GetPackageFailed(this.msg);
}

class PackageSuccess extends PackageStates{

  List<PackagesDetail>attributesList=[];
  PackageSuccess(this.attributesList);
}

class PackageFailed extends PackageStates{

  final String msg;
  PackageFailed(this.msg);
}
class GetPackageLoading extends PackageStates{

}
class UploadPackageSuccess extends PackageStates{
  UploadPackageSuccess();
}

class UploadPackageFailed extends PackageStates{

  final String msg;
  UploadPackageFailed(this.msg);
}
class UploadPackageLoading extends PackageStates{

}

class NetworkFailed extends PackageStates{

  final String msg;
  NetworkFailed(this.msg);
}