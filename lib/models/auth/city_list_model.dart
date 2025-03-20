class CityListModel {
  bool? status;
  List<CityModel>? listdata;

  CityListModel({this.status, this.listdata});

  CityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['listdata'] != null) {
      listdata = <CityModel>[];
      json['listdata'].forEach((v) {
        listdata!.add(CityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (listdata != null) {
      data['listdata'] = listdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityModel {
  int? cityID;
  String? cityName;
  String? cityCode;
  String? urduArabicName;
  int? countryID;
  String? countryName;

  CityModel(
      {this.cityID,
      this.cityName,
      this.cityCode,
      this.urduArabicName,
      this.countryID,
      this.countryName});

  CityModel.fromJson(Map<String, dynamic> json) {
    cityID = json['cityID'];
    cityName = json['cityName'];
    cityCode = json['cityCode'];
    urduArabicName = json['urduArabicName'];
    countryID = json['countryID'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityID'] = cityID;
    data['cityName'] = cityName;
    data['cityCode'] = cityCode;
    data['urduArabicName'] = urduArabicName;
    data['countryID'] = countryID;
    data['countryName'] = countryName;
    return data;
  }
}
