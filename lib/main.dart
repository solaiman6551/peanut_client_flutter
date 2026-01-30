import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peanut_client_app/utils/main_widget.dart';
import 'core/bootstrap.dart';

void main() async {
  try {
    final container = await bootstrap();
    runApp(
      UncontrolledProviderScope(
          container: container,
          child: const MainWidget()
      ),
    );
  } catch (e) {
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text("Fatal Error: $e")))));
  }
}