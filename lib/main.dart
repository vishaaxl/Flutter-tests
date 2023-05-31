import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwansports/cancel.dart';
import 'package:kwansports/runs-widget.dart';
import 'package:kwansports/wss.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CancelOrder(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(runsProvider).when(data: (data) {
      final jsonData = jsonDecode(data);

      return RunsWidget(
          ball: jsonData['balls'].toString(), run: jsonData['runs'].toString());
    }, error: (Object error, StackTrace stackTrace) {
      return const Scaffold(
        body: Center(
          child: Text(
            "error",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
