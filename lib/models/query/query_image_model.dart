class QueryMediaModel {
  bool? status;
  List<String>? listimage;
  List<String>? listaudio;
  List<String>? listvideo;

  QueryMediaModel({
    this.status,
    required this.listimage,
    required this.listaudio,
    required this.listvideo,
  });

  QueryMediaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    listimage = List.castFrom<dynamic, String>(json['listimage'] ?? []);
    listaudio = List.castFrom<dynamic, String>(json['listaudio'] ?? []);
    listvideo = List.castFrom<dynamic, String>(json['listvideo'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['listimage'] = listimage;
    data['listaudio'] = listaudio;
    data['listvideo'] = listvideo;
    return data;
  }
}

// class ImageList {
//   int? queryImageID;
//   int? queryID;
//   String? imageURL;

//   ImageList({this.queryImageID, this.queryID, this.imageURL});

//   ImageList.fromJson(Map<String, dynamic> json) {
//     queryImageID = json['queryImageID'];
//     queryID = json['queryID'];
//     imageURL = json['imageURL'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['queryImageID'] = queryImageID;
//     data['queryID'] = queryID;
//     data['imageURL'] = imageURL;
//     return data;
//   }
// }
