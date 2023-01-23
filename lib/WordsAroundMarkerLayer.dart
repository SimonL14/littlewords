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
            width: 100,
            height: 100,
            builder: (context){
              return GestureDetector(
                child: Icon(Icons.message, size: 32,),
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ViewMessage(
                            word: wordDTO,
                          );
                        });
                  });
                },
              );
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
