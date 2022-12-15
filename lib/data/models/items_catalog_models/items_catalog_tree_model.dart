
class ItemsCatalogTreeModel {
  int? id;
  String? text;
  bool? expanded;
  List<Items>? items;
  bool? active;
  bool? allowItems;
  String? main_Photo;

  ItemsCatalogTreeModel(
      {this.id,
        this.text,
        this.expanded,
        this.items,
        this.active,
        this.allowItems,this.main_Photo});

  ItemsCatalogTreeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    expanded = json['expanded'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    active = json['active'];
    allowItems = json['allow_Items'];
    main_Photo = json['main_Photo'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['text'] = text;
    data['expanded'] = expanded;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['active'] = active;
    data['allow_Items'] = allowItems;
    data['main_Photo'] = main_Photo;
    return data;
  }
}

class Items {
  int? id;
  String? text;
  bool? expanded;
  List<Items>? items;
  bool? active;
  bool? allowItems;
  String? main_Photo;

  Items(
      {this.id,
        this.text,
        this.expanded,
        this.items,
        this.active,
        this.allowItems,
        this.main_Photo});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    expanded = json['expanded'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
         items!.add(Items.fromJson(v));
      });
    }
    active = json['active'];
    allowItems = json['allow_Items'];
    main_Photo=json['main_Photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['text'] = text;
    data['expanded'] = expanded;
    if (items != null) {
       data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['active'] = active;
    data['allow_Items'] = allowItems;
    data['main_Photo']=main_Photo;
    return data;
  }
}