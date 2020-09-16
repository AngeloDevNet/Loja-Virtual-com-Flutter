import "package:flutter/material.dart";
import 'package:loja_virtual_version2/helpers/validators.dart';
import 'package:loja_virtual_version2/models/user.dart';
import 'package:loja_virtual_version2/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild SignUpScreen");
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    enabled: !userManager.loading,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Nome Completo',
                      icon: Icon(Icons.person_outline),
                    ),
                    validator: (name) {
                      if (name.isEmpty)
                        return "Campo Obrigatório";
                      else if (name.trim().split(" ").length <= 1)
                        return "Preencha seu nome completo";
                      return null;
                    },
                    onSaved: (name) => user.name = name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      icon: Icon(Icons.alternate_email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email.isEmpty || !emailValid(email))
                        return "E-mail inválido";
                      return null;
                    },
                    onSaved: (email) => user.email = email,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                      icon: Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty) {
                        return "Campo obrigatório";
                      } else if (pass.length < 6) {
                        return "Senha pequena";
                      }
                      return null;
                    },
                    onSaved: (pass) => user.password = pass,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    maxLength: 6,
                    decoration: const InputDecoration(
                        hintText: 'Repita a Senha',
                        icon: Icon(Icons.lock_outline)),
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty)
                        return "Campo obrigatório";
                      else if (pass.length < 6) return "Senha pequena";
                      return null;
                    },
                    onSaved: (pass) => user.confirmPassword = pass,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                if (user.password != user.confirmPassword) {
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          const Text("Senhas não coincidem!"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                // user manager
                                context.read<UserManager>().signUp(
                                    user: user,
                                    onSuccess: () {
                                      debugPrint(
                                          "_________SUCESSO AO SE CADASTRAR_________");
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      debugPrint(
                                          "_________ERRO AO SE CADASTRAR_________");
                                      scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Falha ao cadastrar: $e"),
                                          backgroundColor: Colors.red[800],
                                        ),
                                      );
                                    });
                              }
                            },
                      child: userManager.loading
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).primaryColor),
                            )
                          : Text(
                              'Criar Conta',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
