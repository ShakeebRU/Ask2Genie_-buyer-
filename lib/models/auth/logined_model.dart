class LoginedModel {
  LoginedModel({
    required this.status,
    required this.userstatus,
    required this.message,
    required this.list,
    required this.verificationcode,
  });
  late final bool status;
  late final bool userstatus;
  late final String message;
  late final String verificationcode;
  late final UserDataLogin list;

  LoginedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userstatus = json['userstatus'];
    message = json['message'];
    verificationcode = json['verificationcode'];
    list = UserDataLogin.fromJson(json['list']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['userstatus'] = userstatus;
    _data['message'] = message;
    _data['verificationcode'] = verificationcode;
    _data['list'] = list.toJson();
    return _data;
  }
}

class UserDataLogin {
  UserDataLogin({
    required this.buyerID,
    required this.email,
    this.password,
    required this.name,
    required this.mobileNo,
    this.description,
    this.address,
    this.longitude,
    this.latitude,
    required this.cityID,
    required this.status,
    required this.companyName,
    required this.aboutDetail,
    required this.countryID,
    required this.countryName,
    required this.cityName,
    required this.imageURL,
    required this.categoryList,
    required this.token,
    required this.expiration,
  });
  late final int buyerID;
  late final String email;
  late final Null password;
  late final String name;
  late final String mobileNo;
  late final Null description;
  late final Null address;
  late final Null longitude;
  late final Null latitude;
  late final int cityID;
  late final String status;
  late final String companyName;
  late final String aboutDetail;
  late final int countryID;
  late final String countryName;
  late final String cityName;
  late final String imageURL;
  late final List<CategoryList> categoryList;
  late final String token;
  late final String expiration;

  UserDataLogin.fromJson(Map<String, dynamic> json) {
    buyerID = json['buyerID'];
    email = json['email'];
    password = null;
    name = json['name'];
    mobileNo = json['mobileNo'];
    description = null;
    address = null;
    longitude = null;
    latitude = null;
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
    token = json['token'];
    expiration = json['expiration'];
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
    _data['token'] = token;
    _data['expiration'] = expiration;
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
