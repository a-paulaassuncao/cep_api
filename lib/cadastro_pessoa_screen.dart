import 'package:cep_api/servicos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroPessoaScreen extends StatefulWidget {
  const CadastroPessoaScreen({super.key});

  @override
  State<CadastroPessoaScreen> createState() => _CadastroPessoaScreenState();
}

class _CadastroPessoaScreenState extends State<CadastroPessoaScreen> {
  // Controladores para o formulário (Inputs)
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Cadastro de Pessoa',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, Insia o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, Insira o Email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Cep'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, Insira o Cep';
                  }
                  return null;
                },
                onChanged: (value) async {
                  if (value.length == 8) {
                    var endereco = await CepServico.buscaEnderecoPorCep(value);
                    if (endereco != null) {
                      setState(() {
                        _enderecoController.text = endereco['logradouro'] ?? '';
                        _bairroController.text = endereco['bairro'] ?? '';
                        _cidadeController.text = endereco['localidade'] ?? '';
                        _estadoController.text = endereco['uf'] ?? '';
                      });
                    }
                  }
                },
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, Insira o Endereço';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, Insira o Bairro';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, Insira o Cidade';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _estadoController,
                decoration: const InputDecoration(labelText: 'estado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, Insira o estado';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // ignore: avoid_print
                    print("Foi");
                  }
                },
                child: const Text('cadastrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
