import "package:flutter/material.dart";
import 'package:loja_virtual_version2/helpers/validators.dart';
import 'package:loja_virtual_version2/models/user.dart';
import 'package:loja_virtual_version2/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   
  @override
  Widget build(BuildContext context) {

    bool hidePass = true; 

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)
                ),
              ),
              padding: EdgeInsets.all(12),
              child: Text(
                'Cadastrar-se',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (context, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      enabled: !userManager.loading,
                      controller: emailController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "E-mail",
                        icon: Icon(Icons.alternate_email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email)) return 'E-mail inválido';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      maxLength: 6,
                      decoration: InputDecoration(
                          hintText: "Senha", 
                          icon: Icon(Icons.lock_outline),
                          suffix: IconButton(
                            onPressed: (){
                              hidePass = !hidePass;
                              print(hidePass.toString() + "_______________________________________________________");
                            },
                            icon: hidePass
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          ),
                        ),
                      autocorrect: false,
                      obscureText: hidePass,
                      validator: (pass) {
                        if (pass.isEmpty || pass.length < 6) {
                          return "Senha inválida.";
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        child: const Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  userManager.signIn(
                                      user: User(
                                        email: emailController.text,
                                        password: passController.text,
                                      ),
                                      onFail: (e) {
                                        scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text("Falha ao entrar $e"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      onSuccess: () {
                                        print("Sucesso ao fazer SignIN______________________________");
                                        Navigator.of(context).pop();
                                      }
                                  );
                                }
                              },
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: userManager.loading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                  strokeWidth: 2,
                                ))
                            : Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
