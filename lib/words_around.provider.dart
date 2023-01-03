import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/device_location.provider.dart';
import 'package:littlewords/dio.provider.dart';
import 'package:littlewords/word_dto.dart';
import 'package:littlewords/words_dto.dart';

final wordsAroundProvider = FutureProvider<List<WordDTO>>((ref) async {
  return ref
      .watch(deviceLocationProvider)
      .when(data: (data) => _onData(data, ref), error: _onError, loading: _onLoading);
});

FutureOr<List<WordDTO>> _onData(LatLng? data, ref) async {

  if(null == data) return [];

  print(
      'try to get words around ${data.latitude} ${data.longitude}');

  final Dio dio = ref.read(dioProvider);

  Response response = await dio.get(
      '/word/around?latitude=${data.latitude}&longitude=${data.longitude}');

  var jsonAsString = response.toString();
  var json = jsonDecode(jsonAsString);

  final WordsDTO wordsDTO = WordsDTO.fromJson(json);
  if (wordsDTO.data == null) {
    return Future.value([]);
  }

  print('test $wordsDTO');
  return Future.value(wordsDTO.data!);
}

FutureOr<List<WordDTO>> _onError(Object error, StackTrace stackTrace) {
  return [];
}

FutureOr<List<WordDTO>> _onLoading() {
  return [];
}