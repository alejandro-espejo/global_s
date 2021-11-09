import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body:  Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('assets/images/icone.png', width: 200, height: 200),
            Container(margin: const EdgeInsets.all(10), child: const Text('Olá, este aplicativo é voltado para quem busca uma empresa sustentável e de empresas que gostariam de anunciam os seus serviços.'))
          ],
        ),
      ),
    );
  }
}