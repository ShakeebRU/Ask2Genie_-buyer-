import 'query_model.dart';

class GetQueryDetailsModel {
  bool? status;
  QueryModel? list;
  List<String>? listimage;
  List<String>? listaudio;
  List<String>? listvideo;

  GetQueryDetailsModel({
    this.status,
    this.list,
    required this.listimage,
    required this.listaudio,
    required this.listvideo,
  });

  GetQueryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    list = json['list'] != null ? QueryModel.fromJson(json['list']) : null;
    listimage = List.castFrom<dynamic, String>(json['listimage'] ?? []);
    listaudio = List.castFrom<dynamic, String>(json['listaudio'] ?? []);
    listvideo = List.castFrom<dynamic, String>(json['listvideo'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (list != null) {
      data['list'] = list!.toJson();
    }
    data['listimage'] = listimage;
    data['listaudio'] = listaudio;
    data['listvideo'] = listvideo;
    return data;
  }
}
