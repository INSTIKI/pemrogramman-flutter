# Praktikum Flutter Pertemuan 2: Widget Dasar

## Tujuan
1. Memahami konsep dasar widget pada Flutter.
2. Membedakan antara StatelessWidget dan StatefulWidget.
3. Menggunakan widget dasar seperti Text, Container, Column, Row, Image, dan Icon.
4. Membuat layout sederhana menggunakan widget-widget dasar.

## Materi
### 1. Pengertian Widget pada Flutter
Widget adalah elemen dasar dalam Flutter yang digunakan untuk membangun UI. Setiap elemen UI pada Flutter adalah widget, baik itu layout, text, button, atau gambar. Widget pada Flutter bersifat composable, artinya widget dapat terdiri dari widget-widget lainnya.

### 2. StatelessWidget vs StatefulWidget
- **StatelessWidget**: Digunakan untuk widget yang tidak memiliki state yang berubah. StatelessWidget bersifat immutable, artinya sekali widget dibuat, tidak bisa diubah. Cocok digunakan untuk UI yang statis.
- **StatefulWidget**: Digunakan untuk widget yang memiliki state yang dapat berubah-ubah selama aplikasi berjalan. StatefulWidget bersifat mutable, artinya dapat berubah sesuai dengan interaksi pengguna atau data yang diterima. Cocok digunakan untuk UI yang dinamis dan interaktif.

### 3. Widget Dasar
- **Text**: Digunakan untuk menampilkan teks.
- **Container**: Widget serbaguna yang dapat digunakan untuk layout, styling, dan positioning.
- **Column**: Digunakan untuk menampilkan widget secara vertikal.
- **Row**: Digunakan untuk menampilkan widget secara horizontal.
- **Image**: Digunakan untuk menampilkan gambar.
- **Icon**: Digunakan untuk menampilkan ikon.

## Langkah Praktikum
### Persiapan
1. Pastikan Flutter dan Dart sudah terinstal dengan benar.
2. Buat project baru dengan menjalankan perintah berikut:
    ```sh
    flutter create praktikum_pertemuan_2
    cd praktikum_pertemuan_2
    ```

### Praktikum
#### 1. Membuat StatelessWidget
1. Buka file `lib/main.dart`.
2. Ganti kode yang ada dengan kode berikut:
    ```dart name=lib/main.dart
    import 'package:flutter/material.dart';

    void main() {
      runApp(MyApp());
    }

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
         return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(),
         );
      }
    }

    class MyHomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
         return Scaffold(
            appBar: AppBar(
              title: Text('StatelessWidget Example'),
            ),
            body: Center(
              child: Text('Hello, Flutter!'),
            ),
         );
      }
    }
    ```
3. Jalankan aplikasi dengan perintah:
    ```sh
    flutter run
    ```
4. Observasi bagaimana aplikasi menampilkan teks "Hello, Flutter!" menggunakan `StatelessWidget`.

#### 2. Membuat StatefulWidget
1. Buka file `lib/main.dart`.
2. Tambahkan kode berikut di dalam file:
    ```dart name=lib/main.dart
    class MyHomePageStateful extends StatefulWidget {
      @override
      _MyHomePageStatefulState createState() => _MyHomePageStatefulState();
    }

    class _MyHomePageStatefulState extends State<MyHomePageStateful> {
      int _counter = 0;

      void _incrementCounter() {
         setState(() {
            _counter++;
         });
      }

      @override
      Widget build(BuildContext context) {
         return Scaffold(
            appBar: AppBar(
              title: Text('StatefulWidget Example'),
            ),
            body: Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                 ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
         );
      }
    }
    ```
3. Update `MyApp` untuk menggunakan `MyHomePageStateful`:
    ```dart name=lib/main.dart
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
         return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePageStateful(),
         );
      }
    }
    ```
4. Jalankan aplikasi dan observasi bagaimana aplikasi menampilkan counter yang dapat diincrement menggunakan tombol FloatingActionButton.

#### 3. Menggunakan Widget Dasar
1. Tambahkan widget `Container`, `Column`, `Row`, `Image`, dan `Icon` di dalam `MyHomePage` atau `MyHomePageStateful` untuk membuat layout lebih kompleks.
2. Contoh penggunaan di dalam `MyHomePageStateful`:
    ```dart name=lib/main.dart
    class _MyHomePageStatefulState extends State<MyHomePageStateful> {
      int _counter = 0;

      void _incrementCounter() {
         setState(() {
            _counter++;
         });
      }

      @override
      Widget build(BuildContext context) {
         return Scaffold(
            appBar: AppBar(
              title: Text('StatefulWidget Example'),
            ),
            body: Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.blue,
                      child: Center(
                         child: Text('Container'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         Icon(Icons.star, color: Colors.yellow),
                         Text('Row Item'),
                      ],
                    ),
                    Image.network('https://flutter.dev/images/flutter-logo-sharing.png'),
                 ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
         );
      }
    }
    ```
3. Jalankan aplikasi dan observasi bagaimana layout berubah dengan penambahan widget.

## Tugas
1. Buatlah `StatelessWidget` yang menampilkan teks "Welcome to Flutter" dengan styling yang berbeda.
2. Buatlah `StatefulWidget` yang menampilkan counter dengan tombol increment dan decrement.
3. Gunakan widget `Container`, `Column`, `Row`, `Image`, dan `Icon` untuk membuat layout sederhana.

### Contoh Tugas:
#### 1. `StatelessWidget` dengan Styling
```dart name=lib/main.dart
class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Text('Welcome StatelessWidget'),
        ),
        body: Center(
          child: Text(
             'Welcome to Flutter',
             style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
             ),
          ),
        ),
     );
  }
}
```

#### 2. `StatefulWidget` dengan Increment dan Decrement
```dart name=lib/main.dart
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
     setState(() {
        _counter++;
     });
  }

  void _decrementCounter() {
     setState(() {
        _counter--;
     });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Text('Counter StatefulWidget'),
        ),
        body: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
             ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
             FloatingActionButton(
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
             ),
             SizedBox(width: 10),
             FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
             ),
          ],
        ),
     );
  }
}
```

## Kesimpulan
Pada pertemuan ini, mahasiswa telah mempelajari konsep dasar widget pada Flutter, perbedaan antara `StatelessWidget` dan `StatefulWidget`, serta penggunaan widget dasar dalam pembuatan aplikasi Flutter. Mahasiswa juga telah berlatih membuat layout sederhana menggunakan widget `Container`, `Column`, `Row`, `Image`, dan `Icon`.

## Review dan Diskusi
1. Apa perbedaan utama antara `StatelessWidget` dan `StatefulWidget`?
2. Kapan sebaiknya menggunakan `StatefulWidget` dalam pengembangan aplikasi?
3. Bagaimana cara melakukan styling pada widget `Text`?
4. Diskusikan kegunaan widget `Container` dalam membuat layout yang kompleks.
5. Bagaimana cara menambahkan gambar dari internet menggunakan widget `Image`?
6. Apa saja properti yang dapat digunakan untuk mengatur tampilan widget `Icon`?