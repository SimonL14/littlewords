import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/version.dto.dart';

//Provider d'une instance unique de Dio
// Dio permet de faire des requêtes HTTP
final dioProvider = Provider<Dio>((ref){
  var baseOptions = BaseOptions(

    //On défini les options que l'on souhaite donner à Dio
    baseUrl: 'https://backend.smallwords.samyn.ovh',
    connectTimeout:10000,
    receiveTimeout: 10000,
  );

  //Construction de Dio avec les options
  return Dio(baseOptions);
});

//Provider du numéro de version du backend / Le FutureProvider sont comme les promises en javascript
final backendVersionProvider = FutureProvider<String>((ref) async{
  //On récupère l'instance de Dio
  final dio = ref.read(dioProvider);
    // On fait une requête get sur l'URL /up // await = le traitement vas attendre que ce soit fini avant d'envoyer un resultat
  final response = await dio.get('/up');

  //On convertit la réponse en Json
  var jsonAsString = response.toString();
  var json = jsonDecode(jsonAsString);
  final VersionDTO versionDTO = VersionDTO.fromJson(json);
  //on retourne la réponse
  return versionDTO.version;
});