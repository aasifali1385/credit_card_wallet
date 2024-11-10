import 'package:credit_card_wallet/card.dart';
import 'package:credit_card_wallet/gradients.dart';
import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  final card = {
    "bank": 'assets/icici_bank.png',
    "network": 'assets/visa.png',
    "type": 'CORAL',
    "number": "⛥⛥⛥⛥  ⛥⛥⛥⛥  ⛥⛥⛥⛥  ⛥⛥⛥⛥",
    "from": '⛥⛥/⛥⛥',
    "thru": '⛥⛥/⛥⛥',
    "name": '⛥⛥⛥⛥⛥⛥',
    "cvv": '123',
    "style": '',
    "paid": false
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(right: 40),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Transform(
              alignment: Alignment.bottomRight,
              transform: Matrix4.identity()
                ..translate(0.0, -113.0) // Move the card up to rotate around the bottom right corner
                ..rotateZ(8.2 * (3.1415 / 180)) // Rotate around the Z-axis
                ..translate(16.0, 100.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.black,
                shadowColor: Colors.white12,
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        gradient: getGradients()['SimplyClick']),
                    child: AspectRatio(
                      aspectRatio: 3.375 / 2.125,
                      child: frontContent({
                        "bank": '',
                        "network": 'assets/visa.png',
                        "type": 'CORAL',
                        "number": "⛥⛥⛥⛥  ⛥⛥⛥⛥  ⛥⛥⛥⛥  ⛥⛥⛥⛥",
                        "from": '⛥⛥/⛥⛥',
                        "thru": '⛥⛥/⛥⛥',
                        "name": '⛥⛥⛥⛥⛥⛥',
                        "cvv": '123',
                        "style": '',
                        "paid": false
                      }, screenWidth, ""),
                    )),
              ),
            ),
            Transform(
              alignment: Alignment.bottomRight,
              transform: Matrix4.identity()
                ..translate(0.0, -105.0) // Move the card up to rotate around the bottom right corner
                ..rotateZ(4.2 * (3.1415 / 180)) // Rotate around the Z-axis
                ..translate(8.0, 100.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.black,
                shadowColor: Colors.white12,
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        gradient: getGradients()[3]),
                    child: AspectRatio(
                      aspectRatio: 3.375 / 2.125,
                      child: frontContent({
                        "bank": '',
                        "network": 'assets/visa.png',
                        "type": 'CORAL',
                        "number": "⛥⛥⛥⛥  ⛥⛥⛥⛥  ⛥⛥⛥⛥  ⛥⛥⛥⛥",
                        "from": '⛥⛥/⛥⛥',
                        "thru": '⛥⛥/⛥⛥',
                        "name": '⛥⛥⛥⛥⛥⛥',
                        "cvv": '123',
                        "style": '',
                        "paid": false
                      }, screenWidth, ""),
                    )),
              ),
            ),

            Card(
              clipBehavior: Clip.antiAlias,
              color: Colors.black,
              shadowColor: Colors.white12,
              elevation: 4,
              margin: const EdgeInsets.all(10),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      gradient: getGradients()['IciciCoral']),
                  child: AspectRatio(
                    aspectRatio: 3.375 / 2.125,
                    child: frontContent(card, screenWidth, ""),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
