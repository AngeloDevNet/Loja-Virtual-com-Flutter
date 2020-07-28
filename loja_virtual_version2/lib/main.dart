import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/screens/base/base_screens.dart';
import 'package:provider/provider.dart';
import 'models/user_manager.dart';
import 'package:loja_virtual_version2/screens/signup/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserManager(),
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
        onGenerateRoute: (settings){
          switch(settings.name){
            case "/signup":
              return MaterialPageRoute(
                builder: (_) => SignUpScreen(),
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
