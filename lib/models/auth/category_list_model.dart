class CategoryResponseModel {
  bool? status;
  List<CategoryListdata>? listdata;

  CategoryResponseModel({this.status, this.listdata});

  CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['listdata'] != null) {
      listdata = <CategoryListdata>[];
      json['listdata'].forEach((v) {
        listdata!.add(CategoryListdata.fromJson(v));
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

class CategoryListdata {
  int? categoryID;
  String? categoryName;
  String? urduArabicName;
  String? remarks;
  String? status;

  CategoryListdata(
      {this.categoryID,
      this.categoryName,
      this.urduArabicName,
      this.remarks,
      this.status});

  CategoryListdata.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    urduArabicName = json['urduArabicName'];
    remarks = json['remarks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryID'] = categoryID;
    data['categoryName'] = categoryName;
    data['urduArabicName'] = urduArabicName;
    data['remarks'] = remarks;
    data['status'] = status;
    return data;
  }
}