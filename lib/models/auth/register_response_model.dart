class RegisterResponseModel {
  bool? status;
  String? returnId;
  String? returnMessage;

  RegisterResponseModel({this.status, this.returnId, this.returnMessage});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    returnId = json['returnId'];
    returnMessage = json['returnMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['returnId'] = returnId;
    data['returnMessage'] = returnMessage;
    return data;
  }
}