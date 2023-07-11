import 'SubscriptionDetails.dart';
import 'PackageDetails.dart';
import 'UserDetails.dart';

class SubscriptionModel {
  SubscriptionModel({
      this.subscriptionDetails, 
      this.packageDetails, 
      this.userDetails,});

  SubscriptionModel.fromJson(dynamic json) {
    subscriptionDetails = json['subscription_details'] != null ? SubscriptionDetails.fromJson(json['subscription_details']) : null;
    packageDetails = json['package_details'] != null ? PackageDetails.fromJson(json['package_details']) : null;
    userDetails = json['user_details'] != null ? UserDetails.fromJson(json['user_details']) : null;
  }
  SubscriptionDetails? subscriptionDetails;
  PackageDetails? packageDetails;
  UserDetails? userDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (subscriptionDetails != null) {
      map['subscription_details'] = subscriptionDetails!.toJson();
    }
    if (packageDetails != null) {
      map['package_details'] = packageDetails!.toJson();
    }
    if (userDetails != null) {
      map['user_details'] = userDetails!.toJson();
    }
    return map;
  }

}