import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'package:loja_virtual_version2/models/product_manager.dart';
import 'package:loja_virtual_version2/screens/base/base_screens.dart';
import 'package:loja_virtual_version2/screens/product/product_screen.dart';
import 'package:provider/provider.dart';
import 'models/user_manager.dart';
import 'package:loja_virtual_version2/screens/signup/signup_screen.dart';
import "screens/login/login_screen.dart";

void main() {
  runApp(MyApp());
}

// LAZY = Se true, ele só irar ler o "User Maneger" qnd ele for chamado em algum lugar. Se false, ele já ler automaticamente sem ser chamado
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,        //PREGUIÇOSO FALSO
        ),
        ChangeNotifierProvider(
          create: (_)=> ProductManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Loja de Willys',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0, // nenhuma appBar com elevation
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/base",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen(),
              );
            case "/signup":
              return MaterialPageRoute(
                builder: (_) => SignUpScreen(),
              );
            case "/product":
              return MaterialPageRoute(
                builder: (_) => ProductScreen(
                  settings.arguments as Product,
                ),
              );
            case "/base":
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
              );
          }
        },
      ),
    );
  }
}
