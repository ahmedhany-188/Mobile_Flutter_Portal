
class ItemsCatalogTreeModel {
  int? id;
  String? text;
  bool? expanded;
  List<Items>? items;
  bool? active;
  bool? allowItems;

  ItemsCatalogTreeModel(
      {this.id,
        this.text,
        this.expanded,
        this.items,
        this.active,
        this.allowItems});

  ItemsCatalogTreeModel.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;
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