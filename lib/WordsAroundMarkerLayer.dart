import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/word_dto.dart';
import 'package:littlewords/words_around.provider.dart';

import 'dio.provider.dart';

class WordsAroundMarkerLayer extends ConsumerWidget {
  const WordsAroundMarkerLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, final WidgetRef ref) {
    return ref.watch(wordsAroundProvider).map(data: (data){
      final List<WordDTO> words = data.value;
      var markers = <Marker>[];
      for(final WordDTO w in words){
        var wordPosition = LatLng(w.latitude!, w.longitude!);
        markers.add(Marker(
            point: wordPosition,
            builder: (context){

              //Simon, votre mission est de modifier ou d'adapter le code pour que ça marche ! Normalement le code est ok mais vous devez vérifier si c'est ok!
              onTap:(){
                var uid = w.uid.toString();
                var longitude = w.longitude.toString();
                var latitude = w.latitude.toString();
                
                Dio dio = ref.read(dioProvider);
                dio.get("/word?uid=" + uid + "&longitude=" + longitude + "&latitude=" + latitude)
                  .then((value) {
                    var valueStr = value.toString();
                    var json = jsonDecode(valueStr);
                    final WordDTO wordDTO = WordDTO.fromJson(json);
                    ref.refresh(wordsAroundProvider);
                });
              };





          return const Icon(Icons.message, size: 32,);
          }));
      }

      return MarkerLayer(markers: markers);
    }, error: (error){
      print(error);
      return Container(color: Colors.red.withOpacity(0.5),);
    }, loading: (loading){
      return const Center(child: CircularProgressIndicator());
    });
  }
}