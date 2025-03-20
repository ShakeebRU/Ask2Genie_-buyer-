class QueryModel {
  QueryModel({
    required this.queryID,
    required this.queryDateTime,
    required this.buyerID,
    required this.categoryID,
    required this.subCategoryID,
    required this.requirementsDetail,
    required this.brandModel,
    required this.makeYear,
    required this.condition,
    required this.colorID,
    required this.status,
    required this.qty,
    required this.conditionNew,
    required this.conditionUsed,
    required this.alternateProduct,
    required this.dueDateTime,
    required this.dueDateTimeString,
    required this.productName,
    required this.productDescription,
    required this.queryDateTimeString,
    required this.categoryName,
    required this.subCategoryName,
    required this.colorName,
    required this.buyerName,
    required this.qsComputerNo,
    required this.sellerID,
    required this.sellerName,
    required this.sellerReplyDateTime,
    required this.available,
    required this.rate,
    required this.sellerRemarks,
    required this.qsStatus,
    required this.sellerReplyDateTimeString,
    required this.itemCondition,
    required this.availableBrand,
    required this.availableQty,
    required this.validUptoDate,
    required this.validUptoDateString,
    required this.newDone,
    required this.usedDone,
    required this.alternateDone,
    required this.buyerFirebase,
    required this.buyerDeviceToken,
    required this.docURL,
    required this.buyerImageURL,
    required this.imagesURLList,
    required this.sellerList,
  });
  late final dynamic queryID;
  late final String queryDateTime;
  late final dynamic buyerID;
  late final dynamic categoryID;
  late final dynamic subCategoryID;
  late final String requirementsDetail;
  late final String brandModel;
  late final String makeYear;
  late final String condition;
  late final dynamic colorID;
  late final String status;
  late final dynamic qty;
  late final dynamic conditionNew;
  late final dynamic conditionUsed;
  late final dynamic alternateProduct;
  late final String dueDateTime;
  late final String dueDateTimeString;
  late final String productName;
  late final String productDescription;
  late final String queryDateTimeString;
  late final String categoryName;
  late final String subCategoryName;
  late final String colorName;
  late final String buyerName;
  late final dynamic qsComputerNo;
  late final dynamic sellerID;
  late final String sellerName;
  late final String sellerReplyDateTime;
  late final String available;
  late final dynamic rate;
  late final String sellerRemarks;
  late final String qsStatus;
  late final String sellerReplyDateTimeString;
  late final String itemCondition;
  late final String availableBrand;
  late final dynamic availableQty;
  late final String validUptoDate;
  late final String validUptoDateString;
  late final dynamic newDone;
  late final dynamic usedDone;
  late final dynamic alternateDone;
  late final String buyerFirebase;
  late final String buyerDeviceToken;
  late final String docURL;
  late final String buyerImageURL;
  late final List<ImagesURLList> imagesURLList;
  late final List<SellerList> sellerList;

  QueryModel.fromJson(Map<String, dynamic> json) {
    queryID = json['queryID'];
    queryDateTime = json['queryDateTime'];
    buyerID = json['buyerID'];
    categoryID = json['categoryID'];
    subCategoryID = json['subCategoryID'];
    requirementsDetail = json['requirementsDetail'];
    brandModel = json['brandModel'];
    makeYear = json['makeYear'];
    condition = json['condition'];
    colorID = json['colorID'];
    status = json['status'];
    qty = json['qty'];
    conditionNew = json['conditionNew'];
    conditionUsed = json['conditionUsed'];
    alternateProduct = json['alternateProduct'];
    dueDateTime = json['dueDateTime'];
    dueDateTimeString = json['dueDateTimeString'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    queryDateTimeString = json['queryDateTimeString'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    colorName = json['colorName'];
    buyerName = json['buyerName'] ?? "";
    qsComputerNo = json['qsComputerNo'];
    sellerID = json['sellerID'];
    sellerName = json['sellerName'] ?? "";
    sellerReplyDateTime = json['sellerReplyDateTime'] ?? "";
    available = json['available'] ?? "";
    rate = json['rate'];
    sellerRemarks = json['sellerRemarks'] ?? "";
    qsStatus = json['qsStatus'] ?? "";
    sellerReplyDateTimeString = json['sellerReplyDateTimeString'] ?? "";
    itemCondition = json['itemCondition'] ?? "";
    availableBrand = json['availableBrand'] ?? "";
    availableQty = json['availableQty'];
    validUptoDate = json['validUptoDate'] ?? "";
    validUptoDateString = json['validUptoDateString'] ?? "";
    newDone = json['newDone'];
    usedDone = json['usedDone'];
    alternateDone = json['alternateDone'];
    buyerFirebase = json['buyerFirebase'] ?? "";
    buyerDeviceToken = json['buyerDeviceToken'] ?? "";
    docURL = json['docURL'] ?? "";
    buyerImageURL = json['buyerImageURL'] ?? "";
    imagesURLList = json['imagesURLList'] ?? [];
    sellerList = json['sellerList'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['queryID'] = queryID;
    _data['queryDateTime'] = queryDateTime;
    _data['buyerID'] = buyerID;
    _data['categoryID'] = categoryID;
    _data['subCategoryID'] = subCategoryID;
    _data['requirementsDetail'] = requirementsDetail;
    _data['brandModel'] = brandModel;
    _data['makeYear'] = makeYear;
    _data['condition'] = condition;
    _data['colorID'] = colorID;
    _data['status'] = status;
    _data['qty'] = qty;
    _data['conditionNew'] = conditionNew;
    _data['conditionUsed'] = conditionUsed;
    _data['alternateProduct'] = alternateProduct;
    _data['dueDateTime'] = dueDateTime;
    _data['dueDateTimeString'] = dueDateTimeString;
    _data['productName'] = productName;
    _data['productDescription'] = productDescription;
    _data['queryDateTimeString'] = queryDateTimeString;
    _data['categoryName'] = categoryName;
    _data['subCategoryName'] = subCategoryName;
    _data['colorName'] = colorName;
    _data['buyerName'] = buyerName;
    _data['qsComputerNo'] = qsComputerNo;
    _data['sellerID'] = sellerID;
    _data['sellerName'] = sellerName;
    _data['sellerReplyDateTime'] = sellerReplyDateTime;
    _data['available'] = available;
    _data['rate'] = rate;
    _data['sellerRemarks'] = sellerRemarks;
    _data['qsStatus'] = qsStatus;
    _data['sellerReplyDateTimeString'] = sellerReplyDateTimeString;
    _data['itemCondition'] = itemCondition;
    _data['availableBrand'] = availableBrand;
    _data['availableQty'] = availableQty;
    _data['validUptoDate'] = validUptoDate;
    _data['validUptoDateString'] = validUptoDateString;
    _data['newDone'] = newDone;
    _data['usedDone'] = usedDone;
    _data['alternateDone'] = alternateDone;
    _data['buyerFirebase'] = buyerFirebase;
    _data['buyerDeviceToken'] = buyerDeviceToken;
    _data['docURL'] = docURL;
    _data['buyerImageURL'] = buyerImageURL;
    _data['imagesURLList'] = imagesURLList;
    _data['sellerList'] = sellerList;
    return _data;
  }
}

class ImagesURLList {
  dynamic queryImageID;
  dynamic queryID;
  String? imageURL;

  ImagesURLList({this.queryImageID, this.queryID, this.imageURL});

  ImagesURLList.fromJson(Map<String, dynamic> json) {
    queryImageID = json['queryImageID'];
    queryID = json['queryID'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['queryImageID'] = queryImageID;
    data['queryID'] = queryID;
    data['imageURL'] = imageURL;
    return data;
  }
}

class SellerList {
  dynamic qsComputerNo;
  dynamic queryID;
  dynamic sellerID;
  String? sellerReplyDateTime;
  String? available;
  dynamic rate;
  String? sellerRemarks;
  String? qsStatus;
  String? sellerName;
  String? sellerReplyDateTimeString;
  List<SellerImagesURLList>? imagesURLList;

  SellerList(
      {this.qsComputerNo,
      this.queryID,
      this.sellerID,
      this.sellerReplyDateTime,
      this.available,
      this.rate,
      this.sellerRemarks,
      this.qsStatus,
      this.sellerName,
      this.sellerReplyDateTimeString,
      this.imagesURLList});

  SellerList.fromJson(Map<String, dynamic> json) {
    qsComputerNo = json['qsComputerNo'];
    queryID = json['queryID'];
    sellerID = json['sellerID'];
    sellerReplyDateTime = json['sellerReplyDateTime'];
    available = json['available'];
    rate = json['rate'];
    sellerRemarks = json['sellerRemarks'];
    qsStatus = json['qsStatus'];
    sellerName = json['sellerName'];
    sellerReplyDateTimeString = json['sellerReplyDateTimeString'];
    if (json['imagesURLList'] != null) {
      imagesURLList = <SellerImagesURLList>[];
      json['imagesURLList'].forEach((v) {
        imagesURLList!.add(SellerImagesURLList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qsComputerNo'] = qsComputerNo;
    data['queryID'] = queryID;
    data['sellerID'] = sellerID;
    data['sellerReplyDateTime'] = sellerReplyDateTime;
    data['available'] = available;
    data['rate'] = rate;
    data['sellerRemarks'] = sellerRemarks;
    data['qsStatus'] = qsStatus;
    data['sellerName'] = sellerName;
    data['sellerReplyDateTimeString'] = sellerReplyDateTimeString;
    if (imagesURLList != null) {
      data['imagesURLList'] = imagesURLList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellerImagesURLList {
  dynamic chatID;
  dynamic qsComputerNo;
  String? chatDateTime;
  String? chatType;
  String? messageType;
  String? message;
  String? messageStatus;
  String? chatDateTimeString;

  SellerImagesURLList(
      {this.chatID,
      this.qsComputerNo,
      this.chatDateTime,
      this.chatType,
      this.messageType,
      this.message,
      this.messageStatus,
      this.chatDateTimeString});

  SellerImagesURLList.fromJson(Map<String, dynamic> json) {
    chatID = json['chatID'];
    qsComputerNo = json['qsComputerNo'];
    chatDateTime = json['chatDateTime'];
    chatType = json['chatType'];
    messageType = json['messageType'];
    message = json['message'];
    messageStatus = json['messageStatus'];
    chatDateTimeString = json['chatDateTimeString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatID'] = chatID;
    data['qsComputerNo'] = qsComputerNo;
    data['chatDateTime'] = chatDateTime;
    data['chatType'] = chatType;
    data['messageType'] = messageType;
    data['message'] = message;
    data['messageStatus'] = messageStatus;
    data['chatDateTimeString'] = chatDateTimeString;
    return data;
  }
}
