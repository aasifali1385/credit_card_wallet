import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
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
    title: 'Credit Card Wallet',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'card',
      useMaterial3: true,
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      // scaffoldBackgroundColor: Colors.blue[50],
    ),
    home: const MyApp(),
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

    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Logo()));
    // return;

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color(0xfff55d80),
              // Color(0xff6d7ff4),
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 60),
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
            Text(
              'Your data is securely stored and protected. You can access all your information without needing an internet connection.\nRest assured, your privacy is our priority, and all data remains safe and offline.'
                  .toUpperCase(),
              textAlign: TextAlign.center,
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: Colors.black,
              ),
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
