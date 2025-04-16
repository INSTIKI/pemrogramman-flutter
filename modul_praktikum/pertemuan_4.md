Here's the complete and enhanced version of your Flutter workshop material in markdown format:

```markdown
# Praktikum Flutter Pertemuan 4: State Management dan Integrasi API

## 📚 Tujuan Pembelajaran
1. Memahami konsep state management pada Flutter
2. Mengimplementasikan Provider untuk manajemen state
3. Melakukan integrasi API dengan package `http` dan `dio`
4. Menampilkan data dari API ke dalam aplikasi
5. Membangun UI responsif dengan data dinamis

## 🛠 Tools yang Dibutuhkan
- Flutter SDK terbaru
- IDE (VS Code/Android Studio)
- Emulator/Device fisik
- Postman (untuk testing API)

---

## 📦 Persiapan Project

### 1. Buat project baru
```bash
flutter create praktikum_api
cd praktikum_api
```

### 2. Tambahkan dependencies di `pubspec.yaml`
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  http: ^0.13.5
  dio: ^4.0.6
  cached_network_image: ^3.2.3
  flutter_dotenv: ^5.0.2
  intl: ^0.18.1
```

### 3. Install dependencies
```bash
flutter pub get
```

---

## 🏗 Struktur Project
```
lib/
├── models/
│   ├── user_model.dart
│   └── post_model.dart
├── providers/
│   ├── user_provider.dart
│   └── theme_provider.dart
├── services/
│   ├── api_service.dart
│   └── user_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── user_list_screen.dart
│   ├── user_detail_screen.dart
│   └── post_list_screen.dart
└── main.dart
```

---

## 1️⃣ State Management dengan Provider

### `lib/providers/user_provider.dart`
```dart
import 'package:flutter/foundation.dart';
import 'package:praktikum_api/models/user_model.dart';
import 'package:praktikum_api/services/user_service.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await UserService().getUsers();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  User getUserById(int id) {
    return _users.firstWhere((user) => user.id == id);
  }
}
```

### `lib/main.dart` (Setup Provider)
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:praktikum_api/providers/user_provider.dart';
import 'package:praktikum_api/providers/theme_provider.dart';
import 'package:praktikum_api/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter API Demo',
      theme: themeProvider.currentTheme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

## 2️⃣ Integrasi API dengan HTTP/Dio

### `lib/services/api_service.dart`
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  final Dio _dio = Dio();

  // Menggunakan HTTP Package
  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // Menggunakan Dio Package
  Future<List<dynamic>> getUsers() async {
    try {
      final response = await _dio.get('$_baseUrl/users');
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to load users: ${e.message}');
    }
  }
}
```

### `lib/models/user_model.dart`
```dart
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}
```

---

## 3️⃣ Implementasi UI

### `lib/screens/user_list_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:praktikum_api/models/user_model.dart';
import 'package:praktikum_api/providers/user_provider.dart';
import 'package:praktikum_api/screens/user_detail_screen.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userProvider.errorMessage.isNotEmpty) {
      return Center(child: Text(userProvider.errorMessage));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => userProvider.fetchUsers(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userProvider.users.length,
        itemBuilder: (context, index) {
          final user = userProvider.users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user.id.toString()),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(userId: user.id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

### `lib/screens/user_detail_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:praktikum_api/models/user_model.dart';
import 'package:praktikum_api/providers/user_provider.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUserById(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Phone: ${user.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Website: ${user.website}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Alamat:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            // Tambahan informasi alamat bisa ditambahkan di model
          ],
        ),
      ),
    );
  }
}
```

---

## 🏆 Tugas Praktikum

### 📌 Tugas 1: Post List dengan Comments
1. Buat model untuk Post dan Comment
2. Buat service untuk fetch posts dan comments
3. Buat screen untuk menampilkan list posts
4. Ketika post di-tap, tampilkan detail post dengan comments-nya

### 📌 Tugas 2: Theme Switcher
1. Buat ThemeProvider untuk mengelola tema aplikasi
2. Implementasikan dark mode/light mode toggle
3. Simpan preferensi tema menggunakan shared_preferences

### 📌 Tugas 3: Form Create Post
1. Buat form untuk membuat post baru
2. Implementasikan validasi form
3. Gunakan Dio untuk POST request ke API

---

## 📊 Kriteria Penilaian
| Kriteria | Bobot |
|----------|-------|
| **Implementasi State Management** <br> - Penggunaan Provider yang tepat <br> - Manajemen state yang efisien | 30% |
| **Integrasi API** <br> - GET/POST request bekerja <br> - Error handling yang baik <br> - Loading state management | 30% |
| **UI/UX** <br> - Tampilan yang responsive <br> - Pengalaman pengguna yang baik <br> - Konsistensi desain | 20% |
| **Kode Program** <br> - Struktur folder yang rapi <br> - Penamaan yang konsisten <br> - Dokumentasi kode | 20% |

---

## 🚀 Cara Menjalankan
1. Clone repository (jika ada)
2. Install dependencies:
```bash
flutter pub get
```
3. Jalankan aplikasi:
```bash
flutter run
```

## 📚 Referensi
1. [Dokumentasi Resmi Flutter](https://flutter.dev/docs)
2. [Provider Package](https://pub.dev/packages/provider)
3. [Dio HTTP Client](https://pub.dev/packages/dio)
4. [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
``` 

This enhanced version includes:
1. Complete project structure
2. Both HTTP and Dio implementations
3. Proper error handling and loading states
4. Detailed models and providers
5. Complete UI implementations
6. Practical assignments
7. Clear evaluation criteria
8. Modern Flutter practices

The material is ready to use for your workshop and covers all aspects of state management and API integration in Flutter.