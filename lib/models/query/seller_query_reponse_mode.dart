class SellerQueryResponseModel {
  SellerQueryResponseModel({
    required this.status,
    required this.list,
  });
  late final bool status;
  late final QuotationDataModel list;

  SellerQueryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    list = QuotationDataModel.fromJson(json['list']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['list'] = list.toJson();
    return _data;
  }
}

class QuotationDataModel {
  QuotationDataModel({
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
    this.entryType,
    this.imagesURLList,
    this.sellerList,
    required this.chatDetail,
    required this.ratingSeller,
    required this.displaySellerRating,
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
  late final Null entryType;
  late final Null imagesURLList;
  late final Null sellerList;
  late final List<ChatDetail> chatDetail;
  late final dynamic ratingSeller;
  late final dynamic displaySellerRating;

  QuotationDataModel.fromJson(Map<String, dynamic> json) {
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
    entryType = null;
    imagesURLList = null;
    sellerList = null;
    chatDetail = List.from(json['chatDetail'])
        .map((e) => ChatDetail.fromJson(e))
        .toList();
    ratingSeller = json['ratingSeller'];
    displaySellerRating = json['displaySellerRating'];
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
    _data['entryType'] = entryType;
    _data['imagesURLList'] = imagesURLList;
    _data['sellerList'] = sellerList;
    _data['chatDetail'] = chatDetail.map((e) => e.toJson()).toList();
    _data['ratingSeller'] = ratingSeller;
    _data['displaySellerRating'] = displaySellerRating;
    return _data;
  }
}

class ChatDetail {
  ChatDetail({
    required this.queryID,
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
    this.qty,
    this.conditionNew,
    this.conditionUsed,
    this.alternateProduct,
    this.dueDateTime,
    this.dueDateTimeString,
    this.productName,
    this.productDescription,
    this.queryDateTimeString,
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
    required this.chatID,
    required this.chatDateTime,
    required this.chatType,
    required this.messageType,
    required this.message,
    required this.messageStatus,
    required this.chatDateTimeString,
    this.itemCondition,
    this.availableBrand,
    this.availableQty,
    this.validUptoDate,
    this.validUptoDateString,
    this.chatCount,
    this.newDone,
    this.usedDone,
    this.alternateDone,
    required this.docURL,
    required this.sellerImageURL,
    this.sellerFirebaseToken,
    this.sellerDeviceToken,
    required this.entryType,
    this.imagesURLList,
    this.sellerList,
    this.chatDetail,
    this.ratingSeller,
    this.displaySellerRating,
  });
  late final dynamic queryID;
  late final Null queryDateTime;
  late final Null buyerID;
  late final Null categoryID;
  late final Null subCategoryID;
  late final Null requirementsDetail;
  late final Null brandModel;
  late final Null makeYear;
  late final Null condition;
  late final Null colorID;
  late final Null status;
  late final Null qty;
  late final Null conditionNew;
  late final Null conditionUsed;
  late final Null alternateProduct;
  late final Null dueDateTime;
  late final Null dueDateTimeString;
  late final Null productName;
  late final Null productDescription;
  late final Null queryDateTimeString;
  late final Null categoryName;
  late final Null subCategoryName;
  late final Null colorName;
  late final Null buyerName;
  late final Null qsComputerNo;
  late final Null sellerID;
  late final Null sellerName;
  late final Null sellerReplyDateTime;
  late final Null available;
  late final Null rate;
  late final Null sellerRemarks;
  late final Null qsStatus;
  late final Null sellerReplyDateTimeString;
  late final dynamic chatID;
  late final String chatDateTime;
  late final String chatType;
  late final String messageType;
  late final String message;
  late final String messageStatus;
  late final String chatDateTimeString;
  late final Null itemCondition;
  late final Null availableBrand;
  late final Null availableQty;
  late final Null validUptoDate;
  late final Null validUptoDateString;
  late final Null chatCount;
  late final Null newDone;
  late final Null usedDone;
  late final Null alternateDone;
  late final String docURL;
  late final String sellerImageURL;
  late final Null sellerFirebaseToken;
  late final Null sellerDeviceToken;
  late final String entryType;
  late final Null imagesURLList;
  late final Null sellerList;
  late final Null chatDetail;
  late final Null ratingSeller;
  late final Null displaySellerRating;

  ChatDetail.fromJson(Map<String, dynamic> json) {
    queryID = json['queryID'];
    queryDateTime = null;
    buyerID = null;
    categoryID = null;
    subCategoryID = null;
    requirementsDetail = null;
    brandModel = null;
    makeYear = null;
    condition = null;
    colorID = null;
    status = null;
    qty = null;
    conditionNew = null;
    conditionUsed = null;
    alternateProduct = null;
    dueDateTime = null;
    dueDateTimeString = null;
    productName = null;
    productDescription = null;
    queryDateTimeString = null;
    categoryName = null;
    subCategoryName = null;
    colorName = null;
    buyerName = null;
    qsComputerNo = null;
    sellerID = null;
    sellerName = null;
    sellerReplyDateTime = null;
    available = null;
    rate = null;
    sellerRemarks = null;
    qsStatus = null;
    sellerReplyDateTimeString = null;
    chatID = json['chatID'];
    chatDateTime = json['chatDateTime'];
    chatType = json['chatType'];
    messageType = json['messageType'];
    message = json['message'];
    messageStatus = json['messageStatus'];
    chatDateTimeString = json['chatDateTimeString'];
    itemCondition = null;
    availableBrand = null;
    availableQty = null;
    validUptoDate = null;
    validUptoDateString = null;
    chatCount = null;
    newDone = null;
    usedDone = null;
    alternateDone = null;
    docURL = json['docURL'];
    sellerImageURL = json['sellerImageURL'];
    sellerFirebaseToken = null;
    sellerDeviceToken = null;
    entryType = json['entryType'];
    imagesURLList = null;
    sellerList = null;
    chatDetail = null;
    ratingSeller = null;
    displaySellerRating = null;
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
    _data['entryType'] = entryType;
    _data['imagesURLList'] = imagesURLList;
    _data['sellerList'] = sellerList;
    _data['chatDetail'] = chatDetail;
    _data['ratingSeller'] = ratingSeller;
    _data['displaySellerRating'] = displaySellerRating;
    return _data;
  }
}
