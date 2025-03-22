# Praktikum Flutter Pertemuan 3: Widget Interaktif dan Layout Lanjutan

## Tujuan
1. Menggunakan widget interaktif seperti Button dan GestureDetector.
2. Membuat layout yang lebih kompleks menggunakan widget lanjutan seperti Stack dan ListView.
3. Mengelola state pada aplikasi Flutter dengan lebih baik.
4. Memahami konsep navigasi antar halaman pada Flutter.

## Materi
### 1. Widget Interaktif
- **Button**: Menggunakan berbagai jenis button seperti ElevatedButton, TextButton, dan IconButton untuk interaksi pengguna.
- **GestureDetector**: Widget yang dapat mendeteksi berbagai jenis gestur seperti tap, double tap, long press, dan swipe.

### 2. Layout Lanjutan
- **Stack**: Widget yang digunakan untuk menumpuk widget satu di atas yang lain.
- **ListView**: Widget yang digunakan untuk menampilkan daftar item secara vertikal yang dapat di-scroll.

### 3. Pengelolaan State
Pengelolaan state yang lebih kompleks menggunakan setState, dan pengenalan state management library seperti Provider.

### 4. Navigasi
Navigasi antar halaman menggunakan Navigator dan Route pada Flutter.

## Langkah Praktikum
### Persiapan
1. Pastikan Flutter dan Dart sudah terinstal dengan benar.
2. Buat project baru dengan menjalankan perintah berikut:
    ```sh
    flutter create praktikum_pertemuan_3
    cd praktikum_pertemuan_3
    ```

### Praktikum
#### 1. Menggunakan Button
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

    class MyHomePage extends StatefulWidget {
      @override
      _MyHomePageState createState() => _MyHomePageState();
    }

    class _MyHomePageState extends State<MyHomePage> {
      String _message = "Hello, Flutter!";

      void _updateMessage() {
        setState(() {
          _message = "Button Pressed!";
        });
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Button Example'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_message),
                ElevatedButton(
                  onPressed: _updateMessage,
                  child: Text('Press Me'),
                ),
              ],
            ),
          ),
        );
      }
    }
    ```
3. Jalankan aplikasi dengan perintah:
    ```sh
    flutter run
    ```
4. Observasi bagaimana aplikasi merespon ketika tombol ditekan.

#### 2. Menggunakan GestureDetector
1. Buka file `lib/main.dart`.
2. Tambahkan kode berikut di dalam file:
    ```dart name=lib/main.dart
    class GestureDetectorExample extends StatefulWidget {
      @override
      _GestureDetectorExampleState createState() => _GestureDetectorExampleState();
    }

    class _GestureDetectorExampleState extends State<GestureDetectorExample> {
      String _message = "Tap the box!";

      void _onTap() {
        setState(() {
          _message = "Box Tapped!";
        });
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('GestureDetector Example'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _onTap,
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text('Tap Me'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(_message),
              ],
            ),
          ),
        );
      }
    }
    ```
3. Update `MyApp` untuk menggunakan `GestureDetectorExample`:
    ```dart name=lib/main.dart
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: GestureDetectorExample(),
        );
      }
    }
    ```
4. Jalankan aplikasi dan observasi bagaimana aplikasi merespon ketika kotak ditekan.

#### 3. Menggunakan Stack dan ListView
1. Tambahkan kode berikut di dalam file:
    ```dart name=lib/main.dart
    class LayoutExample extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Layout Example'),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 200,
                width: 200,
              ),
              Positioned(
                top: 50,
                left: 50,
                child: Container(
                  color: Colors.green,
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
        );
      }
    }

    class ListViewExample extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ListView Example'),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Album'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone'),
              ),
            ],
          ),
        );
      }
    }
    ```
2. Update `MyApp` untuk menggunakan `LayoutExample` atau `ListViewExample`:
    ```dart name=lib/main.dart
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LayoutExample(), // Ganti dengan ListViewExample() untuk contoh ListView
        );
      }
    }
    ```
3. Jalankan aplikasi dan observasi bagaimana layout Stack dan ListView bekerja.

#### 4. Navigasi Antar Halaman
1. Tambahkan halaman baru `SecondPage` di dalam file:
    ```dart name=lib/main.dart
    class SecondPage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Second Page'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ),
        );
      }
    }
    ```
2. Update `MyHomePage` untuk menavigasi ke `SecondPage`:
    ```dart name=lib/main.dart
    class MyHomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Navigator Example'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Text('Go to Second Page'),
            ),
          ),
        );
      }
    }
    ```
3. Update `MyApp` untuk menggunakan `MyHomePage`:
    ```dart name=lib/main.dart
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
    ```
4. Jalankan aplikasi dan observasi bagaimana navigasi antar halaman bekerja.

## Tugas
1. Buatlah aplikasi yang memiliki dua halaman. Halaman pertama menampilkan daftar item menggunakan ListView. Ketika item ditekan, navigasikan ke halaman kedua yang menampilkan detail item tersebut.
2. Gunakan GestureDetector untuk membuat interaksi pada halaman kedua yang mengubah tampilan atau data yang ditampilkan.

### Contoh Tugas:
#### 1. Halaman Pertama dengan ListView
```dart name=lib/main.dart
class ItemListPage extends StatelessWidget {
  final List<String> items = List<String>.generate(10, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailPage(item: items[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}