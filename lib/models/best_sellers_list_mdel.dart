class BestSellersListModel {
  BestSellersListModel({
    required this.status,
    required this.list,
  });
  late final bool status;
  late final List<BestSellersModel> list;

  BestSellersListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    list = List.from(json['list'])
        .map((e) => BestSellersModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['list'] = list.map((e) => e.toJson()).toList();
    return _data;
  }
}

class BestSellersModel {
  BestSellersModel({
    required this.sellerID,
    required this.email,
    this.password,
    required this.name,
    required this.phoneNo,
    required this.mobileNo,
    required this.shopName,
    required this.description,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.cityID,
    required this.status,
    required this.categoryList,
    required this.cityName,
    required this.imageURL,
    required this.displaySellerRating,
  });
  late final int sellerID;
  late final String email;
  late final Null password;
  late final String name;
  late final String phoneNo;
  late final String mobileNo;
  late final String shopName;
  late final String description;
  late final String address;
  late final String longitude;
  late final String latitude;
  late final int cityID;
  late final String status;
  late final List<CategoryList> categoryList;
  late final String cityName;
  late final String imageURL;
  late final dynamic displaySellerRating;

  BestSellersModel.fromJson(Map<String, dynamic> json) {
    sellerID = json['sellerID'];
    email = json['email'];
    password = null;
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
    categoryList = List.from(json['categoryList'])
        .map((e) => CategoryList.fromJson(e))
        .toList();
    cityName = json['cityName'];
    imageURL = json['imageURL'];
    displaySellerRating = json['displaySellerRating'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sellerID'] = sellerID;
    _data['email'] = email;
    _data['password'] = password;
    _data['name'] = name;
    _data['phoneNo'] = phoneNo;
    _data['mobileNo'] = mobileNo;
    _data['shopName'] = shopName;
    _data['description'] = description;
    _data['address'] = address;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['cityID'] = cityID;
    _data['status'] = status;
    _data['categoryList'] = categoryList.map((e) => e.toJson()).toList();
    _data['cityName'] = cityName;
    _data['imageURL'] = imageURL;
    _data['displaySellerRating'] = displaySellerRating;
    return _data;
  }
}

class CategoryList {
  CategoryList({
    required this.computerNo,
    this.sellerID,
    required this.categoryID,
    required this.categoryName,
  });
  late final int computerNo;
  late final Null sellerID;
  late final int categoryID;
  late final String categoryName;

  CategoryList.fromJson(Map<String, dynamic> json) {
    computerNo = json['computerNo'];
    sellerID = null;
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['computerNo'] = computerNo;
    _data['sellerID'] = sellerID;
    _data['categoryID'] = categoryID;
    _data['categoryName'] = categoryName;
    return _data;
  }
}
