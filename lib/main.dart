import 'package:flutter/material.dart';
import 'package:flutter_database/provider/transections_pv.dart';
import 'package:flutter_database/screen/form.dart';
import 'package:flutter_database/screen/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: '/',
        onGenerateRoute: (RouteSettings setting) {
          switch (setting.name) {
            case "/":
              return MaterialPageRoute(builder: (context) => HomeScreen());
            case "/form":
              return MaterialPageRoute(builder: (context) => FormScreen(), fullscreenDialog: true);
          }
        },
      ),
    );
  }
}
