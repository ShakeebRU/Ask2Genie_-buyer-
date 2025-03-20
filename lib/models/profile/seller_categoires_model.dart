class SellerCategoriesModel {
  bool? status;
  List<SellerCategoriesList>? list;

  SellerCategoriesModel({this.status, this.list});

  SellerCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['list'] != null) {
      list = <SellerCategoriesList>[];
      json['list'].forEach((v) {
        list!.add(SellerCategoriesList.fromJson(v));
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

class SellerCategoriesList {
  int? computerNo;
  String? sellerID;
  int? categoryID;
  String? categoryName;

  SellerCategoriesList({this.computerNo, this.sellerID, this.categoryID, this.categoryName});

  SellerCategoriesList.fromJson(Map<String, dynamic> json) {
    computerNo = json['computerNo'];
    sellerID = json['sellerID'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['computerNo'] = computerNo;
    data['sellerID'] = sellerID;
    data['categoryID'] = categoryID;
    data['categoryName'] = categoryName;
    return data;
  }
}