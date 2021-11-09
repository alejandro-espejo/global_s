import 'package:projeto_global_solution/model/empresa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {
  static const String nomeTabela = 'empresa';

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database? _db;

  factory AnotacaoHelper() => _anotacaoHelper;

  AnotacaoHelper._internal();

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, 'banco_empresa');

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE $nomeTabela ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'nome VARCHAR, '
      'segmento  VARCHAR,'
      'email  VARCHAR,'
      'telefone  VARCHAR,'
      'descricao  VARCHAR'
      ')';
    await db.execute(sql);
  }

  Future<int> salvarEmpresa(Empresa empresa) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, empresa.toMap());
    // Irá retornar o id do cadastro.
    return resultado;
  }

  recuperarEmpresas() async {
    var bancoDados = await db;
    String sql = 'SELECT * FROM $nomeTabela ORDER BY id DESC';
    List empresas = await bancoDados.rawQuery(sql);
    return empresas;
  }

  Future<int> atualizarEmpresa(Empresa empresa) async {
    var bancoDados = await db;
    return await bancoDados.update(nomeTabela, empresa.toMap(), where: 'id = ?', whereArgs: [empresa.id]);
  }

  Future<int> removerEmpresa(int id) async {
    var bancoDados = await db;
    return await bancoDados.delete(nomeTabela, where: 'id = ?', whereArgs: [id]);
  }
}