///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class SupportModelSupportInfo {
/*
{
  "key": "phone",
  "value": "+201023096929"
}
*/

  String? key;
  String? value;

  SupportModelSupportInfo({
    this.key,
    this.value,
  });
  SupportModelSupportInfo.fromJson(Map<String, dynamic> json) {
    key = json['key']?.toString();
    value = json['value']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class SupportModel {
/*
{
  "status": 200,
  "errorNum": "S000",
  "message": "Support Info. have been returned successfully",
  "supportInfo": [
    {
      "key": "phone",
      "value": "+201023096929"
    }
  ]
}
*/

  int? status;
  String? errorNum;
  String? message;
  List<SupportModelSupportInfo?>? supportInfo;

  SupportModel({
    this.status,
    this.errorNum,
    this.message,
    this.supportInfo,
  });
  SupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    errorNum = json['errorNum']?.toString();
    message = json['message']?.toString();
    if (json['supportInfo'] != null) {
      final v = json['supportInfo'];
      final arr0 = <SupportModelSupportInfo>[];
      v.forEach((v) {
        arr0.add(SupportModelSupportInfo.fromJson(v));
      });
      supportInfo = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['errorNum'] = errorNum;
    data['message'] = message;
    if (supportInfo != null) {
      final v = supportInfo;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['supportInfo'] = arr0;
    }
    return data;
  }
}
