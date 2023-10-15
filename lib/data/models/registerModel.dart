class RegisterModelUser {
/*
{
  "first_name": "sdf",
  "last_name": "sdf",
  "email": "aaaa@gmail.com",
  "password": "123456789",
  "phone": "01146127749",
  "level_id": "1",
  "updated_at": "2023-10-11T12:30:05.000000Z",
  "created_at": "2023-10-11T12:30:05.000000Z",
  "id": 4
} 
*/

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? levelId;
  String? updatedAt;
  String? createdAt;
  int? id;

  RegisterModelUser({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.levelId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });
  RegisterModelUser.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    email = json['email']?.toString();
    password = json['password']?.toString();
    phone = json['phone']?.toString();
    levelId = json['level_id']?.toString();
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
    id = json['id']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['level_id'] = levelId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

class RegisterModel {
/*
{
  "status": 200,
  "errorNum": "S000",
  "message": "Registered Successfully",
  "user": {
    "first_name": "sdf",
    "last_name": "sdf",
    "email": "aaaa@gmail.com",
    "password": "123456789",
    "phone": "01146127749",
    "level_id": "1",
    "updated_at": "2023-10-11T12:30:05.000000Z",
    "created_at": "2023-10-11T12:30:05.000000Z",
    "id": 4
  }
} 
*/

  int? status;
  String? errorNum;
  String? message;
  RegisterModelUser? user;

  RegisterModel({
    this.status,
    this.errorNum,
    this.message,
    this.user,
  });
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    errorNum = json['errorNum']?.toString();
    message = json['message']?.toString();
    user = (json['user'] != null) ? RegisterModelUser.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['errorNum'] = errorNum;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
