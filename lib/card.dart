import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_plus/share_plus.dart';
import 'add_card.dart';
import 'gradients.dart';

class CreditCard extends StatefulWidget {
  final dynamic card;
  final Function update;
  final bool isView;

  const CreditCard({super.key, required this.card, required this.update, this.isView =false});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  bool confirmDelete = false;

  void _deleteCard() async {
    var box = Hive.box('cards');
    await box.delete(widget.card['number']);
    _flipCard();
    widget.update();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final month = int.parse(widget.card['thru'].split('/')[0]);
    final cMonth = DateTime.now().month;

    var alert = (widget.card['paid'] && month == cMonth)
        ? "ANNUAL FEES\nTHIS MONTH"
        : (widget.card['paid'] && month - cMonth == 1)
            ? "ANNUAL FEES NEXT MONTH"
            : "";

    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * 3.14159; // PI radians
          final isUnder = _animation.value > 0.5;

          return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002) // Perspective
                ..rotateY(angle),
              alignment: Alignment.center,
              child: Card(
                  elevation: 4,
                  color: Colors.black,
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.all(6),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: getGradients()[widget.card['style']]),
                      child: AspectRatio(
                        aspectRatio: 3.375 / 2.125,
                        child: isUnder
                            ? backContent(widget.card, screenWidth)
                            : frontContent(widget.card, screenWidth, alert),
                      )))

              // isUnder? backCard(widget.card, screenWidth): frontCard(widget.card, screenWidth),
              );
        },
      ),
    );
  }

  Widget backContent(card, screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 20),
        Expanded(flex: 3, child: Container(color: Colors.black)),
        const SizedBox(height: 16),
        Expanded(
            flex: 2,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                      )),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: LayoutBuilder(
                        builder: (context,cons) {
                          return Text(
                            card['cvv'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: cons.maxWidth / 5,
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            )),
        Expanded(
            flex: 5,
            child: widget.isView ? const SizedBox(): Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  confirmDelete
                      ? IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: const Color(0x33ffffff)),
                          onPressed: () {
                            setState(() {
                              confirmDelete = false;
                            });
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ))
                      : IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: const Color(0x33ffffff)),
                          onPressed: () {
                            setState(() {
                              confirmDelete = true;
                            });
                          },
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                          )),
                  if (confirmDelete)
                    IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: const Color(0x33ffffff)),
                        onPressed: _deleteCard,
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.redAccent,
                        )),
                  IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: const Color(0x33ffffff)),
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddCard(edit: card['number'])));
                        widget.update();
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: Colors.white,
                      )),
                  ///////////// Share /////////////
                  IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: const Color(0x33ffffff)),
                      onPressed: () {
                        shareCard(card);
                      },
                      icon: const Icon(
                        Icons.share_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
            )),
      ],
    );
  }
}

Widget frontContent(card, screenWidth, alert) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: card['bank'].startsWith('assets')
                            ? Image.asset(card['bank'])
                            : LayoutBuilder(builder: (context, cons) {
                                return Text(
                                  card['bank'],
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: cons.maxWidth / 8),
                                );
                              }),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: LayoutBuilder(builder: (context, cons) {
                          return alert != ""
                              ? const SizedBox()
                              : Text(
                                  card['type'],
                                  textAlign: TextAlign.end,
                            maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: cons.maxWidth / 8),
                                );
                        }),
                      ),
                      const SizedBox(width: 6)
                    ],
                  ),
                  ///////////// ALERT /////////////
                  if (alert != "")
                    Container(
                      // margin: const EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                        color: const Color(0x59FFFFFF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 4),
                      child: Text(alert,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.amber)),
                    )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Image.asset("assets/chip.png"),
                  const Expanded(child: SizedBox()),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Image.asset("assets/nfc.png")),
                  const SizedBox(width: 6)
                ],
              ),
            ),
            const SizedBox(height: 12)
          ],
        )),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LayoutBuilder(builder: (context, cons) {
                return Text(
                  card['number'],
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: cons.maxWidth / 19.5,
                      // fontSize: screenWidth * 0.042,
                      fontFamily: 'card',
                      color: Colors.white),
                );
              }),
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, cons) {
                return Row(
                  children: [
                    Text(
                      'VALID\nFROM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.1,
                        fontSize: cons.maxWidth / 40,
                        fontFamily: 'card',
                        // height: 1,
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 100,
                      child: Text(
                        card['from'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: cons.maxWidth / 23,
                        ),
                      ),
                    ),
                    Text(
                      'VALID\nTHRU',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: cons.maxWidth / 40,
                          height: 1.1),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 100,
                      child: Text(
                        card['thru'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: cons.maxWidth / 23,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(builder: (context, cons) {
                      return Text(
                        card['name'],
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: cons.maxWidth / 13,
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(card['network'])),
                  ),
                ],
              ),
            ),
          ],
        )),
      ],
    ),
  );
}

void shareCard(card) {
  var str = '';
  for (var v in card.entries) {
    final value = v.value.toString();

    if ((v.key == 'bank' || v.key == 'network') && value.startsWith('assets')) {
      str += value.substring(7, value.length - 4);
    } else if (v.key == 'number' ||
        v.key == "from" ||
        v.key == 'thru' ||
        v.key == 'cvv') {
      str += enc(value.replaceAll(' ', ''), card['cvv']);
    } else if (v.key != 'paid') {
      str += value;
    }

    str += '•';
    ////////////////////
  }
  Share.share(
      'https://virtualcardhold.web.app?c=${str.replaceAll(' ', '+').substring(0, str.length - 2)}');
}

String enc(String str, key) {
  var keyIn = 0;
  var out = '';

  for (var n in str.characters) {
    if (keyIn == 3) keyIn = 0;
    final t = String.fromCharCode(
        n.codeUnitAt(0) + int.parse(key.toString()[keyIn++]));
    out += t;
  }

  return Uri.encodeComponent(out);
}
