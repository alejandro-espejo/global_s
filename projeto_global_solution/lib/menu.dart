import 'package:flutter/material.dart';
import 'package:projeto_global_solution/cadastro.dart';
import 'package:projeto_global_solution/empresas.dart';
import 'package:projeto_global_solution/home.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}): super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Menu> {

  int _currentIndex = 1;
  var tabs = [
    const Empresas(),
    const Home(),
    const Cadastro(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Solution'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Lista de Empresas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Cadastrar Empresa',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}