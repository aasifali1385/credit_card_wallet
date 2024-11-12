import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'add_card.dart';
import 'gradients.dart';

class CreditCard extends StatefulWidget {
  final dynamic card;
  final Function update;

  const CreditCard({super.key, required this.card, required this.update});

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
        ? "ANNUAL FEES THIS MONTH"
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
                      child: Text(
                        card['cvv'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            )),
        Expanded(
            flex: 5,
            child: Transform(
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
                          color: Colors.red,
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
    padding: EdgeInsets.fromLTRB(20, alert != "" ? 6 : 14, 20, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (alert != "")
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: const Color(0x4D000000),
                borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.fromLTRB(8, 2, 10, 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                const SizedBox(width: 4),
                Text(alert, style: const TextStyle(color: Colors.amber))
              ],
            ),
          ),
        Expanded(
            child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: card['bank'].startsWith('assets')
                        ? Image.asset(card['bank'])
                        : Text(
                            card['bank'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.045),
                          ),
                  ),
                  Expanded(
                    child: Text(
                      card['type'],
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.045),
                    ),
                  ),
                  const SizedBox(width: 8)
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
              child: Text(
                card['number'],
                style: TextStyle(
                    fontSize: screenWidth * 0.047,
                    // fontSize: screenWidth * 0.042,
                    fontFamily: 'card',
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'VALID\nFROM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.1,
                      fontSize: screenWidth * 0.022,
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
                        fontSize: screenWidth * 0.037,
                      ),
                    ),
                  ),
                  Text(
                    'VALID\nTHRU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.022,
                        height: 1.1),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 100,
                    child: Text(
                      card['thru'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.037,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Image.asset(card['network']),
                  )
                ],
              ),
            ),
          ],
        )),
      ],
    ),
  );
}
