import 'package:connectivity_app_mobx/connectivity_store.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Settings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final store = ConnectivityStore();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: ReactionBuilder(
          builder: (context) {
            return reaction((_) => store.connectivityStream.value, (result) {
              final messenger = ScaffoldMessenger.of(context);

              messenger.showSnackBar(SnackBar(
                  content: Text(result == ConnectivityResult.none
                      ? 'You\'re offline'
                      : 'You\'re online')));
            }, delay: 4000);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                  'Turn your connection on/off for approximately 4 seconds to see the app respond to changes in your connection status.'),
            ),
          )),
    );
  }
}
