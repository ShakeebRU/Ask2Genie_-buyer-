import 'query_model.dart';

class ActiveQueryResponseModel {
  bool? status;
  List<QueryModel>? list;

  ActiveQueryResponseModel({this.status, this.list});

  ActiveQueryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['list'] != null) {
      list = <QueryModel>[];
      json['list'].forEach((v) {
        list!.add(QueryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
