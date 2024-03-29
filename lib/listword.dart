
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/my_words.provider.dart';
import 'package:littlewords/word_dto.dart';

import 'myword.dart';

class ListWord extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 600,
        child: Column(
            children: [
              const Text('Mes mots:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Expanded(
                child: WordsList(),
              )

            ]
        ));
  }

}

class WordsList extends ConsumerWidget {
  const WordsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(myWordsProvider).when(data: _onData, error: _onError, loading: _onLoading);
  }

  Widget _onData(List<WordDTO> words) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: words.length,
      itemBuilder: (BuildContext context, int index) {
        print(index);
        var word = words[index];
        return Word(word:word);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _onLoading() {
    return const CircularProgressIndicator();
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    print(error);
    return const Text('erreur' );
  }
}

class Word extends StatelessWidget {
  const Word({
    Key? key, required this.word
  }) : super(key: key);

  final WordDTO word;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Show new showModalBottomSheet here
        showModalBottomSheet(
          context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            backgroundColor: Color(0xffCEDAE4),
            builder: (context) {
              return MyWord(word: word);
            });
      },
      child: Container(
        height: 50,
        color: Color(0xFF7DC1ED),
        child: Center(child: Text('Mot : ${word.content}, De : ${word.author}')),
      ),
    );
  }
}