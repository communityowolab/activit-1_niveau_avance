// Fichier: lib/widgets/partie_grille_image.dart

import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart'; // Importer le package [cite: 195]

import 'package:dev_mobile_avance/modele/emission.dart';
import 'package:dev_mobile_avance/widgets/identification_streaming.dart';

// Liste des données d'émissions (à titre indicatif)
final List<Emission> emissions = [
  const Emission(tagStream: 'Doc4', imageStream: 'assets/images/doc4.jpg', nomStream: 'Documentaires', chaineRadio: 'Radio 4'),
  const Emission(tagStream: 'Mode3', imageStream: 'assets/images/mode3.jpg', nomStream: 'Tendances Mode', chaineRadio: 'Radio 3'),
  const Emission(tagStream: 'Enquete2', imageStream: 'assets/images/enquete2.jpg', nomStream: 'Enquêtes Criminelles', chaineRadio: 'Radio 2'),
  const Emission(tagStream: 'Foot5', imageStream: 'assets/images/foot5.jpg', nomStream: 'Match de Foot', chaineRadio: 'Radio 5'),
  const Emission(tagStream: 'Stream1', imageStream: 'assets/images/stream1.jpg', nomStream: 'Streaming Mitio', chaineRadio: 'Radio 1'),
  const Emission(tagStream: 'News4', imageStream: 'assets/images/news4.jpg', nomStream: 'Que des news', chaineRadio: 'Radio 4'),
];

// 4. La classe partieGrilleImage (StatelessWidget)
class partieGrilleImage extends StatelessWidget {
  const partieGrilleImage({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilisation de ResponsiveGridList pour créer une grille réactive [cite: 141, 196]
    return ResponsiveGridList(
      // Largeur souhaitée des éléments (ex: 150px) [cite: 198, 199]
      desiredItemWidth: 150.0, 
      // Espacement minimal entre les éléments (ex: 10px) [cite: 200]
      minSpacing: 10.0, 
      // Éléments de la grille [cite: 201]
      children: emissions.map((e) {
        // Chaque élément est une instance de IdentificationStreaming [cite: 202]
        return IdentificationStreaming(
          emission: e, // Passage des paramètres nécessaires [cite: 203]
        );
      }).toList(),
    );
  }
}