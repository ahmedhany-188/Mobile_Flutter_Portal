import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_request_work_flow.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row,Column;

Future<void> importDataCart(List<ItemCategorygetAllData> reports,int orderID) async {
  //Create a Excel document.
  //Creating a workbook.
  if(reports.isNotEmpty){
    EasyLoading.show(status: 'Converting...');
    final Workbook workbook = Workbook();

    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];

    //List of data to import data.
    final Future<List<ExcelDataRow>> dataRows = _buildCustomersDataRowsIHCart(reports);

    List<ExcelDataRow> dataRows_1 = await Future.value(dataRows);

    //Import the list to Sheet.
    sheet.importData(dataRows_1, 1, 1);

    //Auto-Fit columns.
    sheet.getRangeByName('A1:E1').autoFitColumns();

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();

    //Dispose the document.
    workbook.dispose();

    //Get the storage folder location using path_provider package.
    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;
    final String orderIDName="Order-$orderID";
    final File file = File('$path/$orderIDName.xlsx');
    await file.writeAsBytes(bytes, flush: true);

    //Launch the file (used open_file package)
    await OpenFile.open('$path/$orderIDName.xlsx');
    // onSuccess.call();
  }
  else{
    EasyLoading.showInfo('Add Items to Cart');
  }
}

Future<List<ExcelDataRow>> _buildCustomersDataRowsIHCart(List<ItemCategorygetAllData> list) async {
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  // final Future<List<CartModelData>> reports = _getCustomersImageHyperlink();
  final List<ItemCategorygetAllData> reports = list;

  List<ItemCategorygetAllData> reports_1 = await Future.value(reports);

  excelDataRows = reports_1.map<ExcelDataRow>((ItemCategorygetAllData dataRow) {
    // TODO: call API to get item details :)
    return ExcelDataRow(cells: <ExcelDataCell>[
      ExcelDataCell(columnHeader: 'Item of Requisition', value: dataRow.itemCode??""),
      const ExcelDataCell(columnHeader: 'Acct Assignment Cat.', value: ""),
      ExcelDataCell(columnHeader: 'Item Category', value: dataRow.category?.catName??""),
      ExcelDataCell(columnHeader: 'Short Text', value: dataRow.itemName??""),
      ExcelDataCell(columnHeader: 'Quantity', value: dataRow.itemQty??0),
      ExcelDataCell(columnHeader: 'Base Unit of Measure', value: dataRow.itmCatUOM?.unitName??""),
      const ExcelDataCell(columnHeader: 'Deliv. date category', value: ""),
      const ExcelDataCell(columnHeader: 'Deliv. date(From/to)', value: ""),
      ExcelDataCell(columnHeader: 'Material Group', value: dataRow.matrialGroup?.materialName??""),
      ExcelDataCell(columnHeader: 'Material Type', value: dataRow.materialType?.materialTypName??""),
      ExcelDataCell(columnHeader: 'Description', value: dataRow.itemDesc??""),
      const ExcelDataCell(columnHeader: 'Plant', value: ""),
      const ExcelDataCell(columnHeader: 'Storage location', value: ""),
      const ExcelDataCell(columnHeader: 'Purchasing Group', value: ""),
      const ExcelDataCell(columnHeader: 'Short Text 1', value: ""),
      const ExcelDataCell(columnHeader: 'Gross value', value: ""),
      const ExcelDataCell(columnHeader: 'Order', value: ""),
      const ExcelDataCell(columnHeader: 'Activity', value: ""),
      const ExcelDataCell(columnHeader: 'Long Text', value: ""),
    ]);
  }).toList();

  return excelDataRows;
}


Future<void> importDataWorkFlowCatalog(List<CatalogRequestWorkFlow> getCatalogWorkFlowList,String name) async {
  //Create a Excel document.
  //Creating a workbook.
  if(getCatalogWorkFlowList.isNotEmpty){
    EasyLoading.show(status: 'Converting...');
    final Workbook workbook = Workbook();

    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];

    //List of data to import data.
    final Future<List<ExcelDataRow>> dataRows = _buildCustomersDataRowsWorkFlowCatalog(getCatalogWorkFlowList,name);

    List<ExcelDataRow> dataRows_1 = await Future.value(dataRows);

    //Import the list to Sheet.
    sheet.importData(dataRows_1, 1, 1);

    //Auto-Fit columns.
    sheet.getRangeByName('A1:E1').autoFitColumns();

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();

    //Dispose the document.
    workbook.dispose();

    //Get the storage folder location using path_provider package.
    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;
    final String fileName=name;
    final File file = File('$path/$fileName.xlsx');
    await file.writeAsBytes(bytes, flush: true);

    //Launch the file (used open_file package)
    await OpenFile.open('$path/$fileName.xlsx');
    // onSuccess.call();
  }
  else{
    EasyLoading.showInfo('Data not found');
  }
}

Future<List<ExcelDataRow>> _buildCustomersDataRowsWorkFlowCatalog(List<CatalogRequestWorkFlow> workFlowList,String name) async {
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  final List<CatalogRequestWorkFlow> reports = workFlowList;

  List<DataWF> reports_1 = await Future.value(reports[0].data);

  excelDataRows = reports_1.map<ExcelDataRow>((DataWF dataRow) {
    // TODO: call API to get item details :)
    return ExcelDataRow(cells: <ExcelDataCell>[

      ExcelDataCell(columnHeader: 'Request ID', value: dataRow.requestID??0),
      ExcelDataCell(columnHeader: 'Item Name', value: dataRow.itemName??""),
      ExcelDataCell(columnHeader: 'Item Code', value: dataRow.itemCode??""),
      ExcelDataCell(columnHeader: 'Category Name', value: dataRow.catName??""),
      ExcelDataCell(columnHeader: 'Group Name', value: dataRow.groupName??""),
      ExcelDataCell(columnHeader: 'Action', value: dataRow.actionDesc??""),
      ExcelDataCell(columnHeader: 'Action HRCode', value: dataRow.actionByHRCode??""),
      ExcelDataCell(columnHeader: 'Action Name', value: dataRow.actionByName??""),
      ExcelDataCell(columnHeader: 'Action Email', value: dataRow.actionByEmail??""),
      ExcelDataCell(columnHeader: 'Action Date', value: dataRow.submittedDate??""),

    ]);
  }).toList();

  return excelDataRows;
}