import 'dart:io';
import 'package:mongo5a/models/group_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoService {
  //Un único punto de acceso
  static final MongoService _instance = MongoService._internal();

  //La base de datos a conectar
  late mongo.Db _db;

  MongoService._internal();

  factory MongoService(){
    return _instance;
  }

  Future<void> connect() async {
    try{
      _db = await mongo.Db.create('mongodb+srv://evelynsebastiansilverio:GRTDgQTzKKRpc1tn@cluster0.rcnky.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
    await _db.open();
    _db.databaseName = 'musica';
    print('Conexión exitosa a MongoDB');
    } on SocketException catch(e){
      print('Error de conexión: $e');
      rethrow;
    }
  }

  mongo.Db get db {
    if (!_db.isConnected){
      throw StateError('Base de datos no inicializada, llama a connect() primero');
    }
    return _db;
  }

  Future<List<GroupModel>> getGroups() async {
    final collection = db.collection('grupos');
    print('Colección obtenida: $collection');
    var groups = await collection.find().toList();
    print('En get groups: $groups');
    if (groups.isEmpty){
      print('No se encontraron datos en la colección');
    }
    return groups.map((grupo) => GroupModel.fromJson(grupo)).toList();
  }
}
