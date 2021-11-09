import 'package:flutter/material.dart';

import 'helper/anotacao_helper.dart';
import 'model/empresa.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Cadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _segmentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final _db = AnotacaoHelper();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold (
      body:  Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Center(
                  child:  Text(
                    'Cadastro de Empresa',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O Campo não pode estar vazio';
                    }
                    return null;
                  },
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Empresa',
                    hintText: 'Digite o nome da empresa...',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O Campo não pode estar vazio';
                    }
                    return null;
                  },
                  controller: _segmentoController,
                  decoration: const InputDecoration(
                    labelText: 'Segmento da Empresa',
                    hintText: 'Digite...',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O Campo não pode estar vazio';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail:',
                    hintText: 'Digite...',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    String pattern = r'([0-9])';
                    RegExp regExp = RegExp(pattern);
                    if(value == null || value.isEmpty) {
                      return 'O Campo não pode estar vazio';
                    } else if(!regExp.hasMatch(value)) {
                    return 'Somente números';
                  }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _telefoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone:',
                    hintText: 'Digite...',
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O Campo não pode estar vazio';
                    }
                    return null;
                  },
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Prestação de serviço da empresa:',
                    hintText: 'Digite o serviço que a empresa presta e as práticas sustentáveis que a sua empresa faz...',
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 20,),
                  height: 60,
                  width: size,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()) {
                        _salvarEmpresa();
                      } 
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                    ),
                    child: const Text('Cadastrar', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  _salvarEmpresa() async {

    Empresa empresa = Empresa(
      nome: _nomeController.text,
      segmento: _segmentoController.text,
      email: _emailController.text,
      telefone: _telefoneController.text,
      descricao: _descricaoController.text
    );
    await _db.salvarEmpresa(empresa);

    _nomeController.text = "";
    _segmentoController.text = "";
    _emailController.text = "";
    _telefoneController.text = "";
    _descricaoController.text = "";

    _exibirModalCadastroSucesso();
  }

  _exibirModalCadastroSucesso() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sucesso!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
               Center(
                 child: Text('Empresa cadastrada com sucesso!')
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