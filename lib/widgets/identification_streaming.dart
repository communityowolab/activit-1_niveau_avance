// Fichier: lib/widgets/identification_streaming.dart

import 'package:flutter/material.dart';
import 'package:dev_mobile_avance/modele/emission.dart'; // Importation du modèle
import 'package:dev_mobile_avance/pages/album_streaming.dart'; // Page de détails à créer

// 3. La classe IdentificationStreaming (StatelessWidget)
class IdentificationStreaming extends StatelessWidget {
  // Informations de l'émission passées en paramètre [cite: 119]
  final Emission emission; 

  const IdentificationStreaming({
    super.key,
    required this.emission,
  });

  @override
  Widget build(BuildContext context) {
    // Utilisation de GestureDetector pour détecter l'appui utilisateur [cite: 134]
    return GestureDetector(
      onTap: () {
        // Naviguer vers AlbumStreaming en passant les informations [cite: 134]
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => AlbumStreaming(emission: emission),
          ),
        );
      },
      // Conteneur pour envelopper le contenu et ajouter une décoration/ombre [cite: 130, 131]
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        // Utilisation de ClipRRect pour arrondir les coins du widget [cite: 132]
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          // Colonne pour contenir l'image et les informations [cite: 135]
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image avec animation Hero [cite: 136]
              Hero(
                tag: emission.tagStream, // Étiquette unique pour la transition Hero [cite: 120]
                child: Image.asset(
                  emission.imageStream, // Chemin de l'image de l'émission [cite: 121]
                  height: 120.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 120.0,
                      child: Center(child: Icon(Icons.image_not_supported)),
                    );
                  },
                ),
              ),
              // Conteneur pour le nom de l'émission et la radio [cite: 137]
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom de l'émission (NomStream) [cite: 127]
                    Text(
                      emission.nomStream,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    // Nom de la chaîne radio (ChaineRadio) [cite: 128]
                    Text(
                      emission.chaineRadio,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}