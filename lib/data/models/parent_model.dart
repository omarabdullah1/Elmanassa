///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ParentModelUserDataUser {
/*
{
  "id": 56,
  "first_name": "omar",
  "last_name": "parent",
  "email": "omar@parent1.test",
  "role": "user",
  "phone": "01023096929",
  "gender": "male",
  "image": "null",
  "code": "null",
  "level_id": "null",
  "level_title": "null"
}
*/

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? phone;
  String? gender;
  String? image;
  String? code;
  String? levelId;
  String? levelTitle;

  ParentModelUserDataUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.phone,
    this.gender,
    this.image,
    this.code,
    this.levelId,
    this.levelTitle,
  });
  ParentModelUserDataUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    email = json['email']?.toString();
    role = json['role']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    image = json['image']?.toString();
    code = json['code']?.toString();
    levelId = json['level_id']?.toString();
    levelTitle = json['level_title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['role'] = role;
    data['phone'] = phone;
    data['gender'] = gender;
    data['image'] = image;
    data['code'] = code;
    data['level_id'] = levelId;
    data['level_title'] = levelTitle;
    return data;
  }
}

class ParentModelUserData {
/*
{
  "user": {
    "id": 56,
    "first_name": "omar",
    "last_name": "parent",
    "email": "omar@parent1.test",
    "role": "user",
    "phone": "01023096929",
    "gender": "male",
    "image": "null",
    "code": "null",
    "level_id": "null",
    "level_title": "null"
  },
  "token": "19|7i3HjxCVY4Wwvg9rrPx40TmqjRKXhpJ9hmUURm4G8678bbbd"
}
*/

  ParentModelUserDataUser? user;
  String? token;

  ParentModelUserData({
    this.user,
    this.token,
  });
  ParentModelUserData.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null) ? ParentModelUserDataUser.fromJson(json['user']) : null;
    token = json['token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class ParentModel {
/*
{
  "status": 200,
  "errorNum": "S000",
  "message": "Loged successfuly",
  "user_data": {
    "user": {
      "id": 56,
      "first_name": "omar",
      "last_name": "parent",
      "email": "omar@parent1.test",
      "role": "user",
      "phone": "01023096929",
      "gender": "male",
      "image": "null",
      "code": "null",
      "level_id": "null",
      "level_title": "null"
    },
    "token": "19|7i3HjxCVY4Wwvg9rrPx40TmqjRKXhpJ9hmUURm4G8678bbbd"
  }
}
*/

  int? status;
  String? errorNum;
  String? message;
  ParentModelUserData? userData;

  ParentModel({
    this.status,
    this.errorNum,
    this.message,
    this.userData,
  });
  ParentModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    errorNum = json['errorNum']?.toString();
    message = json['message']?.toString();
    userData = (json['user_data'] != null) ? ParentModelUserData.fromJson(json['user_data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['errorNum'] = errorNum;
    data['message'] = message;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    return data;
  }
}
