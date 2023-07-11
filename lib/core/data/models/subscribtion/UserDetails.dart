class UserDetails {
  UserDetails({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.username, 
      this.contactNumber, 
      this.profilePicture,});

  UserDetails.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    contactNumber = json['contact_number'];
    profilePicture = json['profile_picture'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? contactNumber;
  String? profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['username'] = username;
    map['contact_number'] = contactNumber;
    map['profile_picture'] = profilePicture;
    return map;
  }

}