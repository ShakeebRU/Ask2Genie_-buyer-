class LoginResponse {
  bool? status;
  bool? userstatus;
  String? message;

  LoginResponse({this.status, this.userstatus, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userstatus = json['userstatus'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['status'] = status;
    data['userstatus'] = userstatus;
    data['message'] = message;
    return data;
  }
}
