class FireBaseInfoModel {
  bool? status;
  List<FireBaseInfoModelList>? list;

  FireBaseInfoModel({this.status, this.list});

  FireBaseInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['list'] != null) {
      list = <FireBaseInfoModelList>[];
      json['list'].forEach((v) {
        list!.add(FireBaseInfoModelList.fromJson(v));
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

class FireBaseInfoModelList {
  int? computerNo;
  int? sellerID;
  String? deviceID;
  String? deviceType;
  String? firebaseID;

  FireBaseInfoModelList(
      {this.computerNo,
      this.sellerID,
      this.deviceID,
      this.deviceType,
      this.firebaseID});

  FireBaseInfoModelList.fromJson(Map<String, dynamic> json) {
    computerNo = json['computerNo'];
    sellerID = json['sellerID'];
    deviceID = json['deviceID'];
    deviceType = json['deviceType'];
    firebaseID = json['firebaseID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['computerNo'] = computerNo;
    data['sellerID'] = sellerID;
    data['deviceID'] = deviceID;
    data['deviceType'] = deviceType;
    data['firebaseID'] = firebaseID;
    return data;
  }
}