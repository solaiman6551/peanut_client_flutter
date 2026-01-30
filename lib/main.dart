import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peanut_client_app/utils/main_widget.dart';
import 'core/bootstrap.dart';

void main() async {
  runApp(
    UncontrolledProviderScope(
        container: await bootstrap(),
        child: const MainWidget()
    ),
  );
}