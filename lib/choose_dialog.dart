import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget bankDialog(dialogType) {
  List<String> list = dialogType == 1
      ? [
          "axis_bank.png",
          "kotak_bank.png",
          "icici_bank.png",
          "sbi_card.png",
          "yes_bank.png",
          "american_bank.png",
          "jp_morgon.png"
        ]
      : ["visa.png", "mastercard.png", "rupay.png", "rupay_white.png"];

  final controller = TextEditingController();

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: const Color(0x331f22ff),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: dialogType == 1 ? list.length + 1 : list.length,
      padding: const EdgeInsets.all(2),
      itemBuilder: (context, index) => list.length == index && dialogType == 1
          ? Expanded(
              child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                          text: newValue.text.toUpperCase());
                    })
                  ],
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'ENTER HERE...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context, controller.text);
                      },
                      icon: const Icon(Icons.done_rounded, color: Colors.white),
                    ),
                  )))
          : image(list[index], (selected) {
              Navigator.pop(context, selected);
            }),
    ),
  );
}

Widget image(image, tap) {
  return InkWell(
    onTap: () {
      tap('assets/$image');
    },
    borderRadius: BorderRadius.circular(10),
    child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0x80FFFFFF)),
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Image.asset('assets/$image')),
  );
}
