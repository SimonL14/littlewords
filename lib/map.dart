import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/word_dto.dart';
import 'package:littlewords/words_around.provider.dart';

class WordsAroundMarkerLayer extends ConsumerWidget {
  const WordsAroundMarkerLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(wordsAroundProvider).map(data: (data){
      final List<WordDTO> words = data.value;
      var markers = <Marker>[];
      for(final WordDTO w in words){
        var wordPosition = LatLng(w.latitude!, w.longitude!);
        markers.add(Marker(point: wordPosition, builder: (context){
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