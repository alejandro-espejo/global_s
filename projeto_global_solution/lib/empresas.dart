import 'package:flutter/material.dart';
import 'package:projeto_global_solution/helper/anotacao_helper.dart';
import 'package:projeto_global_solution/model/empresa.dart';

class Empresas extends StatefulWidget {
  const Empresas({Key? key}) : super(key: key);

  @override
  _EmpresasState createState() => _EmpresasState();
}

class _EmpresasState extends State<Empresas> {
  String nomeController = "";
  String segmentoController = "";
  String emailController = "";
  String telefoneController = "";
  String descricaoController = "";
  final _db = AnotacaoHelper();
  double heightSize = 0.0;
  List<Empresa> _empresas = <Empresa>[];

  @override
  void initState() {
    super.initState();
    _recuperarEmpresas();
  }

  @override
  Widget build(BuildContext context) {
    heightSize = MediaQuery.of(context).size.height * 0.88;
    return Scaffold(
      body: SizedBox(
        height: heightSize,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _empresas.length,
                itemBuilder: (context, index) {
                  final empresa = _empresas[index];
                  return Card(
                    child: ListTile(
                      title: Text(empresa.nome),
                      subtitle: Text('Segmento: ${empresa.segmento}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _exibirMaisInformacoes(empresa: empresa);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.view_list,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _removerEmpresa(empresa.id!);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _removerEmpresa(int id) async {
    await _db.removerEmpresa(id);

    _recuperarEmpresas();
  }

  _recuperarEmpresas() async {
    List empresasRecuperadas = await _db.recuperarEmpresas();

    List<Empresa> listaTemporaria = <Empresa>[];
    for (var item in empresasRecuperadas) {
      Empresa compra = Empresa.fromMap(item);
      listaTemporaria.add(compra);
    }

    setState(() {
      _empresas = listaTemporaria;
    });

    listaTemporaria = [];
  }
  
  _exibirMaisInformacoes({Empresa? empresa}) {
    if(empresa != null) {
      nomeController = empresa.nome;
      segmentoController = empresa.segmento;
      emailController = empresa.email;
      telefoneController = empresa.telefone;
      descricaoController = empresa.descricao;

      _exibirModalInformacoes();
    }
  }

  _exibirModalInformacoes() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Informações"),
          content: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(nomeController, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900,)),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text("Segmento: $segmentoController"),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text("Email: $emailController"),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text("Telefone: $telefoneController"),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text("Descrição: $descricaoController"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }
}