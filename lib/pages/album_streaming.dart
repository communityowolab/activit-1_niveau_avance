// Fichier: lib/pages/album_streaming.dart

import 'package:flutter/material.dart';
import 'dart:math'; // Pour les dates aléatoires [cite: 223]

import 'package:dev_mobile_avance/modele/emission.dart';

class AlbumStreaming extends StatelessWidget {
  final Emission emission;

  const AlbumStreaming({super.key, required this.emission});

  // Fonction utilitaire pour générer des dates aléatoires pour les diffusions [cite: 223]
  String _generateRandomDate() {
    final random = Random();
    const year = 2023;
    final month = random.nextInt(12) + 1;
    final day = random.nextInt(28) + 1;
    
    // Formatage simple AAAA-MM-JJ
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }

  // Widget pour une seule ligne de diffusion (avec icône et date) [cite: 222]
  Widget _buildDiffusionItem(String diffusionNumber, BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.volume_up, color: Colors.amber), // Bouton d'icône de volume [cite: 222]
      title: Text("Diffusion $diffusionNumber"),
      trailing: Text(
        "Date: ${_generateRandomDate()}", // Date de diffusion aléatoire [cite: 223]
        style: TextStyle(color: Colors.grey[600]),
      ),
      onTap: () {
        // Action non implémentée
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // La page prend en paramètre les infos de l'émission et les affiche [cite: 218]
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar pour l'image de fond et la barre de titre
          SliverAppBar(
            expandedHeight: 250.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                emission.nomStream, // Nom de la diffusion dans la barre de titre [cite: 220]
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image avec Hero pour la transition [cite: 219]
                  Hero(
                    tag: emission.tagStream,
                    child: Image.asset(
                      emission.imageStream, // Image de fond [cite: 216]
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient pour améliorer la lisibilité du titre sur l'image
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Contenu principal de la page
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    emission.chaineRadio, // Affichage de la chaîne radio [cite: 220]
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber[800],
                    ),
                  ),
                ),
                const Divider(),
                
                // Liste des diffusions aléatoires (simulant les données réelles) [cite: 221]
                _buildDiffusionItem("1", context),
                _buildDiffusionItem("2", context),
                _buildDiffusionItem("3", context),
                _buildDiffusionItem("4", context),
                _buildDiffusionItem("5", context),
                _buildDiffusionItem("6", context),
                // Ajoutez plus d'éléments si nécessaire pour le défilement
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}