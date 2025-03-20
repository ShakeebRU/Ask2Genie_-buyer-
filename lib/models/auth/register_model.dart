class RegisteredModel {
  RegisteredModel({
    required this.status,
    required this.returnId,
    required this.returnMessage,
    required this.verificationcode,
    required this.list,
  });
  late final bool status;
  late final String returnId;
  late final String returnMessage;
  late final String verificationcode;
  late final UserData list;

  RegisteredModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    returnId = json['returnId'];
    returnMessage = json['returnMessage'];
    verificationcode = json['verificationcode'];
    list = UserData.fromJson(json['list']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['returnId'] = returnId;
    _data['returnMessage'] = returnMessage;
    _data['verificationcode'] = verificationcode;
    _data['list'] = list.toJson();
    return _data;
  }
}

class UserData {
  UserData({
    required this.buyerID,
    required this.email,
    this.password,
    required this.name,
    required this.mobileNo,
    required this.description,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.cityID,
    required this.status,
    required this.companyName,
    required this.aboutDetail,
    required this.countryID,
    required this.countryName,
    required this.cityName,
    required this.imageURL,
    required this.categoryList,
  });
  late final int buyerID;
  late final String email;
  late final Null password;
  late final String name;
  late final String mobileNo;
  late final String description;
  late final String address;
  late final String longitude;
  late final String latitude;
  late final int cityID;
  late final String status;
  late final String companyName;
  late final String aboutDetail;
  late final int countryID;
  late final String countryName;
  late final String cityName;
  late final String imageURL;
  late final List<CategoryList> categoryList;

  UserData.fromJson(Map<String, dynamic> json) {
    buyerID = json['buyerID'];
    email = json['email'];
    password = null;
    name = json['name'];
    mobileNo = json['mobileNo'];
    description = json['description'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    cityID = json['cityID'];
    status = json['status'];
    companyName = json['companyName'];
    aboutDetail = json['aboutDetail'];
    countryID = json['countryID'];
    countryName = json['countryName'];
    cityName = json['cityName'];
    imageURL = json['imageURL'];
    categoryList = List.from(json['categoryList'])
        .map((e) => CategoryList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['buyerID'] = buyerID;
    _data['email'] = email;
    _data['password'] = password;
    _data['name'] = name;
    _data['mobileNo'] = mobileNo;
    _data['description'] = description;
    _data['address'] = address;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['cityID'] = cityID;
    _data['status'] = status;
    _data['companyName'] = companyName;
    _data['aboutDetail'] = aboutDetail;
    _data['countryID'] = countryID;
    _data['countryName'] = countryName;
    _data['cityName'] = cityName;
    _data['imageURL'] = imageURL;
    _data['categoryList'] = categoryList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CategoryList {
  CategoryList({
    required this.computerNo,
    this.buyerID,
    required this.categoryID,
    required this.categoryName,
  });
  late final int computerNo;
  late final Null buyerID;
  late final int categoryID;
  late final String categoryName;

  CategoryList.fromJson(Map<String, dynamic> json) {
    computerNo = json['computerNo'];
    buyerID = null;
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['computerNo'] = computerNo;
    _data['buyerID'] = buyerID;
    _data['categoryID'] = categoryID;
    _data['categoryName'] = categoryName;
    return _data;
  }
}
