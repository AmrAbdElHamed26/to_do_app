import 'package:flutter/material.dart';
import 'package:todoapp/shared/components/blockobserver.dart';

import 'layout/home_layout.dart';

void main() {
  MyBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}