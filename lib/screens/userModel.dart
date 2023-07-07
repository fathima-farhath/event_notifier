class UserModel {
  String name;
  String email;
  String phoneNumber;
  String gender;
  String dept;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.uid,
    required this.gender,
    required this.dept,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        uid: map['uid'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        dept: map['dept'] ?? '',
        gender: map['gender'] ?? '');
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "dept": dept,
      "gender": gender,
      "uid": uid,
      "phoneNumber": phoneNumber,
    };
  }
}
