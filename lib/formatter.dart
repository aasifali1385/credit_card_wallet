import 'package:flutter/material.dart';

void formatNumber(String value, controller) {
  // Remove all spaces
  String newValue = value.replaceAll(' ', '');

  // Add a space after every 4 characters
  StringBuffer formattedValue = StringBuffer();
  for (int i = 0; i < newValue.length; i++) {
    if (i > 0 && i % 4 == 0) {
      formattedValue.write('  ');
    }
    formattedValue.write(newValue[i]);
  }

  // Update the controller's text and move the cursor to the end
  controller.value = TextEditingValue(
    text: formattedValue.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: formattedValue.length),
    ),
  );

}

void formatDate(String value, controller) {
  // Remove all spaces
  String newValue = value.replaceAll('/', '');

  // Add a space after every 4 characters
  StringBuffer formattedValue = StringBuffer();
  for (int i = 0; i < newValue.length; i++) {
    if (i > 0 && i % 2 == 0) {
      formattedValue.write('/');
    }
    formattedValue.write(newValue[i]);
  }

  // Update the controller's text and move the cursor to the end
  controller.value = TextEditingValue(
    text: formattedValue.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: formattedValue.length),
    ),
  );
}
