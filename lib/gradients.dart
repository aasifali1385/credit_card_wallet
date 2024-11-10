import 'package:flutter/material.dart';

Map<dynamic, LinearGradient> getGradients() {
  return {
    0: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black54, Colors.black]),

    1:  LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black, Colors.black26]),

    2: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white70, Colors.black]),

    3:  LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.orange, Colors.orange[300]!]),

    /////////////////////////////

    "HdfcMoneyback": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xFF00ACE3),
          Color(0xFF00ACE3),
          Color(0xFF004586),
          Color(0xFFE10613)
        ]),
    "HdfcMillennia": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF1E3056), Color(0xFF1361A8)]),
    "IciciCoral": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFC62824), Color(0xFF700F0A), Color(0xFF000000)]),


    "AxisFlipkart": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2569A6),
          Color(0xFF040608),
          Color(0xFF040608),
          Color(0xFF741C4C)
        ]),
    "YesBankKlick": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1263B0), Color(0xFF002F94), Color(0xFF1263B0)]),
    "AmazonPay": const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0E0E0E), Color(0xFF333333), Color(0xFF2E2E2E)]),
    "KotakLeague": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF000000), Color(0xFF706466), Color(0xFF000000)]),
    "SimplyClick": const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF2C8C50), Color(0xFF012E13)]),
    "DreamDifferent": const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF045183), Color(0xFF8F6345)]),
  };
}
