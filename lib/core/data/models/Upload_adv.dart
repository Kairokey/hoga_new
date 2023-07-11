import 'Packages_detail.dart';
import 'User.dart';

class UploadAdv {
  UploadAdv({
      this.advertisement, 
      this.user,});

  UploadAdv.fromJson(dynamic json) {
    advertisement = json['advertisement'] != null ? PackagesDetail.fromJson(json['advertisement']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  PackagesDetail? advertisement;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (advertisement != null) {
      map['advertisement'] = advertisement!.toJson();
    }
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }

}