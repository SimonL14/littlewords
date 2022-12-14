import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/dio.provider.dart';
import 'package:littlewords/version.dart';
import 'addword.dart';
import 'package:littlewords/wordCount.dart';
import 'package:littlewords/word_dto.dart';
import 'dbhelpercours.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:location/location.dart';
//import 'package:dio/dio.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:go_router/go_router.dart';
//import 'package:json_annotation/json_annotation.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
//import 'package:freezed/builder.dart';
//import 'package:build_runner/build_runner.dart';
//import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),

      },
    );
  }
}
