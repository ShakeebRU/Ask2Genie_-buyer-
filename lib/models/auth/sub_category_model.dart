class SubCategoryModel {
  bool? status;
  List<SubCatListdata>? listdata;

  SubCategoryModel({this.status, this.listdata});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['listdata'] != null) {
      listdata = <SubCatListdata>[];
      json['listdata'].forEach((v) {
        listdata!.add(SubCatListdata.fromJson(v));
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

class SubCatListdata {
  int? subCategoryID;
  String? subCategoryName;
  int? categoryID;
  String? categoryName;
  String? urduArabicName;
  String? remarks;
  String? status;

  SubCatListdata(
      {this.subCategoryID,
      this.subCategoryName,
      this.categoryID,
      this.categoryName,
      this.urduArabicName,
      this.remarks,
      this.status});

  SubCatListdata.fromJson(Map<String, dynamic> json) {
    subCategoryID = json['subCategoryID'];
    subCategoryName = json['subCategoryName'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    urduArabicName = json['urduArabicName'];
    remarks = json['remarks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subCategoryID'] = subCategoryID;
    data['subCategoryName'] = subCategoryName;
    data['categoryID'] = categoryID;
    data['categoryName'] = categoryName;
    data['urduArabicName'] = urduArabicName;
    data['remarks'] = remarks;
    data['status'] = status;
    return data;
  }
}