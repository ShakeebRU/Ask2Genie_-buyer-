class CountryListModel {
  bool? status;
  List<Listdata>? listdata;

  CountryListModel({this.status, this.listdata});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['listdata'] != null) {
      listdata = <Listdata>[];
      json['listdata'].forEach((v) {
        listdata!.add(Listdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (listdata != null) {
      data['listdata'] = listdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listdata {
  Listdata({
    required this.countryID,
    required this.countryName,
    required this.countryCode,
    required this.urduArabicName,
  });
  late int countryID;
  late String countryName;
  late String countryCode;
  late String urduArabicName;

  Listdata.fromJson(Map<String, dynamic> json) {
    countryID = json['countryID'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    urduArabicName = json['urduArabicName'];
  }

  Map<String, dynamic> toJson() {
    var _data = <String, dynamic>{};
    _data['countryID'] = countryID;
    _data['countryName'] = countryName;
    _data['countryCode'] = countryCode;
    _data['urduArabicName'] = urduArabicName;
    return _data;
  }
}
