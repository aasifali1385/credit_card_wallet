import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:credit_card_wallet/view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'home.dart';
import 'logo.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(MaterialApp(
    title: 'Virtual Card Holder',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'card',
      useMaterial3: true,
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      // scaffoldBackgroundColor: Colors.blue[50],
    ),
    home: const Home(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const platform = MethodChannel('henry-harvin-416a3.web.app/deepLink');

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _initDeepLink();
  }

  var uri;

  Future<void> _initDeepLink() async {
    final appLinks = AppLinks();
    uri = await appLinks.getLatestLink();


    if (uri == null) {
      _authenticate();
    } else {
      setState(() {});
    }
  }

  final LocalAuthentication auth = LocalAuthentication();

  void _authenticate() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      bool authenticated = false;
      try {
        authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to access cards',
          options: const AuthenticationOptions(
            biometricOnly: false,
          ),
        );
      } catch (e) {
        print(e);
      }

      if (authenticated) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
      ////////////////////////////////////////
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color(0xfff55d80),
              // Color(0xff6d7ff4),
              uri == null ? Colors.blue : Colors.white,
              Colors.white,
            ],
          ),
        ),
        // padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 60),
            uri == null
                ? Column(
                    children: [
                      const Icon(
                        Icons.lock_rounded,
                        size: 50,
                        // color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'AUTHENTICATION REQUIRED',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "card",
                          // color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Your data is securely stored and protected. You can access all your information without needing an internet connection.\nRest assured, your privacy is our priority, and all data remains safe and offline.'
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : ViewCard(card: uri.queryParameters['c'].toString().replaceAll('%E2%80%A2', '•')),

            ////////////////////////
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  backgroundColor: Colors.black,
                ),
                onPressed: _authenticate,
                child: const Text(
                  'VIEW MY CARDS',
                  style: TextStyle(color: Colors.white, fontFamily: 'card'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
