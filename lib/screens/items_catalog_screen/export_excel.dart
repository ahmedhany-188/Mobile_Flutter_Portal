import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_requestCatalog_reponse.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row,Column;
import '../../data/models/items_catalog_models/item_catalog_cart_model.dart';

Future<void> importDataCart(List<CartModelData> reports,int orderID) async {
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

Future<List<ExcelDataRow>> _buildCustomersDataRowsIHCart(List<CartModelData> list) async {
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  // final Future<List<CartModelData>> reports = _getCustomersImageHyperlink();
  final List<CartModelData> reports = list;

  List<CartModelData> reports_1 = await Future.value(reports);

  excelDataRows = reports_1.map<ExcelDataRow>((CartModelData dataRow) {
    // TODO: call API to get item details :)
    return ExcelDataRow(cells: <ExcelDataCell>[
      ExcelDataCell(columnHeader: 'Item of Requisition', value: dataRow.itmCatItems?.itemCode??""),
      const ExcelDataCell(columnHeader: 'Acct Assignment Cat.', value: ""),
      const ExcelDataCell(columnHeader: 'Item Category', value: 'dataRow.itmCatItems?.category'),
      ExcelDataCell(columnHeader: 'Short Text', value: dataRow.itmCatItems?.itemName),
      ExcelDataCell(columnHeader: 'Quantity', value: dataRow.itemQty),
      ExcelDataCell(columnHeader: 'Base Unit of Measure', value: dataRow.itmCatItems?.itmCatUOM),
      const ExcelDataCell(columnHeader: 'Deliv. date category', value: ""),
      const ExcelDataCell(columnHeader: 'Deliv. date(From/to)', value: ""),
      ExcelDataCell(columnHeader: 'Material Group', value: dataRow.itemCode),
      ExcelDataCell(columnHeader: 'Material Type', value: dataRow.itemCode),
      ExcelDataCell(columnHeader: 'Description', value: dataRow.itmCatItems?.itemDesc),
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


Future<void> importDataRequests(NewRequestCatalogModelResponse getCatalogRequestsHistoryList) async {
  //Create a Excel document.
  //Creating a workbook.
  if(getCatalogRequestsHistoryList.data!=null){
    if(getCatalogRequestsHistoryList.data!.isNotEmpty){
      EasyLoading.show(status: 'Converting...');
      final Workbook workbook = Workbook();

      //Accessing via index
      final Worksheet sheet = workbook.worksheets[0];

      //List of data to import data.
      final Future<List<ExcelDataRow>> dataRows = _buildCustomersDataRowsIHRequests(getCatalogRequestsHistoryList);

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
      final File file = File('$path/ImportData.xlsx');
      await file.writeAsBytes(bytes, flush: true);

      //Launch the file (used open_file package)
      EasyLoading.dismiss();

      await OpenFile.open('$path/ImportData.xlsx');
    }
  } else{
    EasyLoading.showInfo('Add Items to Cart');
  }
}

Future<List<ExcelDataRow>> _buildCustomersDataRowsIHRequests(NewRequestCatalogModelResponse getCatalogRequestsHistoryList) async {
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  // final Future<List<CartModelData>> reports = _getCustomersImageHyperlink();
  final List<Data> reports = getCatalogRequestsHistoryList.data??[];

  List<Data> reports_1 = await Future.value(reports);

  excelDataRows = reports_1.map<ExcelDataRow>((Data dataRow) {
    // TODO: call API to get item details :)
    return ExcelDataRow(cells: <ExcelDataCell>[
      ExcelDataCell(columnHeader: 'Request ID', value: dataRow.requestID??""),
      const ExcelDataCell(columnHeader: 'Find Item ID', value: ""),
      ExcelDataCell(columnHeader: 'Date', value: dataRow.requestID??""),
      ExcelDataCell(columnHeader: 'Item Name', value: dataRow.itemName??""),
      ExcelDataCell(columnHeader: 'Cat_ID', value: dataRow.catID??""),
      ExcelDataCell(columnHeader: 'Cat Name', value: dataRow.catName??""),
      ExcelDataCell(columnHeader: 'Status', value:dataRow.status??""),
      ExcelDataCell(columnHeader: 'Item Desc', value:dataRow.itemDesc??""),
    ]);
  }).toList();

  return excelDataRows;
}


// Future<List<CartModelData>> _getCustomersImageHyperlink() async {
//   final List<CartModelData> reports = <CartModelData>[];
//
//   // final Hyperlink link = Hyperlink.add('https://www.syncfusion.com',
//   //     'Hyperlink', 'Syncfusion', HyperlinkType.url);
//
//   // Picture pic = Picture(await _readImageData('Woman1.jpg'));
//   // pic.width = 200;
//   // pic.height = 200;
//   // pic.hyperlink = link;
//   CartModelData customer = CartModelData();
//   // customer.hyperlink = link;
//   // customer.image = pic;
//   reports.add(customer);
//
//   // pic = Picture(await _readImageData('Man4.png'));
//   // pic.width = 200;
//   // pic.height = 200;
//   // pic.hyperlink = link;
//   customer = CartModelData();
//   // customer.hyperlink = link;
//   // customer.image = pic;
//   reports.add(customer);
//
//   // pic = Picture(await _readImageData('Woman12.jpg'));
//   // pic.width = 200;
//   // pic.height = 200;
//   // pic.hyperlink = link;
//   // customer = CartModelData('Antonio Moreno Taquería', 75000, 64000, -15);
//   // customer.hyperlink = link;
//   // customer.image = pic;
//   // reports.add(customer);
//   //
//   // pic = Picture(await _readImageData('Man16.jpg'));
//   // pic.width = 200;
//   // pic.height = 200;
//   // pic.hyperlink = link;
//   // customer = CartModelData('Thomas Hardy', 56500, 33600, -40);
//   // customer.hyperlink = link;
//   // customer.image = pic;
//   // reports.add(customer);
//   //
//   // pic = Picture(await _readImageData('Man6.png'));
//   // pic.width = 200;
//   // pic.height = 200;
//   // pic.hyperlink = link;
//   customer = CartModelData();
//   // customer.hyperlink = link;
//   // customer.image = pic;
//   reports.add(customer);
//
//   return reports;
// }