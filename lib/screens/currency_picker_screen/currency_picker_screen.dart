import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class CurrencyPickerScreen extends StatefulWidget {
  static const routeName = '/currency-converter-list-screen';

  const CurrencyPickerScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyPickerScreen> createState() => CurrencyPickerScreenClass();
}
void fetchOutlookCalender() async {
  await launchUrl(Uri.parse('https://outlook.office.com/calendar/view/month'),
      mode: LaunchMode.externalNonBrowserApplication);
}

class CurrencyPickerScreenClass extends State<CurrencyPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo for outlook picker')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => fetchOutlookCalender(),
              child: const Text('Show currency picker'),
            ),
          ),
        ],
      ),
    );
  }
}
