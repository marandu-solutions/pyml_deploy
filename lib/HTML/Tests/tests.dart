import 'dart:async';
import 'package:flutter/material.dart';

import '../../Data/Service/codes_service.dart';
import '../Sucess_Page/sucess_page.dart';

class TestingScreen extends StatefulWidget {
  final String code;

  TestingScreen({required this.code});

  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final List<String> procedures = [
    "Validando código...",
    "Executando testes de sintaxe...",
    "Verificando compatibilidade...",
    "Finalizando execução..."
  ];

  int currentProcedure = 0; // Índice do procedimento atual
  bool isCodeValid = true; // Define se o código é válido

  @override
  void initState() {
    super.initState();
    _validateCodeAndRunProcedures();
  }

  // Função para validar o código e simular a execução dos procedimentos
  void _validateCodeAndRunProcedures() async {
    final codeService = CodeService();

    // Valida o código
    isCodeValid = await codeService.isCodeEqual(widget.code);

    if (!isCodeValid) {
      setState(() {
        currentProcedure = procedures.length; // Finaliza o processo
      });
      // Aguarda 1 segundo e navega para a SuccessScreen
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(isSuccess: false),
          ),
        );
      }
      return;
    }

    // Executa os procedimentos sequenciais se o código for válido
    for (int i = 0; i < procedures.length; i++) {
      await Future.delayed(Duration(milliseconds: 1500)); // Simula o tempo de execução
      setState(() {
        currentProcedure++; // Avança para o próximo procedimento
      });
    }

    // Aguarda 1 segundo após finalizar todos os procedimentos
    await Future.delayed(Duration(seconds: 1));

    // Navega para a SuccessScreen
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(isSuccess: true),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Executando Testes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aguarde enquanto verificamos o código:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: procedures.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            procedures[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        if (!isCodeValid)
                          Icon(Icons.cancel, color: Colors.red, size: 24)
                        else if (index < currentProcedure)
                          Icon(Icons.check_circle, color: Colors.green, size: 24)
                        else if (index == currentProcedure)
                            CircularProgressIndicator()
                          else
                            SizedBox(width: 24), // Espaço vazio para alinhamento
                      ],
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
}