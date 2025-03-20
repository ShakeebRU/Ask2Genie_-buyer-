class CoditionModel {
  bool? status;
  List<String>? listdata;

  CoditionModel({this.status, this.listdata});

  CoditionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    listdata = json['listdata'] != null  ? json['listdata'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['listdata'] = listdata;
    return data;
  }
}