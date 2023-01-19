import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/device_location.provider.dart';
import 'package:littlewords/my_words.provider.dart';
import 'package:littlewords/word_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dbhelpercours.dart';
import 'dio.provider.dart';

class AddWord extends ConsumerWidget {
  const AddWord({super.key, required this.ctrl});

  final TextEditingController ctrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    return Container(
        height: 300,
        child: Center(
            child: Column(children: [
//----------------------------------button close---------------------------------------
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Color(0xff9BCAE9),
                    width: 5,
                    style: BorderStyle.solid)),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: 50,
            height: 50,
            child: FloatingActionButton(
              onPressed: () {
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
                borderRadius: new BorderRadius.all(Radius.circular(10.0))),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: ctrl,
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Color(0xFF5CB2E8),
                  labelText: 'mot................',
                ),
              ),
            ),
          ),
//----------------------------------button send----------------------------------------
          _ValidCreateWordButton(ctrl:ctrl),
        ])));
  }
}

class _ValidCreateWordButton extends ConsumerWidget {
  const _ValidCreateWordButton({Key? key, required this.ctrl}) : super(key: key);


  final TextEditingController ctrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(deviceLocationProvider)
        .when(data: (data) => _data(data, ref, ctrl), error: _error, loading: _loading);
  }

  _data(LatLng? data, WidgetRef ref, TextEditingController ctrl) {
    return ElevatedButton(
      onPressed: () async {
        var prefs = await SharedPreferences.getInstance();
        final String? username = prefs.getString('username');
        final dio = ref.read(dioProvider);
        //Ajout dans la bdd du prof
        WordDTO w = WordDTO(null, username, ctrl.text, data!.latitude, data!.longitude);
         var res = await dio.post('/word', data: w);
        print(res.toString());
        // ref.refresh(myWordsProvider);

      },
      child: Text('Envoyer'),
      style: ElevatedButton.styleFrom(
          primary: Color(0xFFC92A2A), fixedSize: Size(150, 50)),
    );
  }

  Widget _error(object, trace) {
    return const Scaffold(
      body: Text("Erreur"),
    );
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

}
