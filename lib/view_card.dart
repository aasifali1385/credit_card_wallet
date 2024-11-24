import 'package:credit_card_wallet/card.dart';
import 'package:flutter/material.dart';

import 'gradients.dart';

class ViewCard extends StatefulWidget {
  final String card;

  const ViewCard({super.key, required this.card});

  @override
  State<ViewCard> createState() => _ViewCardState();
}

class _ViewCardState extends State<ViewCard> {
  var key = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final da = widget.card.split('•');
    var card = {"style": da[8], "paid": false};

    final cvv = key.length == 3 ? dec(Uri.decodeComponent(da[7]), key) : 'cvv';

    if (key == cvv) {
      final regExp = RegExp('[A-Z]');
      var num = dec(Uri.decodeComponent(da[3]), key);

      StringBuffer formattedValue = StringBuffer();
      for (int i = 0; i < num.length; i++) {
        if (i > 0 && i % 4 == 0) {
          formattedValue.write('  ');
        }
        formattedValue.write(num[i]);
      }

      card = {
        "bank": regExp.hasMatch(da[0][0]) ? da[0] : 'assets/${da[0]}.png',
        "network": regExp.hasMatch(da[1][0]) ? da[1] : 'assets/${da[1]}.png',
        "type": da[2].replaceAll('+', ' '),
        "number": formattedValue.toString(),
        "from": dec(Uri.decodeComponent(da[4]), key),
        "thru": dec(Uri.decodeComponent(da[5]), key),
        "name": da[6].replaceAll('+', ' '),
        "cvv": cvv,
        "style": da[8],
        "paid": false,
      };
    }

    return
      // Scaffold(
      //   body:
        key == cvv
            ? CreditCard(card: card,  update: () {}, isView: true)
            : Card(
                elevation: 4,
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.all(6),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: getGradients()[card['style']]),
                    child: AspectRatio(
                      aspectRatio: 3.375 / 2.125,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ENTER \'CVV\' TO UNLOCK CARD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.048),
                            ),
                            TextField(
                              autofocus: true,
                              showCursor: false,
                              onChanged: (value) {
                                setState(() {
                                  key = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 3,
                              buildCounter: (context,
                                  {required int currentLength,
                                  required bool isFocused,
                                  int? maxLength}) {
                                return null;
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.white),
                                  focusedBorder: InputBorder.none,
                                  hintText: '⛥⛥⛥'),
                              style: TextStyle(
                                color: key.length == 3
                                    ? Colors.red
                                    : Colors.white,
                                fontSize: screenWidth * 0.06,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
        // )
      );
  }
}

String dec(String str, key) {
  var keyIn = 0;
  var out = '';

  for (var n in str.characters) {
    if (keyIn == 3) keyIn = 0;
    out += String.fromCharCode(
        n.codeUnitAt(0) - int.parse(key.toString()[keyIn++]));
  }
  return out;
}
