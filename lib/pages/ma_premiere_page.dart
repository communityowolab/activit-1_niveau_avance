// Fichier: lib/pages/ma_premiere_page.dart

import 'package:flutter/material.dart';
import 'package:dev_mobile_avance/widgets/partie_grille_image.dart'; // Nous allons créer ce widget

class MaPremierePage extends StatefulWidget {
  const MaPremierePage({super.key});

  @override
  State<MaPremierePage> createState() => _MaPremierePageState();
}

// 2. La classe MaPremierePage (StatefulWidget)
class _MaPremierePageState extends State<MaPremierePage> {
  // L'index du BottomNavigationBar, non implémenté pour la navigation réelle[cite: 91].
  int _selectedIndex = 0; 
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: barre d'application en haut[cite: 85, 86].
      appBar: AppBar(
        title: const Text(
          "Vos émissions en streaming",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber, // Couleur amber [cite: 86]
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // Bouton de recherche [cite: 85]
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), // Bouton de liste [cite: 85]
            onPressed: () {},
          ),
        ],
      ),
      
      // Body: appelle le widget partieGrilleImage[cite: 87, 88].
      body: const SingleChildScrollView( // Permet le défilement si la grille est trop grande
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: partieGrilleImage(), // Le corps appelle partieGrilleImage [cite: 87]
          ),
        ),
      ),
      
      // BottomNavigationBar: barre de navigation en bas[cite: 89].
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil', // Icône Accueil [cite: 90]
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche', // Icône Recherche [cite: 90]
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil', // Icône Profil [cite: 90]
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped, // La navigation n'est pas implémentée en détail [cite: 91]
      ),
    );
  }
}