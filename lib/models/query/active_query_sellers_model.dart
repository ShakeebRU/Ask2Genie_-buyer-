class ActiveQuerySellerListModel {
  bool? status;
  List<ActiveQuerySellerListModelList>? list;

  ActiveQuerySellerListModel({this.status, this.list});

  ActiveQuerySellerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['list'] != null) {
      list = <ActiveQuerySellerListModelList>[];
      json['list'].forEach((v) {
        list!.add(ActiveQuerySellerListModelList.fromJson(v));
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

class ActiveQuerySellerListModelList {
  int? queryID;
  String? queryDateTime;
  int? buyerID;
  int? categoryID;
  int? subCategoryID;
  String? requirementsDetail;
  String? brandModel;
  String? makeYear;
  String? condition;
  int? colorID;
  String? status;
  String? queryDateTimeString;
  String? categoryName;
  String? subCategoryName;
  String? colorName;
  String? buyerName;
  int? qsComputerNo;
  int? sellerID;
  String? sellerName;
  String? sellerReplyDateTime;
  String? available;
  double? rate;
  String? sellerRemarks;
  String? sellerFirebaseToken;
  String? sellerDeviceToken;
  String? sellerImageURL;
  String? qsStatus;
  String? sellerReplyDateTimeString;
  int? chatID;
  String? chatDateTime;
  String? chatType;
  String? messageType;
  String? message;
  String? messageStatus;
  String? chatDateTimeString;
  String? docURL;
  String? imagesURLList;
  String? sellerList;

  ActiveQuerySellerListModelList(
      {this.queryID,
      this.queryDateTime,
      this.buyerID,
      this.categoryID,
      this.subCategoryID,
      this.requirementsDetail,
      this.brandModel,
      this.makeYear,
      this.condition,
      this.colorID,
      this.status,
      this.queryDateTimeString,
      this.sellerDeviceToken,
      this.sellerFirebaseToken,
      this.categoryName,
      this.subCategoryName,
      this.colorName,
      this.buyerName,
      this.qsComputerNo,
      this.sellerID,
      this.sellerName,
      this.sellerReplyDateTime,
      this.available,
      this.rate,
      this.sellerRemarks,
      this.qsStatus,
      this.sellerReplyDateTimeString,
      this.chatID,
      this.chatDateTime,
      this.chatType,
      this.messageType,
      this.message,
      this.messageStatus,
      this.chatDateTimeString,
      this.sellerImageURL,
      this.docURL,
      this.imagesURLList,
      this.sellerList});

  ActiveQuerySellerListModelList.fromJson(Map<String, dynamic> json) {
    queryID = json['queryID'];
    queryDateTime = json['queryDateTime'];
    buyerID = json['buyerID'];
    categoryID = json['categoryID'];
    subCategoryID = json['subCategoryID'];
    requirementsDetail = json['requirementsDetail'];
    brandModel = json['brandModel'];
    makeYear = json['makeYear'];
    condition = json['condition'];
    sellerFirebaseToken = json['sellerFirebaseToken'];
    sellerDeviceToken = json['sellerDeviceToken'];
    colorID = json['colorID'];
    status = json['status'];
    queryDateTimeString = json['queryDateTimeString'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    colorName = json['colorName'];
    buyerName = json['buyerName'];
    qsComputerNo = json['qsComputerNo'];
    sellerID = json['sellerID'];
    sellerName = json['sellerName'];
    sellerReplyDateTime = json['sellerReplyDateTime'];
    available = json['available'];
    rate = json['rate'];
    sellerRemarks = json['sellerRemarks'];
    qsStatus = json['qsStatus'];
    sellerReplyDateTimeString = json['sellerReplyDateTimeString'];
    chatID = json['chatID'];
    chatDateTime = json['chatDateTime'];
    chatType = json['chatType'];
    messageType = json['messageType'];
    message = json['message'];
    messageStatus = json['messageStatus'];
    chatDateTimeString = json['chatDateTimeString'];
    sellerImageURL = json['sellerImageURL'];
    docURL = json['docURL'];
    imagesURLList = json['imagesURLList'];
    sellerList = json['sellerList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['queryID'] = queryID;
    data['queryDateTime'] = queryDateTime;
    data['buyerID'] = buyerID;
    data['categoryID'] = categoryID;
    data['sellerDeviceToken'] = sellerDeviceToken;
    data['subCategoryID'] = subCategoryID;
    data['requirementsDetail'] = requirementsDetail;
    data['brandModel'] = brandModel;
    data['makeYear'] = makeYear;
    data['sellerFirebaseToken'] = sellerFirebaseToken;
    data['condition'] = condition;
    data['colorID'] = colorID;
    data['status'] = status;
    data['queryDateTimeString'] = queryDateTimeString;
    data['categoryName'] = categoryName;
    data['subCategoryName'] = subCategoryName;
    data['colorName'] = colorName;
    data['buyerName'] = buyerName;
    data['qsComputerNo'] = qsComputerNo;
    data['sellerID'] = sellerID;
    data['sellerName'] = sellerName;
    data['sellerReplyDateTime'] = sellerReplyDateTime;
    data['available'] = available;
    data['rate'] = rate;
    data['sellerRemarks'] = sellerRemarks;
    data['qsStatus'] = qsStatus;
    data['sellerReplyDateTimeString'] = sellerReplyDateTimeString;
    data['chatID'] = chatID;
    data['chatDateTime'] = chatDateTime;
    data['chatType'] = chatType;
    data['messageType'] = messageType;
    data['message'] = message;
    data['messageStatus'] = messageStatus;
    data['chatDateTimeString'] = chatDateTimeString;
    data['sellerImageURL'] = sellerImageURL;
    data['docURL'] = docURL;
    data['imagesURLList'] = imagesURLList;
    data['sellerList'] = sellerList;
    return data;
  }
}
