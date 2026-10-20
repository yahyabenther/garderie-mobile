import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MaGarderieApp());
}

class MaGarderieApp extends StatelessWidget {
  const MaGarderieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma Garderie',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.child_care, size: 100, color: Colors.pinkAccent),
            const SizedBox(height: 20),
            const Text(
              'Ma Garderie',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> activites = [
    {
      "id": 1,
      "titre": "Dessin et coloriage",
      "description": "Développement de la créativité",
      "icone": "🎨"
    },
    {
      "id": 2,
      "titre": "Jeux éducatifs",
      "description": "Apprentissage par le jeu",
      "icone": "🧩"
    },
    {
      "id": 3,
      "titre": "Musique et chansons",
      "description": "Éveil musical des enfants",
      "icone": "🎵"
    },
    {
      "id": 4,
      "titre": "Lecture de contes",
      "description": "Découverte des histoires",
      "icone": "📚"
    },
    {
      "id": 5,
      "titre": "Activités sportives",
      "description": "Développement de la motricité",
      "icone": "⚽"
    }
  ];

  String _selectedDrawerItem = 'Accueil';

  void _showAddActivityDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nouvelle activité'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Titre de l\'activité'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    activites.add({
                      "id": activites.length + 1,
                      "titre": titleController.text,
                      "description": descriptionController.text.isNotEmpty
                          ? descriptionController.text
                          : 'Nouvelle activité de garderie',
                      "icone": "⭐",
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Garderie'),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              child: Text(
                'Menu Ma Garderie',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              selected: _selectedDrawerItem == 'Accueil',
              onTap: () {
                setState(() => _selectedDrawerItem = 'Accueil');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Activités'),
              selected: _selectedDrawerItem == 'Activités',
              onTap: () {
                setState(() => _selectedDrawerItem == 'Activités');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              selected: _selectedDrawerItem == 'À propos',
              onTap: () {
                setState(() => _selectedDrawerItem = 'À propos');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: activites.length,
        itemBuilder: (context, index) {
          final activite = activites[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            child: ListTile(
              leading: Text(
                activite['icone'],
                style: const TextStyle(fontSize: 30),
              ),
              title: Text(
                activite['titre'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(activite['description']),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(activite['titre'])),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddActivityDialog,
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}