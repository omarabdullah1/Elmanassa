///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ParentAddStudentsModel {
/*
{
  "status": 200,
  "message": "Student has been added successfully",
  "errorNum": "S000"
}
*/

  int? status;
  String? message;
  String? errorNum;

  ParentAddStudentsModel({
    this.status,
    this.message,
    this.errorNum,
  });
  ParentAddStudentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    message = json['message']?.toString();
    errorNum = json['errorNum']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['errorNum'] = errorNum;
    return data;
  }
}
