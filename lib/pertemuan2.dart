import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pertemuan 2',
      theme: ThemeData(
        primaryColor: Colors.red,
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// run flutter menggunakan terminal
// flutter run -t lib/pertemuan2.dart --debug
class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Pertemuan 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Ini Adalah Contoh Widget Text"),
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
              child: Text("Ini Adalah Contoh Widget Container"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                  child: Text("Ini Adalah Contoh Widget Container"),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.green,
                  child: Text("Ini Adalah Contoh Widget Container"),
                ),
              ],
            ),
            Icon(
              Icons.home,
              color: Colors.amber,
            ),
            Image.network(
                "https://images.unsplash.com/photo-1641932972937-65b58261d746?q=80&w=1031&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
          ],
        ),
      ),
    );
  }
}
