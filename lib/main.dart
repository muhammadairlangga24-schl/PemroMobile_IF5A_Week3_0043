import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gabungan Navigasi',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/tentang': (context) => const TentangPage(),
        '/dua': (context) => const HalamanDua(),
        '/tiga': (context) => const HalamanTiga(),
      },
    );
  }
}

// Shell Utama dengan BottomNavigationBar (Bonus)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    BerandaTab(),
    CariTab(),
    ProfilTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplikasi Navigasi Lengkap')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// Tab 1: Beranda (Gabungan Latihan 1, 2, & 3)
class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Sepatu Kets', 'price': 'Rp 500.000'},
      {'name': 'Tas Ransel', 'price': 'Rp 350.000'},
      {'name': 'Topi Polos', 'price': 'Rp 80.000'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Latihan 1: Push & Pop
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Latihan 1: Push & Pop', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/tentang'),
                    child: const Text('Ke Halaman Tentang'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Latihan 3: Named Routes dengan Argumen
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Latihan 3: Named Routes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dua', arguments: 'Pesan dari Beranda!');
                    },
                    child: const Text('Ke Halaman 2 (Bawa Data)'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Latihan 2: Kirim Data via Parameter Konstruktor
          const Text('Latihan 2: Kirim Data Produk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: ListTile(
                  title: Text(product['name']!),
                  subtitle: Text(product['price']!),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          name: product['name']!,
                          price: product['price']!,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Tab 2: Cari
class CariTab extends StatelessWidget {
  const CariTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Halaman Cari', style: TextStyle(fontSize: 22)));
  }
}

// Tab 3: Profil
class ProfilTab extends StatelessWidget {
  const ProfilTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Halaman Profil', style: TextStyle(fontSize: 22)));
  }
}

// Halaman Tujuan Latihan 1
class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
      ),
    );
  }
}

// Halaman Tujuan Latihan 2
class DetailPage extends StatelessWidget {
  final String name;
  final String price;

  const DetailPage({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Produk: $name', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text('Harga: $price', style: const TextStyle(fontSize: 20, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

// Halaman Tujuan Latihan 3 (Halaman 2)
class HalamanDua extends StatelessWidget {
  const HalamanDua({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Argumen Diterima: $args', style: const TextStyle(fontSize: 18)),
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

// Halaman Tujuan Latihan 3 (Halaman 3)
class HalamanTiga extends StatelessWidget {
  const HalamanTiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman 3')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          child: const Text('Kembali ke Beranda Utama'),
        ),
      ),
    );
  }
}