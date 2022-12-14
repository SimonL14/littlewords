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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: const

          WordCount(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return FloatingActionButton(
                  onPressed: _openAddWord,
                  tooltip: 'Increment',
                  child: const Icon(Icons.arrow_upward),
                );
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: () async {
                // si on click sur l'icon, on ajoute dans la base de donnée
                //await DbHelper.instance.insert(WordDTO(1,textController.text , textController.text ,20,20));
                //Nettoyage de la zone de texte
                setState(() {
                  textController.clear();
                });
              },
            )
          ]
      ),);
  }


  void _openAddWord() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Color(0xffCEDAE4),
        builder: (context){
      return AddWord();
    });

  }

}
