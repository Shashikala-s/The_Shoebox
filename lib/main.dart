import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shoe_app/providers/CartProvider.dart';
import 'package:shoe_app/providers/ThemeProvider.dart';
import 'package:shoe_app/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
  ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: providers,
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: MyTheme.lightTheme,
            title: 'The Shoebox',
            initialRoute: '/',
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
