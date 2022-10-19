class ItemCategoryGetAll {
  int? code;
  String? message;
  bool? error;
  List<ItemCategorygetAllData>? data;

  ItemCategoryGetAll({this.code, this.message, this.error, this.data});

  ItemCategoryGetAll.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ItemCategorygetAllData>[];
      json['data'].forEach((v) {
        data!.add(ItemCategorygetAllData.fromJson(v));
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

class ItemCategorygetAllData {
  int? itemID;
  int? requestNo;
  String? systemItemCode;
  String? itemCode;
  String? itemName;
  String? itemDesc;
  int? itemQty;
  double? itemPrice;
  bool? itemAppearPrice;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;
  List<ItemsAttaches>? itemsAttaches;
  int? catID;
  Category? category;
  int? itemUOM;
  ItmCatUOM? itmCatUOM;
  int? itemMatGroup;
  MatrialGroup? matrialGroup;
  int? itemMatType;
  MaterialType? materialType;
  String? itemPhoto;
  String? tags;
  bool? enableBrand;
  bool? enableColor;
  bool? expirationDateFlag;
  String? arabicDesc;

  ItemCategorygetAllData(
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

  ItemCategorygetAllData.fromJson(Map<String, dynamic> json) {
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
      itemsAttaches = <ItemsAttaches>[];
      json['items_Attaches'].forEach((v) {
        itemsAttaches!.add(ItemsAttaches.fromJson(v));
      });
    }
    catID = json['cat_ID'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    itemUOM = json['item_UOM'];
    itmCatUOM = json['itmCat_UOM'] != null
        ? ItmCatUOM.fromJson(json['itmCat_UOM'])
        : null;
    itemMatGroup = json['item_MatGroup'];
    matrialGroup = json['matrialGroup'] != null
        ? MatrialGroup.fromJson(json['matrialGroup'])
        : null;
    itemMatType = json['item_MatType'];
    materialType = json['materialType'] != null
        ? MaterialType.fromJson(json['materialType'])
        : null;
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
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['item_UOM'] = itemUOM;
    if (itmCatUOM != null) {
      data['itmCat_UOM'] = itmCatUOM!.toJson();
    }
    data['item_MatGroup'] = itemMatGroup;
    if (matrialGroup != null) {
      data['matrialGroup'] = matrialGroup!.toJson();
    }
    data['item_MatType'] = itemMatType;
    if (materialType != null) {
      data['materialType'] = materialType!.toJson();
    }
    data['item_Photo'] = itemPhoto;
    data['tags'] = tags;
    data['enableBrand'] = enableBrand;
    data['enableColor'] = enableColor;
    data['expirationDateFlag'] = expirationDateFlag;
    data['arabicDesc'] = arabicDesc;
    return data;
  }
}

class ItemsAttaches {
  int? id;
  int? itemID;
  String? attachFile;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  ItemsAttaches(
      {this.id,
        this.itemID,
        this.attachFile,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  ItemsAttaches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemID = json['item_ID'];
    attachFile = json['attach_File'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_ID'] = itemID;
    data['attach_File'] = attachFile;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    return data;
  }
}

class Category {
  int? catId;
  int? parentID;
  String? catName;
  String? catCode;
  String? catDesc;
  String? catPhoto;
  String? catStartDate;
  String? catEndDate;
  String? tags;
  bool? isActive;
  bool? allowItems;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;
  List? categoryAttach;

  Category(
      {this.catId,
        this.parentID,
        this.catName,
        this.catCode,
        this.catDesc,
        this.catPhoto,
        this.catStartDate,
        this.catEndDate,
        this.tags,
        this.isActive,
        this.allowItems,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate,
        this.categoryAttach});

  Category.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    parentID = json['parent_ID'];
    catName = json['cat_Name'];
    catCode = json['cat_Code'];
    catDesc = json['cat_Desc'];
    catPhoto = json['cat_Photo'];
    catStartDate = json['cat_StartDate'];
    catEndDate = json['cat_EndDate'];
    tags = json['tags'];
    isActive = json['isActive'];
    allowItems = json['allow_Items'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
    if (json['category_Attach'] != null) {
      categoryAttach = [];
      categoryAttach = json['category_Attach'];
      // json['category_Attach'].forEach((v) {
      //   categoryAttach!.add(v.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['parent_ID'] = parentID;
    data['cat_Name'] = catName;
    data['cat_Code'] = catCode;
    data['cat_Desc'] = catDesc;
    data['cat_Photo'] = catPhoto;
    data['cat_StartDate'] = catStartDate;
    data['cat_EndDate'] = catEndDate;
    data['tags'] = tags;
    data['isActive'] = isActive;
    data['allow_Items'] = allowItems;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    if (categoryAttach != null) {
      data['category_Attach'] =
          categoryAttach!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItmCatUOM {
  int? id;
  String? unitName;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  ItmCatUOM(
      {this.id,
        this.unitName,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  ItmCatUOM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitName = json['unit_Name'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_Name'] = unitName;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    return data;
  }
}

class MatrialGroup {
  int? id;
  String? materialName;
  String? groupDesc;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  MatrialGroup(
      {this.id,
        this.materialName,
        this.groupDesc,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  MatrialGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialName = json['material_Name'];
    groupDesc = json['group_Desc'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['material_Name'] = materialName;
    data['group_Desc'] = groupDesc;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    return data;
  }
}

class MaterialType {
  int? id;
  String? materialTypName;
  String? typeDesc;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  MaterialType(
      {this.id,
        this.materialTypName,
        this.typeDesc,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  MaterialType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialTypName = json['materialTyp_Name'];
    typeDesc = json['type_Desc'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['materialTyp_Name'] = materialTypName;
    data['type_Desc'] = typeDesc;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    return data;
  }
}