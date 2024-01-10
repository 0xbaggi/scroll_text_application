import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_galaxy_controller/pages/splash_screen.dart';
import 'pages/editor.dart';
import 'pages/github.dart';
import 'pages/info.dart';
import 'pages/settings.dart';
import 'pages/trackpad.dart';
import 'pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the system overlay mode to immersive
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(const Root());
  });
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/home': (context) => const Home(),
        '/settings': (context) => const SettingsPage(),
        '/controller': (context) => const EditorPage(),
        '/trackpad': (context) => const TrackpadPage(),
        '/github': (context) => const GithubPage(),
        '/info': (context) => const InfoPage(),
      },
    );
  }
}
