import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row,Column;

import '../../data/models/items_catalog_models/item_catalog_cart_model.dart';

Future<void> importData(List<CartModelData> reports) async {
  //Create a Excel document.
  //Creating a workbook.
  final Workbook workbook = Workbook();

  //Accessing via index
  final Worksheet sheet = workbook.worksheets[0];

  //List of data to import data.
  final Future<List<ExcelDataRow>> dataRows = _buildCustomersDataRowsIH(reports);

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
  await OpenFile.open('$path/ImportData.xlsx');
}

Future<List<ExcelDataRow>> _buildCustomersDataRowsIH(List<CartModelData> list) async {
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  // final Future<List<CartModelData>> reports = _getCustomersImageHyperlink();
  final List<CartModelData> reports = list;

  List<CartModelData> reports_1 = await Future.value(reports);

  excelDataRows = reports_1.map<ExcelDataRow>((CartModelData dataRow) {
    return ExcelDataRow(cells: <ExcelDataCell>[
      ExcelDataCell(columnHeader: 'Sales Person', value: 'dataRow.salesPerson'),
      ExcelDataCell(
          columnHeader: 'Sales Jan to June', value: 'dataRow.salesJanJune'),
      ExcelDataCell(
          columnHeader: 'Sales July to Dec', value: 'dataRow.salesJulyDec'),
      ExcelDataCell(columnHeader: 'Change', value: 'dataRow.change'),
      ExcelDataCell(columnHeader: 'Hyperlink', value: 'dataRow.hyperlink'),
      ExcelDataCell(columnHeader: 'Images Hyperlinks', value: 'dataRow.image')
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