class ItemCatalogSearchModel {
  int? code;
  String? message;
  bool? error;
  List<ItemCatalogSearchData>? data;

  ItemCatalogSearchModel({this.code, this.message, this.error, this.data});

  ItemCatalogSearchModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ItemCatalogSearchData>[];
      json['data'].forEach((v) {
        data!.add(ItemCatalogSearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemCatalogSearchData {
  int? itemID;
  int? requestNo;
  String? systemItemCode;
  String? itemCode;
  String? itemName;
  String? itemDesc;
  String? itemQty;
  String? itemPrice;
  bool? itemAppearPrice;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;
  List<ItemAttach>? itemsAttaches;
  int? catID;
  String? category;
  int? itemUOM;
  String? itmCatUOM;
  int? itemMatGroup;
  String? matrialGroup;
  int? itemMatType;
  String? materialType;
  String? itemPhoto;
  String? tags;
  bool? enableBrand;
  bool? enableColor;
  bool? expirationDateFlag;
  String? arabicDesc;

  ItemCatalogSearchData(
      {this.itemID,
        this.requestNo,
        this.systemItemCode,
        this.itemCode,
        this.itemName,
        this.itemDesc,
        this.itemQty,
        this.itemPrice,
        this.itemAppearPrice,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate,
        this.itemsAttaches,
        this.catID,
        this.category,
        this.itemUOM,
        this.itmCatUOM,
        this.itemMatGroup,
        this.matrialGroup,
        this.itemMatType,
        this.materialType,
        this.itemPhoto,
        this.tags,
        this.enableBrand,
        this.enableColor,
        this.expirationDateFlag,
        this.arabicDesc});

  ItemCatalogSearchData.fromJson(Map<String, dynamic> json) {
    itemID = json['item_ID'];
    requestNo = json['requestNo'];
    systemItemCode = json['systemItemCode'];
    itemCode = json['itemCode'];
    itemName = json['item_Name'];
    itemDesc = json['item_Desc'];
    itemQty = json['item_Qty'];
    itemPrice = json['item_Price'];
    itemAppearPrice = json['item_AppearPrice'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
    if (json['items_Attaches'] != null) {
      itemsAttaches = <ItemAttach>[];
      json['items_Attaches'].forEach((v) {
        itemsAttaches!.add(ItemAttach.fromJson(v));
      });
    }
    catID = json['cat_ID'];
    category = json['category'];
    itemUOM = json['item_UOM'];
    itmCatUOM = json['itmCat_UOM'];
    itemMatGroup = json['item_MatGroup'];
    matrialGroup = json['matrialGroup'];
    itemMatType = json['item_MatType'];
    materialType = json['materialType'];
    itemPhoto = json['item_Photo'];
    tags = json['tags'];
    enableBrand = json['enableBrand'];
    enableColor = json['enableColor'];
    expirationDateFlag = json['expirationDateFlag'];
    arabicDesc = json['arabicDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_ID'] = itemID;
    data['requestNo'] = requestNo;
    data['systemItemCode'] = systemItemCode;
    data['itemCode'] = itemCode;
    data['item_Name'] = itemName;
    data['item_Desc'] = itemDesc;
    data['item_Qty'] = itemQty;
    data['item_Price'] = itemPrice;
    data['item_AppearPrice'] = itemAppearPrice;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    if (itemsAttaches != null) {
      data['items_Attaches'] =
          itemsAttaches!.map((v) => v.toJson()).toList();
    }
    data['cat_ID'] = catID;
    data['category'] = category;
    data['item_UOM'] = itemUOM;
    data['itmCat_UOM'] = itmCatUOM;
    data['item_MatGroup'] = itemMatGroup;
    data['matrialGroup'] = matrialGroup;
    data['item_MatType'] = itemMatType;
    data['materialType'] = materialType;
    data['item_Photo'] = itemPhoto;
    data['tags'] = tags;
    data['enableBrand'] = enableBrand;
    data['enableColor'] = enableColor;
    data['expirationDateFlag'] = expirationDateFlag;
    data['arabicDesc'] = arabicDesc;
    return data;
  }
}

class ItemAttach {
  int? id;
  int? catId;
  String? attachFile;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  ItemAttach(
      {this.id,
        this.catId,
        this.attachFile,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  ItemAttach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    attachFile = json['attach_file'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_id'] = catId;
    data['attach_file'] = attachFile;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    return data;
  }
}