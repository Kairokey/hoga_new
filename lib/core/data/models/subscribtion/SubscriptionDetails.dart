class SubscriptionDetails {
  SubscriptionDetails({
      this.subscriptionId, 
      this.stripeId, 
      this.subscriptionTakenOn, 
      this.subscriptionValidTill, 
      this.totalLoadsAllowed, 
      this.totalLoadsRemain, 
      this.totalVehiclesAllowed, 
      this.totalVehiclesRemain, 
      this.totalProductsAllowed, 
      this.totalProductsRemain, 
      this.totalJobsAllowed, 
      this.totalJobsRemain, 
      this.subscriptionCancelled,});

  SubscriptionDetails.fromJson(dynamic json) {
    subscriptionId = json['subscription_id'];
    stripeId = json['stripe_id'];
    subscriptionTakenOn = json['subscription_taken_on'];
    subscriptionValidTill = json['subscription_valid_till'];
    totalLoadsAllowed = json['total_loads_allowed'];
    totalLoadsRemain = json['total_loads_remain'];
    totalVehiclesAllowed = json['total_vehicles_allowed'];
    totalVehiclesRemain = json['total_vehicles_remain'];
    totalProductsAllowed = json['total_products_allowed'];
    totalProductsRemain = json['total_products_remain'];
    totalJobsAllowed = json['total_jobs_allowed'];
    totalJobsRemain = json['total_jobs_remain'];
    subscriptionCancelled = json['subscription_cancelled'];
  }
  int? subscriptionId;
  String? stripeId;
  String? subscriptionTakenOn;
  String? subscriptionValidTill;
  int? totalLoadsAllowed;
  int? totalLoadsRemain;
  int? totalVehiclesAllowed;
  int? totalVehiclesRemain;
  int? totalProductsAllowed;
  int? totalProductsRemain;
  int? totalJobsAllowed;
  int? totalJobsRemain;
  int? subscriptionCancelled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subscription_id'] = subscriptionId;
    map['stripe_id'] = stripeId;
    map['subscription_taken_on'] = subscriptionTakenOn;
    map['subscription_valid_till'] = subscriptionValidTill;
    map['total_loads_allowed'] = totalLoadsAllowed;
    map['total_loads_remain'] = totalLoadsRemain;
    map['total_vehicles_allowed'] = totalVehiclesAllowed;
    map['total_vehicles_remain'] = totalVehiclesRemain;
    map['total_products_allowed'] = totalProductsAllowed;
    map['total_products_remain'] = totalProductsRemain;
    map['total_jobs_allowed'] = totalJobsAllowed;
    map['total_jobs_remain'] = totalJobsRemain;
    map['subscription_cancelled'] = subscriptionCancelled;
    return map;
  }

}