
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/my_words.provider.dart';
import 'package:littlewords/word_dto.dart';

import 'dbhelpercours.dart';

class OnlineWord extends ConsumerWidget {
  const OnlineWord({super.key, required this.word});

  final WordDTO word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    return Container(
        height: 250,
        child: Center(
            child: Column(
                children: [

                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                    height: 50,
                    child: Center(child: Text('De : ${word.author}'/* changé en fonction de la variable (nom de l'auteur) */, style: TextStyle(fontSize: 20),)),
                  ),
//------------------------------------textbox------------------------------------------
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.75,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                            Radius.circular(10.0))

                    ),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),

                      child: Center(
                        child: Text(
                          '${word.content}',/* changé en fonction de la variable (message) */
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),

                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            child: MaterialButton(
                              child: Image.asset('Assets/import.png'),
                              onPressed: () {
                                // code for first button press
                              },
                            ),
                          ),
                        ],
                      )
                  )
                ]
            )));
  }
}
