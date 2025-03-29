class ApiLinks {
  // assets base path
  //static const String assetBasePath = "https://soaqna.said.com.sa/public/";

  // api path and links
  // static const String base = 'http://questolxuser.riverravi.com/api';
  // static const String base = 'http://192.168.10.120:8081/api';
  // static const String assetsBase = "http://192.168.10.120:8081";
  static const String base = 'http://buyerapi.ask2genie.com/api';
  // 'http://questolxuser.riverravi.com/';
  static const String register = '$base/Buyer/buyersignup';
  static const String getCountry = '$base/Setup/getcountrylist';
  static const String getCity = '$base/Setup/getcitylist';
  static const String getCategories = '$base/Setup/getquerycategorylist';
  static const String getSubCategories = '$base/Setup/getquerysubcategorylist/';
  static const String getColors = '$base/Setup/getcolorslist';
  static const String getConditions = '$base/Setup/getqueryconditionlist';
  static const String buyerupdateimage = '$base/Buyer/buyerupdateimage';
  static const String buyerlogin = '$base/Login/buyerlogin';
  static const String verification = '$base/Buyer/buyerverification';
  static const String reSendVerification = '$base/Buyer/resendverificationcode';
  static const String sellerDetails = '$base/Seller/getsellerdetail';
  static const String buyerDetails = '$base/Buyer/getBuyerdetail';
  static const String sellerUpdate = '$base/Buyer/buyerupdate';
  static const String sellerUpdatePassword =
      '$base/Password/buyerchangepassword';
  // static const String sellerUpdateCat = '$base/Seller/sellerupdatecategory';
  // static const String getSellerCategories = '$base/Seller/getsellercategories';
  static const String insertFirebase = '$base/Buyer/buyerinsertfirebase';
  static const String getFirebase = '$base/Buyer/getbuyerfirebase';
  static const String updateFirebase = '$base/Buyer/buyerupdatefirebase';
  static const String queryInsert = '$base/Query/queryinsert';
  static const String imageInsert = '$base/Query/queryinsertimage';
  static const String queryinsertaudio = '$base/Query/queryinsertaudio';
  static const String queryinsertvideo = '$base/Query/queryinsertvideo';
  static const String getBuyerActiveQuery =
      '$base/Query/getbuyeractivequerylist';
  static const String getactivequerysellerlist =
      '$base/Query/getactivequerysellerlist';
  static const String getselleryqueryresponse =
      '$base/Query/getselleryqueryresponse';
  static const String getBuyerHistoryQuery =
      '$base/Query/getbuyerhistoryquerylist';
  static const String getQueryImages = '$base/Query/getqueryimageslist';
  static const String getQueryDetails = '$base/Query/getquerydetail';
  static const String updateQueryStatus = '$base/Query/queryupdatestatus';
  static const String getActiveQuerySellerList =
      '$base/Query/getquerysellerlist';
  static const String sellerQueryChatInsert =
      '$base/Query/buyerquerychatinsert';
  static const String getQueryChat = '$base/Query/getquerychat';
  static const String insertChatImage = '$base/Query/chatinsertimageaudio';
  static const String getQuerySellerList = '$base/Query/getquerysellerlist';
  static const String chatinsertvideo = '$base/Query/chatinsertvideo';
  static const String getqueryminratelist = '$base/Query/getqueryminratelist';
  static const String getquerycomparisonlist =
      '$base/Query/getquerycomparisonlist';
  static const String querysellerselected = '$base/Query/querysellerselected';
  static const String querysellerrating = '$base/Query/querysellerrating';
  static const String getselectedquerysellerlist =
      '$base/Query/getselectedquerysellerlist';
  static const String getbestsellerlist = '$base/Seller/getbestsellerlist';
}
