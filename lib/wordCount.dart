import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/wordCountProvider.dart';

import 'dio.provider.dart';

class WordCount extends StatelessWidget {
  const WordCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(BuildContext context, WidgetRef ref, Widget ? child){
        // On utilise ref pour "lire" notre provider
        AsyncValue<int> read = ref.watch(wordCountProvider);
        //On gère les 3 cas :
        // - donnée reçue
        // - erreur dans le traitement
        // - loading...
        return read.when(data: (int data){

          return Text(data.toString());
        }, error: (error, stack){
          return const Text('Impossible de récupèrer les mots');
        }, loading: (){
          return const CircularProgressIndicator();
        });
        //return Text('You have pushed the button this many times:');
      },);
  }
}
