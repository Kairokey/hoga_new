import 'User.dart';

class PackagesDetail {
  PackagesDetail({
      this.id, 
      this.desktopBanner, 
      this.mobileBanner, 
      this.link, 
      this.user, 
      this.startDate, 
      this.endDate,});

  PackagesDetail.fromJson(dynamic json) {
    id = json['id'];
    desktopBanner = json['desktop_banner'];
    mobileBanner = json['mobile_banner'];
    link = json['link'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
  int? id;
  String? desktopBanner;
  String? mobileBanner;
  String? link;
  User? user;
  String? startDate;
  String? endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['desktop_banner'] = desktopBanner;
    map['mobile_banner'] = mobileBanner;
    map['link'] = link;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    return map;
  }

}