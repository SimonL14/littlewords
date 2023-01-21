import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/word_dto.dart';

import 'dbhelpercours.dart';

class wordDetail extends ConsumerWidget {
  final txtInput = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 300,
        child: Center(
            child: Column(
                children: [
//----------------------------------button close---------------------------------------
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color(0xff9BCAE9), width: 5, style: BorderStyle.solid)),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    width: 50,
                    height: 50,
                    child: FloatingActionButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text('X'),
                      backgroundColor: Color(0xffCEDAE4),
                      foregroundColor: Color(0xff9BCAE9),
                    ),
                  ),
//------------------------------------textbox------------------------------------------
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(Radius.circular(10.0))

                    ),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),

                      child: TextField(
                        decoration: InputDecoration(
                          filled: true, //<-- SEE HERE
                          fillColor: Color(0xFF5CB2E8),
                          labelText: 'mot................',
                        ),
                      ),
                    ),
                  ),
//----------------------------------button send----------------------------------------
                  ElevatedButton(onPressed: () async{
                    Navigator.pop(context);
                    final WordDTO w = WordDTO(null,"test", txtInput.text, 11111, 11111);
                    DbHelper.instance.insert(w);
                  },
                    child: Text('Envoyer'),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFC92A2A),
                        fixedSize: Size(150, 50)
                    ),
                  ),
                  //----------------------------------button delete----------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        onPressed: _test,
                        tooltip: 'Increment',
                        child: const Icon(Icons.delete_outline),
                      ),
                      FloatingActionButton(
                        onPressed: _test,
                        tooltip: 'Increment',
                        child: const Icon(Icons.save_alt),
                      ),
                      FloatingActionButton(
                        onPressed: _test,
                        tooltip: 'Increment',
                        child: const Icon(Icons.ios_share),
                      ),
                    ],
                  )
                ]
            )));
  }

  void _test() {
          print("yesy");
  }
}