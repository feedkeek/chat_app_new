import 'package:flutter/material.dart';

Widget formMaterialButton({
  double? width,
  required Color color,
  required onPressed,
  required context,
  String label = "",
}) {
  return MaterialButton(
    elevation: 12.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      width: width,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 24),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 17),
    color: color,
    onPressed: onPressed,
  );
}
