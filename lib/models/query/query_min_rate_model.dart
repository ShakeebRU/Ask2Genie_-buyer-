class QueryMinRateModel {
  QueryMinRateModel({
    required this.status,
    required this.minqscomputerno,
    required this.minrate,
    required this.mindata,
  });
  late final bool status;
  late final dynamic minqscomputerno;
  late final dynamic minrate;
  late final Mindata mindata;

  QueryMinRateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    minqscomputerno = json['minqscomputerno'];
    minrate = json['minrate'];
    mindata = Mindata.fromJson(json['mindata']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['minqscomputerno'] = minqscomputerno;
    _data['minrate'] = minrate;
    _data['mindata'] = mindata.toJson();
    return _data;
  }
}

class Mindata {
  Mindata({
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
    this.chatID,
    this.chatDateTime,
    this.chatType,
    this.messageType,
    this.message,
    this.messageStatus,
    this.chatDateTimeString,
    required this.itemCondition,
    required this.availableBrand,
    required this.availableQty,
    required this.validUptoDate,
    required this.validUptoDateString,
    required this.chatCount,
    this.newDone,
    this.usedDone,
    this.alternateDone,
    required this.docURL,
    required this.sellerImageURL,
    required this.sellerFirebaseToken,
    required this.sellerDeviceToken,
    this.imagesURLList,
    this.sellerList,
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
  late final Null chatID;
  late final Null chatDateTime;
  late final Null chatType;
  late final Null messageType;
  late final Null message;
  late final Null messageStatus;
  late final Null chatDateTimeString;
  late final String itemCondition;
  late final String availableBrand;
  late final dynamic availableQty;
  late final String validUptoDate;
  late final String validUptoDateString;
  late final dynamic chatCount;
  late final Null newDone;
  late final Null usedDone;
  late final Null alternateDone;
  late final String docURL;
  late final String sellerImageURL;
  late final String sellerFirebaseToken;
  late final String sellerDeviceToken;
  late final Null imagesURLList;
  late final Null sellerList;

  Mindata.fromJson(Map<String, dynamic> json) {
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
    chatID = null;
    chatDateTime = null;
    chatType = null;
    messageType = null;
    message = null;
    messageStatus = null;
    chatDateTimeString = null;
    itemCondition = json['itemCondition'];
    availableBrand = json['availableBrand'];
    availableQty = json['availableQty'];
    validUptoDate = json['validUptoDate'];
    validUptoDateString = json['validUptoDateString'];
    chatCount = json['chatCount'];
    newDone = null;
    usedDone = null;
    alternateDone = null;
    docURL = json['docURL'];
    sellerImageURL = json['sellerImageURL'];
    sellerFirebaseToken = json['sellerFirebaseToken'];
    sellerDeviceToken = json['sellerDeviceToken'];
    imagesURLList = null;
    sellerList = null;
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
    _data['chatID'] = chatID;
    _data['chatDateTime'] = chatDateTime;
    _data['chatType'] = chatType;
    _data['messageType'] = messageType;
    _data['message'] = message;
    _data['messageStatus'] = messageStatus;
    _data['chatDateTimeString'] = chatDateTimeString;
    _data['itemCondition'] = itemCondition;
    _data['availableBrand'] = availableBrand;
    _data['availableQty'] = availableQty;
    _data['validUptoDate'] = validUptoDate;
    _data['validUptoDateString'] = validUptoDateString;
    _data['chatCount'] = chatCount;
    _data['newDone'] = newDone;
    _data['usedDone'] = usedDone;
    _data['alternateDone'] = alternateDone;
    _data['docURL'] = docURL;
    _data['sellerImageURL'] = sellerImageURL;
    _data['sellerFirebaseToken'] = sellerFirebaseToken;
    _data['sellerDeviceToken'] = sellerDeviceToken;
    _data['imagesURLList'] = imagesURLList;
    _data['sellerList'] = sellerList;
    return _data;
  }
}
