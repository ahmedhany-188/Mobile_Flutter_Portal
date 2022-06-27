class EquipmentsItemModel {
  int? hardWareItemId;
  String? itemSerial;
  int? typeId;
  int? groupId;
  int? groupDescId;
  String? hardWareItemName;
  int? maxReq;
  int? minStock;
  bool? requiredEmp;
  String? estimatePrice;
  String? startDate;
  String? endDate;
  String? deviceBrand;
  String? deviceModel;
  String? devicePorts;
  String? deviceMax;
  String? procesType;
  String? procesSpeed;
  String? ramType;
  String? ramSize;
  String? vgachipset;
  String? vgatype;
  String? vgasize;
  String? hardType;
  String? hardModel;
  String? hardSize;
  String? windows;
  String? conNetWork;
  String? conUsb;
  String? conIp;
  String? hdtype;
  String? hdmodel;
  String? hdsize;
  String? comment;
  String? inDate;
  String? inUser;
  String? unitType;
  String? isParent;
  String? parentItemId;

  EquipmentsItemModel(
      {this.hardWareItemId,
        this.itemSerial,
        this.typeId,
        this.groupId,
        this.groupDescId,
        this.hardWareItemName,
        this.maxReq,
        this.minStock,
        this.requiredEmp,
        this.estimatePrice,
        this.startDate,
        this.endDate,
        this.deviceBrand,
        this.deviceModel,
        this.devicePorts,
        this.deviceMax,
        this.procesType,
        this.procesSpeed,
        this.ramType,
        this.ramSize,
        this.vgachipset,
        this.vgatype,
        this.vgasize,
        this.hardType,
        this.hardModel,
        this.hardSize,
        this.windows,
        this.conNetWork,
        this.conUsb,
        this.conIp,
        this.hdtype,
        this.hdmodel,
        this.hdsize,
        this.comment,
        this.inDate,
        this.inUser,
        this.unitType,
        this.isParent,
        this.parentItemId});

  EquipmentsItemModel.fromJson(Map<String, dynamic> json) {
    hardWareItemId = json['hardWareItemId'];
    itemSerial = json['itemSerial'];
    typeId = json['typeId'];
    groupId = json['groupId'];
    groupDescId = json['groupDescId'];
    hardWareItemName = json['hardWareItemName'];
    maxReq = json['maxReq'];
    minStock = json['minStock'];
    requiredEmp = json['requiredEmp'];
    estimatePrice = json['estimatePrice'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    deviceBrand = json['deviceBrand'];
    deviceModel = json['deviceModel'];
    devicePorts = json['devicePorts'];
    deviceMax = json['deviceMax'];
    procesType = json['procesType'];
    procesSpeed = json['procesSpeed'];
    ramType = json['ramType'];
    ramSize = json['ramSize'];
    vgachipset = json['vgachipset'];
    vgatype = json['vgatype'];
    vgasize = json['vgasize'];
    hardType = json['hardType'];
    hardModel = json['hardModel'];
    hardSize = json['hardSize'];
    windows = json['windows'];
    conNetWork = json['conNetWork'];
    conUsb = json['conUsb'];
    conIp = json['conIp'];
    hdtype = json['hdtype'];
    hdmodel = json['hdmodel'];
    hdsize = json['hdsize'];
    comment = json['comment'];
    inDate = json['inDate'];
    inUser = json['inUser'];
    unitType = json['unitType'];
    isParent = json['isParent'];
    parentItemId = json['parentItemId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hardWareItemId'] = hardWareItemId;
    data['itemSerial'] = itemSerial;
    data['typeId'] = typeId;
    data['groupId'] = groupId;
    data['groupDescId'] = groupDescId;
    data['hardWareItemName'] = hardWareItemName;
    data['maxReq'] = maxReq;
    data['minStock'] = minStock;
    data['requiredEmp'] = requiredEmp;
    data['estimatePrice'] = estimatePrice;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['deviceBrand'] = deviceBrand;
    data['deviceModel'] = deviceModel;
    data['devicePorts'] = devicePorts;
    data['deviceMax'] = deviceMax;
    data['procesType'] = procesType;
    data['procesSpeed'] = procesSpeed;
    data['ramType'] = ramType;
    data['ramSize'] = ramSize;
    data['vgachipset'] = vgachipset;
    data['vgatype'] = vgatype;
    data['vgasize'] = vgasize;
    data['hardType'] = hardType;
    data['hardModel'] = hardModel;
    data['hardSize'] = hardSize;
    data['windows'] = windows;
    data['conNetWork'] = conNetWork;
    data['conUsb'] = conUsb;
    data['conIp'] = conIp;
    data['hdtype'] = hdtype;
    data['hdmodel'] = hdmodel;
    data['hdsize'] = hdsize;
    data['comment'] = comment;
    data['inDate'] = inDate;
    data['inUser'] = inUser;
    data['unitType'] = unitType;
    data['isParent'] = isParent;
    data['parentItemId'] = parentItemId;
    return data;
  }
}