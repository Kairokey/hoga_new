import 'package:hoga_load/core/data/models/master/Country.dart';

import 'State.dart';
import 'City.dart';

class BillingDetails {
  BillingDetails({
      this.addressLine1, 
      this.addressLine2, 
      this.state, 
      this.city, 
      this.country, 
      this.postalCode, 
      this.name, 
      this.email, 
      this.lastUpdated,});

  BillingDetails.fromJson(dynamic json) {
    addressLine1 = json['address_line_1'].toString();
   // addressLine2 = json['address_line_2'].toString();
    //state = json['state'] != null ? State.fromJson(json['state']) : null;
   // city = json['city'] != null ? City.fromJson(json['city']) : null;
    //country = json['country'];
    postalCode = json['postal_code'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
   // lastUpdated = json['last_updated'];
  }
  String? addressLine1;
  String? addressLine2;
  State? state;
  City? city;
  Country? country;
  String? postalCode;
  String? name;
  String? email;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    if (state != null) {
      map['state'] = state!.toJson();
    }
    if (city != null) {
      map['city'] = city!.toJson();
    }
    map['country'] = country;
    map['postal_code'] = postalCode;
    map['name'] = name;
    map['email'] = email;
    map['last_updated'] = lastUpdated;
    return map;
  }

}