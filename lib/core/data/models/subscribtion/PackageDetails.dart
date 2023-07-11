class PackageDetails {
  PackageDetails({
      this.id, 
      this.name, 
      this.stripeId, 
      this.stripePriceId, 
      this.description, 
      this.totalLoads, 
      this.totalVehicles, 
      this.totalProducts, 
      this.totalJobs, 
      this.price, 
      this.bestSelling, 
      this.basePrice,});

  PackageDetails.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    stripeId = json['stripe_id'];
    stripePriceId = json['stripe_price_id'];
    description = json['description'];
    totalLoads = json['total_loads'];
    totalVehicles = json['total_vehicles'];
    totalProducts = json['total_products'];
    totalJobs = json['total_jobs'];
    price = json['price'];
    bestSelling = json['best_selling'];
    basePrice = json['base_price'];
  }
  int? id;
  String? name;
  String? stripeId;
  String? stripePriceId;
  dynamic description;
  int? totalLoads;
  int? totalVehicles;
  int? totalProducts;
  int? totalJobs;
  String? price;
  dynamic bestSelling;
  dynamic basePrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['stripe_id'] = stripeId;
    map['stripe_price_id'] = stripePriceId;
    map['description'] = description;
    map['total_loads'] = totalLoads;
    map['total_vehicles'] = totalVehicles;
    map['total_products'] = totalProducts;
    map['total_jobs'] = totalJobs;
    map['price'] = price;
    map['best_selling'] = bestSelling;
    map['base_price'] = basePrice;
    return map;
  }

}