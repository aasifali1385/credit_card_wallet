import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'choose_dialog.dart';
import 'formatter.dart';
import 'gradients.dart';

class AddCard extends StatefulWidget {
  final String edit;

  const AddCard({super.key, this.edit = ""});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final _typeControl = TextEditingController();
  final _numberControl = TextEditingController();
  final _fromControl = TextEditingController();
  final _thruControl = TextEditingController();
  final _cvvControl = TextEditingController();
  final _nameControl = TextEditingController();
  var bank = "⛥⛥⛥⛥⛥⛥⛥";
  var network = "⛥⛥⛥⛥⛥";
  var paid = false;

  var title = "ADD CARD";
  bool isValid = false;

  var gradients = getGradients();
  dynamic selected = 0;

  void _checkValid() {
    setState(() {
      isValid = bank != "⛥⛥⛥⛥⛥⛥⛥" &&
          network != "⛥⛥⛥⛥⛥" &&
          _typeControl.text.isNotEmpty &&
          _numberControl.text.length == 22 &&
          _fromControl.text.length == 5 &&
          _thruControl.text.length == 5 &&
          _cvvControl.text.length == 3 &&
          _nameControl.text.isNotEmpty;
    });
  }

  void _addCard() async {
    var box = Hive.box('cards');
    await box.put(_numberControl.text, {
      "bank": bank,
      "network": network,
      "type": _typeControl.text,
      "number": _numberControl.text,
      "from": _fromControl.text,
      "thru": _thruControl.text,
      "name": _nameControl.text,
      "cvv": _cvvControl.text,
      "style": selected,
      "paid": paid
    });

    setState(() {
      title = "CARD ADDED";
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        title = "ADD CARD";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.edit.isNotEmpty) {
      var box = Hive.box('cards');
      final card = box.get(widget.edit);

      bank = card['bank'];
      _typeControl.text = card['type'];
      network = card['network'];
      _numberControl.text = card['number'];
      _fromControl.text = card['from'];
      _thruControl.text = card['thru'];
      _cvvControl.text = card['cvv'];
      _nameControl.text = card['name'];
      selected = card['style'];
      paid = card['paid'];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              // Color(0xff0f0f0f),
              // Color(0xff131314),

              Color(0xff314c58),
              Color(0xff6b8e7e),
            ])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    )),
                Expanded(
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20))),
                title == "ADD CARD"
                    ? IconButton(
                        onPressed: isValid ? _addCard : null,
                        icon: Icon(
                          Icons.done_rounded,
                          color: isValid ? Colors.white : Colors.white38,
                        ))
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ))
              ]),
              const SizedBox(height: 8),
              Hero(
                tag: 'add',
                child: Card(
                  elevation: 4,
                  color: Colors.black,
                  // shadowColor: Colors.white12,
                  margin: const EdgeInsets.all(0),
                  clipBehavior: Clip.antiAlias,
                  // color: Colors.black,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      gradient: gradients[selected],
                    ),
                    child: AspectRatio(
                      aspectRatio: 3.375 / 2.125,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () async {
                                          bank = await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  bankDialog(1));
                                          _checkValid();
                                        },
                                        child: bank.startsWith('assets')
                                            ? Image.asset(bank)
                                            : Text(
                                                bank,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        screenWidth * 0.045),
                                              )),
                                  ),
                                  const SizedBox(width: 40),
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.end,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      controller: _typeControl,
                                      onChanged: (value) {
                                        _checkValid();
                                      },
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          return newValue.copyWith(
                                              text:
                                                  newValue.text.toUpperCase());
                                        })
                                      ],
                                      keyboardType: TextInputType.text,
                                      maxLength: 15,
                                      buildCounter: (context,
                                          {required int currentLength,
                                          required bool isFocused,
                                          int? maxLength}) {
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          hintText: '⛥⛥⛥⛥⛥⛥⛥'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10)
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: TextField(
                                controller: _numberControl,
                                onChanged: (value) {
                                  formatNumber(value, _numberControl);
                                  _checkValid();
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontSize: screenWidth * 0.047,
                                    fontFamily: 'card',
                                    color: Colors.white),
                                maxLength: 22,
                                buildCounter: (context,
                                    {required int currentLength,
                                    required bool isFocused,
                                    int? maxLength}) {
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: InputBorder.none,
                                    hintText: '⛥⛥⛥⛥ ⛥⛥⛥⛥ ⛥⛥⛥⛥ ⛥⛥⛥⛥'),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'VALID\nFROM',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.022,
                                      fontFamily: 'card',
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  SizedBox(
                                    width: 100,
                                    child: TextField(
                                      controller: _fromControl,
                                      onChanged: (value) {
                                        formatDate(value, _fromControl);
                                        _checkValid();
                                      },
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.037,
                                      ),
                                      maxLength: 5,
                                      buildCounter: (context,
                                          {required int currentLength,
                                          required bool isFocused,
                                          int? maxLength}) {
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: '⛥⛥/⛥⛥',
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
                                    child: TextField(
                                      controller: _thruControl,
                                      onChanged: (value) {
                                        formatDate(value, _thruControl);
                                        _checkValid();
                                      },
                                      keyboardType: TextInputType.number,
                                      maxLength: 5,
                                      buildCounter: (context,
                                          {required int currentLength,
                                          required bool isFocused,
                                          int? maxLength}) {
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          hintText: '⛥⛥/⛥⛥'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.037,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: TextField(
                                      controller: _cvvControl,
                                      onChanged: (value) {
                                        _checkValid();
                                      },
                                      keyboardType: TextInputType.number,
                                      maxLength: 3,
                                      buildCounter: (context,
                                          {required int currentLength,
                                          required bool isFocused,
                                          int? maxLength}) {
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          focusedBorder: InputBorder.none,
                                          hintText: '⛥⛥⛥'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.037,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      controller: _nameControl,
                                      onChanged: (value) {
                                        _checkValid();
                                      },
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          return newValue.copyWith(
                                              text:
                                                  newValue.text.toUpperCase());
                                        })
                                      ],
                                      keyboardType: TextInputType.text,
                                      maxLength: 20,
                                      buildCounter: (context,
                                          {required int currentLength,
                                          required bool isFocused,
                                          int? maxLength}) {
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          hintText: '⛥⛥⛥⛥⛥⛥⛥'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () async {
                                          network = await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  bankDialog(3));
                                          _checkValid();
                                        },
                                        child: network.startsWith('assets')
                                            ? Image.asset(network)
                                            : Text(
                                                network,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        screenWidth * 0.045),
                                              )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  // gradient: gradients[selected],
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    switchButton("FREE CARD", !paid),
                    switchButton("PAID CARD", paid),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(child: chooseColors()),
            ],
          ),
        ),
      ),
    );
  }

  Widget switchButton(text, active) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!active) {
            paid = !paid;
            _checkValid();
          }
        },
        child: Container(
            margin: const EdgeInsets.all(2),
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: active ? gradients[selected] : null,
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: Colors.white, width: 0.5 ),
              color: active ? const Color(0xffffffff) : null,
            ),
            child: Text(
              text,
              style: TextStyle(color: active ? Colors.white : Colors.white),
            )),
      ),
    );
  }

  Widget chooseColors() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: gradients.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 3.375 / 2.125,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () {
              selected = gradients.keys.elementAt(index);
              _checkValid();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: gradients.values.elementAt(index),
                border: selected == gradients.keys.elementAt(index)
                    ? Border.all(color: Colors.white)
                    : null,
              ),
            ),
          );
        });
  }
}
