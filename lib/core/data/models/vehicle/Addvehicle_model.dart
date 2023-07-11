class AddVehicle {
  AddVehicle({
      this.id,
      this.title,});

  AddVehicle.fromJson(dynamic json) {
    id = json['id']==null?0:json['id'];
    title = json['title']??'other';
  }
  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }

}