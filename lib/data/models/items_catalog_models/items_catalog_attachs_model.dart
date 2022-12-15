class itemCategoryAttachs {
  int? code;
  String? message;
  bool? error;
  List<ItemCategoryAttachData>? data;

  itemCategoryAttachs({this.code, this.message, this.error, this.data});

  itemCategoryAttachs.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ItemCategoryAttachData>[];
      json['data'].forEach((v) {
        data!.add(ItemCategoryAttachData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemCategoryAttachData {
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
  List<CategoryAttach>? categoryAttach;

  ItemCategoryAttachData(
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

  ItemCategoryAttachData.fromJson(Map<String, dynamic> json) {
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
      categoryAttach = <CategoryAttach>[];
      json['category_Attach'].forEach((v) {
        categoryAttach!.add(CategoryAttach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class CategoryAttach {
  int? id;
  int? catId;
  String? attachFile;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  CategoryAttach(
      {this.id,
        this.catId,
        this.attachFile,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  CategoryAttach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    attachFile = json['attach_file'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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