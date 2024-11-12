import 'package:flutter/material.dart';
import 'card.dart';
import 'gradients.dart';
import 'package:hive_flutter/adapters.dart';
import 'add_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  var cards = [];

  void _init() async {
    var box = await Hive.openBox('cards');

    // box.clear();
    setState(() {
      cards = box.values.toList();
    });
  }

  final gradients = getGradients();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: cards.length + 1,
            itemBuilder: (context, index) {
              return index == cards.length
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Hero(
                        tag: 'add',
                        child: Card(
                          elevation: 4,
                          color: Colors.black,
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(6),
                          child: Container(
                            decoration:
                                BoxDecoration(gradient: getGradients()[1]),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AddCard()));
                                _init();
                              },
                              child: const AspectRatio(
                                aspectRatio: 3.375 / 2.125,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'ADD NEW CARD',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'card',
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : CreditCard(card: cards[index], update: () => _init());
              // card(cards[index], fontSizeNo, fontSizeDateHead, fontSizeDate, fontSizeName);
            }));
  }
}
