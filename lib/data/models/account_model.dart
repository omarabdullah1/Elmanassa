class AccountModelUserTokenData {
/*
{
  "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xL2FwaS9hdXRoL2FkbWluL2xvZ2luIiwiaWF0IjoxNjk2NTEyNTAxLCJleHAiOjE2OTY1MTYxMDEsIm5iZiI6MTY5NjUxMjUwMSwianRpIjoiM1ZYZHJ4RUZVbGJQTnJqOCIsInN1YiI6IjEiLCJwcnYiOiJkZjg4M2RiOTdiZDA1ZWY4ZmY4NTA4MmQ2ODZjNDVlODMyZTU5M2E5In0.aEqHiA62uPs43FaCfRyvDisfhXuUZW03wJ3-RVSZekA",
  "token_type": "bearer",
  "expires_in": 0
}
*/

  String? accessToken;
  String? tokenType;
  int? expiresIn;

  AccountModelUserTokenData({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });
  AccountModelUserTokenData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token']?.toString();
    tokenType = json['token_type']?.toString();
    expiresIn = json['expires_in']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    return data;
  }
}

class AccountModelUser {
/*
{
  "id": 1,
  "first_name": "Omar",
  "last_name": "Abdo",
  "email": "admin.omar@gmail.com",
  "image": null,
  "token_data": {
    "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xL2FwaS9hdXRoL2FkbWluL2xvZ2luIiwiaWF0IjoxNjk2NTEyNTAxLCJleHAiOjE2OTY1MTYxMDEsIm5iZiI6MTY5NjUxMjUwMSwianRpIjoiM1ZYZHJ4RUZVbGJQTnJqOCIsInN1YiI6IjEiLCJwcnYiOiJkZjg4M2RiOTdiZDA1ZWY4ZmY4NTA4MmQ2ODZjNDVlODMyZTU5M2E5In0.aEqHiA62uPs43FaCfRyvDisfhXuUZW03wJ3-RVSZekA",
    "token_type": "bearer",
    "expires_in": 0
  }
}
*/

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  AccountModelUserTokenData? tokenData;

  AccountModelUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.tokenData,
  });
  AccountModelUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    email = json['email']?.toString();
    image = json['image']?.toString();
    tokenData = (json['token_data'] != null) ? AccountModelUserTokenData.fromJson(json['token_data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['image'] = image;
    if (tokenData != null) {
      data['token_data'] = tokenData!.toJson();
    }
    return data;
  }
}

class AccountModel {
/*
{
  "status": 200,
  "errorNum": "S000",
  "message": "Logged successfully",
  "user": {
    "id": 1,
    "first_name": "Omar",
    "last_name": "Abdo",
    "email": "admin.omar@gmail.com",
    "image": null,
    "token_data": {
      "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xL2FwaS9hdXRoL2FkbWluL2xvZ2luIiwiaWF0IjoxNjk2NTEyNTAxLCJleHAiOjE2OTY1MTYxMDEsIm5iZiI6MTY5NjUxMjUwMSwianRpIjoiM1ZYZHJ4RUZVbGJQTnJqOCIsInN1YiI6IjEiLCJwcnYiOiJkZjg4M2RiOTdiZDA1ZWY4ZmY4NTA4MmQ2ODZjNDVlODMyZTU5M2E5In0.aEqHiA62uPs43FaCfRyvDisfhXuUZW03wJ3-RVSZekA",
      "token_type": "bearer",
      "expires_in": 0
    }
  }
}
*/

  int? status;
  String? errorNum;
  String? message;
  AccountModelUser? user;

  AccountModel({
    this.status,
    this.errorNum,
    this.message,
    this.user,
  });
  AccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    errorNum = json['errorNum']?.toString();
    message = json['message']?.toString();
    user = (json['user'] != null) ? AccountModelUser.fromJson(json['user']) : null;
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
