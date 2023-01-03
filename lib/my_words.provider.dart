import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/dbhelpercours.dart';
import 'package:littlewords/word_dto.dart';

final myWordsProvider = FutureProvider<List<WordDTO>>((ref) async {
  DbHelper instance = DbHelper.instance;
  List<WordDTO> allWords = await instance.getAllWords();
  return allWords;
});
