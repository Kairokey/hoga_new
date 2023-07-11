import 'BillingDetails.dart';
import 'UserDetails.dart';
import 'card_model.dart';

class Card {
  Card({
      this.cardDetails, 
      this.billingDetails, 
      this.userDetails,});

  Card.fromJson(dynamic json) {
    cardDetails = json['card_details'] != null ? CardModel.fromJson(json['card_details']) : null;
    billingDetails = json['billing_details'] != null ? BillingDetails.fromJson(json['billing_details']) : null;
   // userDetails = json['user_details'] != null ? UserDetails.fromJson(json['user_details']) : null;
  }
  CardModel? cardDetails;
  BillingDetails? billingDetails;
  UserDetails? userDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cardDetails != null) {
      map['card_details'] = cardDetails!.toJson();
    }
    if (billingDetails != null) {
      map['billing_details'] = billingDetails!.toJson();
    }
    if (userDetails != null) {
      map['user_details'] = userDetails!.toJson();
    }
    return map;
  }

}