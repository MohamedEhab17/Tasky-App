class UserModel {
  UserModel({this.name, this.email, this.password, this.uid, this.phoneNumber});
  String? name;
  String? email;
  String? password;
  String? uid;
  String? phoneNumber;

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
  }
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'password': password,
    'phoneNumber': phoneNumber,
  };
}
