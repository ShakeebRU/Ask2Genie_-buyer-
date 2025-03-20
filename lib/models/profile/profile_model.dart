class ProfileResponseModel {
  bool? status;
  ProfileListData? list;

  ProfileResponseModel({this.status, this.list});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    list = json['list'] != null
        ? ProfileListData.fromJson(json['list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (list != null) {
      data['list'] = list!.toJson();
    }
    return data;
  }
}

class ProfileListData {
  int? sellerID;
  String? email;
  String? password;
  String? name;
  String? phoneNo;
  String? mobileNo;
  String? shopName;
  String? description;
  String? address;
  String? longitude;
  String? latitude;
  int? cityID;
  String? status;
  List<CategoryList>? categoryList;
  String? cityName;
  String? imageURL;

  ProfileListData(
      {this.sellerID,
      this.email,
      this.password,
      this.name,
      this.phoneNo,
      this.mobileNo,
      this.shopName,
      this.description,
      this.address,
      this.longitude,
      this.latitude,
      this.cityID,
      this.status,
      this.categoryList,
      this.cityName,
      this.imageURL});

  ProfileListData.fromJson(Map<String, dynamic> json) {
    sellerID = json['sellerID'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    mobileNo = json['mobileNo'];
    shopName = json['shopName'];
    description = json['description'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    cityID = json['cityID'];
    status = json['status'];
    if (json['categoryList'] != null) {
      categoryList = <CategoryList>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
    cityName = json['cityName'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sellerID'] = sellerID;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['phoneNo'] = phoneNo;
    data['mobileNo'] = mobileNo;
    data['shopName'] = shopName;
    data['description'] = description;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['cityID'] = cityID;
    data['status'] = status;
    if (categoryList != null) {
      data['categoryList'] = categoryList!.map((v) => v.toJson()).toList();
    }
    data['cityName'] = cityName;
    data['imageURL'] = imageURL;
    return data;
  }
}

class CategoryList {
  int? computerNo;
  String? sellerID;
  int? categoryID;
  String? categoryName;

  CategoryList(
      {this.computerNo, this.sellerID, this.categoryID, this.categoryName});

  CategoryList.fromJson(Map<String, dynamic> json) {
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