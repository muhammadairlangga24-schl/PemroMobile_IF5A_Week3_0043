import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanSatu(),
        '/dua': (context) => const HalamanDua(),
        '/tiga': (context) => const HalamanTiga(),
      },
    );
  }
}

class HalamanSatu extends StatelessWidget {
  const HalamanSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Mengirim argumen string ke rute /dua
            Navigator.pushNamed(
              context,
              '/dua',
              arguments: 'Halo dari Halaman 1!',
            );
          },
          child: const Text('Ke Halaman 2 (Bawa Data)'),
        ),
      ),
    );
  }
}

class HalamanDua extends StatelessWidget {
  const HalamanDua({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengekstrak argumen dari ModalRoute
    final args = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pesan diterima: $args', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/tiga'),
              child: const Text('Ke Halaman 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanTiga extends StatelessWidget {
  const HalamanTiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman 3')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          child: const Text('Kembali ke Awal'),
        ),
      ),
    );
  }
}