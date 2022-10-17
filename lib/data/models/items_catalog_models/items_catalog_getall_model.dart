class ItemsCatalogCategory {
  int? code;
  Null? message;
  bool? error;
  List<Data>? data;

  ItemsCatalogCategory({this.code, this.message, this.error, this.data});

  ItemsCatalogCategory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? text;
  bool? expanded;
  List<Items>? items;
  bool? active;
  bool? allowItems;

  Data(
      {this.id,
        this.text,
        this.expanded,
        this.items,
        this.active,
        this.allowItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    expanded = json['expanded'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    active = json['active'];
    allowItems = json['allow_Items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['expanded'] = this.expanded;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['active'] = this.active;
    data['allow_Items'] = this.allowItems;
    return data;
  }
}

class Items {
  int? id;
  String? text;
  bool? expanded;
  List<Null>? items;
  bool? active;
  bool? allowItems;

  Items(
      {this.id,
        this.text,
        this.expanded,
        this.items,
        this.active,
        this.allowItems});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    expanded = json['expanded'];
    if (json['items'] != null) {
      items = <Null>[];
      json['items'].forEach((v) {
        //TODO:   read data
        // items!.add(new Null.fromJson(v));
      });
    }
    active = json['active'];
    allowItems = json['allow_Items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['expanded'] = this.expanded;
    if (this.items != null) {
      //TODO:   read data
      // data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['active'] = this.active;
    data['allow_Items'] = this.allowItems;
    return data;
  }
}