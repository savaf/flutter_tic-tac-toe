import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/app.dart';

void main() {
  try {
    runApp(const App());
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
