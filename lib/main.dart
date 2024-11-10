import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'home.dart';
import 'logo.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        // statusBarColor: MyColor.primary,
        ),
  );

  runApp(MaterialApp(
    title: 'Credit Card Wallet',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'card',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.deepPurple[50]),
    home: const MyApp(),
    // home: FlipCreditCard(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _authenticate();
  }

  final LocalAuthentication auth = LocalAuthentication();

  void _authenticate() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Logo()));
    return;

    if (availableBiometrics.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Ui()));
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
            context, MaterialPageRoute(builder: (context) => const Ui()));
      }
      ////////////////////////////////////////
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xff6b8e7e),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color(0xff0f0f0f),
              // Color(0xff131314),
              Color(0xff314c58),
              Color(0xff6b8e7e),
            ],
          ),
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.lock_rounded, size: 50),
            const SizedBox(height: 10),
            const Text(
              'AUTHENTICATION REQUIRED',
              style: TextStyle(fontSize: 20, fontFamily: "card"),
            ),
            const SizedBox(height: 20),
            const Text(
              'AUTHENTICATION REQUIRED TO ACCESS CARDS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'card'),
            ),
            const SizedBox(height: 450),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  backgroundColor: Colors.black),
              onPressed: _authenticate,
              child: const Text(
                'UNLOCK',
                style: TextStyle(color: Colors.white, fontFamily: 'card'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
