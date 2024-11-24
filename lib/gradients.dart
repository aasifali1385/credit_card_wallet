import 'package:flutter/material.dart';

Map<dynamic, LinearGradient> getGradients() {
  return {
    1: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black, Color(0xff4A4A4A)]),

    2: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white70, Colors.black]),

    3: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black, Colors.black]),

    4: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.orange, Colors.orange[300]!]),

    5: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xffea2786),
          Color(0xffea2786),
        ]),



    ///////////////// HDFC ////////////////
    "Pixel": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xff13bccd),
          Color(0xff13bccd),
        ]),

    "Freedom": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF005CA6),
          Color(0xFF0060AA),
        ]),

    "Biz First": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF228FBE),
          Color(0xFF95D3F1),
        ]),

    "Swiggy": const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xFFE95B26),
          Color(0xFFEC702F),
          Color(0xFF903088),
          Color(0xFF00448C),
        ]),

    "Tata Neu": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2E1A46),
          Color(0xFF3F2A57),
        ]),

    "Tata Plus": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF009FE1),
          Color(0xFF662D90),
        ]),

    "MONEYBACK": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xFF00ACE3),
          Color(0xFF00ACE3),
          Color(0xFF004586),
          Color(0xFFE10613)
        ]),
    "MILLENNIA": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF1E3056), Color(0xFF1361A8)]),

    "INDIAN OIL": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFB87C35),
          Color(0xFFF1CD9A),
        ]),

    "UPI RUPAY": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF0E101C),
          Color(0xFF590D3F),
        ]),

    "IRCTC": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF0663AE),
          Color(0xFF88D6EB),
        ]),

    "Shoppers Stop": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF0A497D),
          Color(0xFF182551),
        ]),

    /////////////////////// AXIS BANK /////////////////

    "Flipkart": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2569A6),
          Color(0xFF040608),
          Color(0xFF040608),
          Color(0xFF741C4C)
        ]),

    "MY ZONE": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF000000), Color(0xFF340017), Color(0xFFDB2870)]),

    "NEO": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF000000),
          Color(0xFF646464),
          Color(0xFFC74F89),
          Color(0xFF1D010F)
        ]),

    ////////////////// SBI CARD ///////////////////

    "Simply CLICK": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF2C8C50), Color(0xFF012E13)]),

    "Simply SAVE": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF0091CA),
          Color(0xFF0C1646),
        ]),

    "Cashback": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF532F8F),
          Color(0xFF532F8F),
          Color(0xFFFDDC00),
        ]),

    "PRIME": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF083C58),
          Color(0xFFA41E49),
          Color(0xFF86911A),
          Color(0xFF15352A),
          Color(0xFF0F0F13),
        ]),

    "ELITE": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFECBEAB),
          Color(0xFF1E1F22),
          Color(0xFF000000),
        ]),

    ////////////////// Kotak /////////////////

    "Dream Different": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF045183), Color(0xFF8F6345)]),

    "Kotak 811": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF020202),
          Color(0xFF343434),
        ]),

    "League": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF000000), Color(0xFF706466), Color(0xFF000000)]),

    "PVR INOX": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0B0B0B),
          Color(0xFFD0A846),
        ]),

    "Myntra": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFEB5A9F),
          Color(0xFFEE6FA8),
          Color(0xFFF3947C),
          Color(0xFFFBD472),
        ]),

    "UPI RuPay": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFBA242C),
          Color(0xFF761019),
          Color(0xFF431C2E),
          Color(0xFF2E4557),
        ]),

    "mojo": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0E012B),
          Color(0xFF702B8C),
          Color(0xFFC41D8E),
          Color(0xFF903D94),
          Color(0xFF473191),
          Color(0xFF0B052B),
        ]),
    "Zen Signature": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF160C0B),
          Color(0xFF3F2314),
          Color(0xFF552D15),
          Color(0xFFF16B27),
        ]),

    ////////////////// ICICI /////////////////

    "Coral": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFC62824), Color(0xFF700F0A), Color(0xFF000000)]),

    "Platinum": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF848380),
          Color(0xFF53504D),
          Color(0xFF050703),
          Color(0xFF050703),
        ]),

    "Amazon Pay": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0E0E0E), Color(0xFF333333), Color(0xFF2E2E2E)]),

    "MakeMyTrip": const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFFE65D11),
          Color(0xFFE65D11),
          Color(0xFF0F0E0E),
          Color(0xFF0F0E0E),
        ]),

    /////////////////// YES BANK //////////////////

    "MARQUEE": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF282C2F),
          Color(0xFF1F2125),
          Color(0xFF566166),
          Color(0xFF292F36),
        ]),

    "RESERV": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF000616),
          Color(0xFF002297),
          Color(0xFF000411),
          Color(0xFF081746),
        ]),

    "ELITE+": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF010A1B),
          Color(0xFF01163E),
          Color(0xFF0A2F70),
          Color(0xFF011E59),
          Color(0xFF011B4C),
        ]),

    "SELECT": const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF91AFF3),
          Color(0xFF204FBC),
          Color(0xFF2958C6),
          Color(0xFF001D63),
          Color(0xFF1948B6),
          Color(0xFF3C69D2),
        ]),

    "ACE": const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF0A8D9B),
          Color(0xFF017480),
          Color(0xFF014047),
          Color(0xFF017E8C),
          Color(0xFF01737F),
          Color(0xFF09737E),
        ]),

    "ACE": const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF0A8D9B),
          Color(0xFF017480),
          Color(0xFF014047),
          Color(0xFF017E8C),
          Color(0xFF01737F),
          Color(0xFF09737E),
        ]),

    "EMI CARD": const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF05A0D0),
          Color(0xFF0483B1),
          Color(0xFF0F58A9),
          Color(0xFF0C3C9E),
          Color(0xFF02126B),
        ]),

    "Klick": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1263B0), Color(0xFF002F94), Color(0xFF1263B0)]),

    /////////////////////// BOB /////////////////////

    "ETERNA": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF053444),
          Color(0xFF012B3B),
          Color(0xFF597684),
        ]),

    "PREMIER": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF680E0D),
          Color(0xFF610F10),
          Color(0xFF861718),
        ]),

    "snapdeal": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFEB1D46),
          Color(0xFFEC2654),
        ]),

    "BOB IRCTC": const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF000000),
          Color(0xFF924500),
          Color(0xFF005F14),
        ]),

    "BOB SELECT": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF403E54),
          Color(0xFF4D4C61),
          Color(0xFF343341),
          Color(0xFF262432),
          Color(0xFFDCB626),
        ]),

    "BOB EASY": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF1250A3),
          Color(0xFF006FB9),
          Color(0xFF00B2EF),
          Color(0xFF017CC2),
          Color(0xFF19459B),
        ]),

    ////////////////////////////////
  };
}
