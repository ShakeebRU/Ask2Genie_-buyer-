class ColorModel {
  bool? status;
  List<ColorListdata>? listdata;

  ColorModel({this.status, this.listdata});

  ColorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['listdata'] != null) {
      listdata = <ColorListdata>[];
      json['listdata'].forEach((v) {
        listdata!.add(ColorListdata.fromJson(v));
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

class ColorListdata {
  int? colorID;
  String? colorName;
  String? urduArabicName;
  String? hexcode;
  String? status;

  ColorListdata(
      {this.colorID,
      this.colorName,
      this.urduArabicName,
      this.hexcode,
      this.status});

  ColorListdata.fromJson(Map<String, dynamic> json) {
    colorID = json['colorID'];
    colorName = json['colorName'];
    urduArabicName = json['urduArabicName'];
    hexcode = json['hexcode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['colorID'] = colorID;
    data['colorName'] = colorName;
    data['urduArabicName'] = urduArabicName;
    data['hexcode'] = hexcode;
    data['status'] = status;
    return data;
  }
}