import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget internalAppBar(
    {required BuildContext context, required String title}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    elevation: 5,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF3772a6),
              Color(0xFF3772a6),
              Color(0xFF1a4c78),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
           ),
      ),
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    title: Text(title),
    centerTitle: true,
  );
}
