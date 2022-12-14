import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/dbhelpercours.dart';

// Provider qui permet de récup les mots en base de donnée
final wordCountProvider = FutureProvider<int> ((ref) async{
  return DbHelper.instance.countWords();
});