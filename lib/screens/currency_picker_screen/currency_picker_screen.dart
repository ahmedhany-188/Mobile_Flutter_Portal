
// import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
// import 'package:money_converter/Currency.dart';
// import 'package:money_converter/money_converter.dart';

class CurrencyPickerScreen extends StatefulWidget {

  static const routeName = '/currency-converter-list-screen';

  const CurrencyPickerScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyPickerScreen> createState() => CurrencyPickerScreenClass();

}

  class CurrencyPickerScreenClass extends State<CurrencyPickerScreen> {

    @override
    Widget build(BuildContext context) {

      // String? usdToEgp;

      getAmounts();

      return Scaffold(
        appBar: AppBar(title: const Text('Demo for currency picker')),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // showCurrencyPicker(
                  //   context: context,
                  //   showFlag: true,
                  //   showSearchField: true,
                  //   showCurrencyName: true,
                  //   showCurrencyCode: true,
                  //   onSelect: (Currency currency) {
                  //     print('Select currency: ${currency.name}');
                  //   },
                  //   favorite: ['SEK'],
                  // );
                },
                child: const Text('Show currency picker'),
              ),
            ),

          ],
        ),
      );
    }

    // call function to convert
    void getAmounts() async {
      // var usdConvert = await MoneyConverter.convert(
      //     Currency(Currency.USD, amount: 1), Currency(Currency.EGP));
      //
      // print("oooooooooooo"+usdConvert.toString()+"ppppp");
      // setState(() {
      //   // usdToEgp = usdConvert.toString();
      // });
    }


  }






