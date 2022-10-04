import 'package:flutter/material.dart';

Widget myRequestStatusString(String? status) {
  switch (status) {
    case 'Approved':
      {
        return const Icon(
          Icons.verified,
          color: Colors.green,
        );
      }
    case 'Rejected':
      {
        return const Icon(
          Icons.cancel,
          color: Colors.red,
        );
      }
    default:
      {
        return const Icon(
          Icons.pending_actions_outlined,
          color: Colors.yellow,
        );
      }
  }
}