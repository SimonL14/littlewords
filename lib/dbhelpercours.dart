import 'dart:async';
import 'package:path/path.dart';
import 'package:littlewords/word_dto.dart';
import 'package:sqflite/sqflite.dart';

// Class qui permet de centralser la connexion, la création de la base de donnée
class DbHelper{
  // Création de constantes (dbName = nom base de donnée // dbPathName = nom du fichier sur le tel qui stock les données // dbVersion = version de la bdd)
  static const dbName = 'littlewords.db'; // nom schema
  static const dbPathName = 'littlewords.path'; // nom du fichier sur le tel
  static const dbVersion = 3; // numéro de version du schema (pour les upgrades)

  //Instance de connexion à la base de donnée
  static Database? _database;

  //Constructeur de DbHelper
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  // Si "_database" n'existe pas le "_initDatabase()" vas l'initialiser // getter de la base de donnée
  Future<Database> get database async => _database ??= await _initDatabase();

  // Création de la database
  Future<Database> _initDatabase() async{
    // On utilise path pour récup un emplacement de stockage
    final String dbPath = await getDatabasesPath();
    //On ouvre la connexion
    return await openDatabase(
      join(dbPath, dbPathName),
      version: dbVersion,
      //onCreate permet de créer la base de donnée si elle existe pas
      onCreate: _onCreate,
      //onUpgrade permet d'augmenter le schéma de la bdd vers la nouvelle version
      onUpgrade: _onUpgrade,
    );
  }
  //Déclenché lorsque la base de données n'existe pas sur le tel
  Future _onCreate(Database db, int version) async{
    const String createWordsTableQuery = 'CREATE TABLE words(uid integer PRIMARY KEY AUTOINCREMENT,author VARCHAR(200) NOT NULL, content VARCHAR(200) NOT NULL,latitude double NOT NULL,longitude double NOT NULL, wordsId integer NOT NULL)';
    db.execute(createWordsTableQuery);
  }

  //Déclenché losque le numéro de version est augmenté
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion){
    // Pour simplifié, on drop les tables ici
    // NE PAS FAIRE EN PRODUCTION !!!!!!!! (sauf avec un adulte...)
    const String dropWordsTableQuery = 'DROP TABLE IF EXISTS words';
    db.execute(dropWordsTableQuery);

    //On recréer la db
    _onCreate(db, newVersion);
  }

  //Permet d'insert dans une base de donnée
  Future<void> insert(final WordDTO wordDTO) async{
    //Récupération de l'instance de la db
    Database db = await instance.database;
    final String insertWord = "INSERT into words (author,content,latitude,longitude,wordsId) values ('${wordDTO.author}','${wordDTO.content}','${wordDTO.latitude}','${wordDTO.longitude}','${wordDTO.wordsId}')";
    var execute = db.execute(insertWord);
    print('insert ');
    return execute;
  }

  // Permet de récupérer le nombre de mots dans la base de donnée
  Future<int> countWords() async {
    //Récupération de l'instance de la db
    final Database db = await instance.database;
    var res = await db.rawQuery("SELECT count(*) from words");
    var count = Sqflite.firstIntValue(res);
    return Future.value(count);
  }

  //Permet de récupérer la liste complete des mots détenus
  Future<List<WordDTO>> getAllWords() async {
    //Récupération de l'instance de la db
    Database db = await instance.database;

    // execution query
    final resultSet =
        await db.rawQuery("SELECT * from words");

    // On initialise un liste de mot vide
    final List<WordDTO> results = <WordDTO>[];

    //On parcours les résultats
    for (var r in resultSet){
      // on instancie un WordDTO sur la base de r
      var word = WordDTO.fromMap(r);
      // on l'ajoute sand la liste de resultat
      results.add(word);
    }
    // On retourne la liste de résultats
    return Future.value(results);

  }

  //Permet d'insert dans une base de donnée
  Future<void> delete(int uid) async{
    //Récupération de l'instance de la db
    Database db = await instance.database;
    final String deleteWord = "DELETE FROM words WHERE id ='$uid'";
    var execute = db.execute(deleteWord);
    print('delete');
    return execute;
  }

}