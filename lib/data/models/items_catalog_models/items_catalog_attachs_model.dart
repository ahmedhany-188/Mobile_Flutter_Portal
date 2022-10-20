class itemCategoryAttachs {
  int? code;
  Null? message;
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
        data!.add(new ItemCategoryAttachData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
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
  Null? catStartDate;
  Null? catEndDate;
  String? tags;
  bool? isActive;
  bool? allowItems;
  Null? inUser;
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
        categoryAttach!.add(new CategoryAttach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['parent_ID'] = this.parentID;
    data['cat_Name'] = this.catName;
    data['cat_Code'] = this.catCode;
    data['cat_Desc'] = this.catDesc;
    data['cat_Photo'] = this.catPhoto;
    data['cat_StartDate'] = this.catStartDate;
    data['cat_EndDate'] = this.catEndDate;
    data['tags'] = this.tags;
    data['isActive'] = this.isActive;
    data['allow_Items'] = this.allowItems;
    data['in_User'] = this.inUser;
    data['in_Date'] = this.inDate;
    data['up_User'] = this.upUser;
    data['up_Date'] = this.upDate;
    if (this.categoryAttach != null) {
      data['category_Attach'] =
          this.categoryAttach!.map((v) => v.toJson()).toList();
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
  Null? upUser;
  Null? upDate;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['attach_file'] = this.attachFile;
    data['in_User'] = this.inUser;
    data['in_Date'] = this.inDate;
    data['up_User'] = this.upUser;
    data['up_Date'] = this.upDate;
    return data;
  }
}