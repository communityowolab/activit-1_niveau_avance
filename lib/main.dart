import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Nécessaire pour les requêtes HTTP [cite: 57, 74]
import 'dart:convert'; // Nécessaire pour json.decode() [cite: 122, 123]

void main() {
  runApp(MonApplication());
}

// Classe 1: MonApplication (StatelessWidget)
class MonApplication extends StatelessWidget {
  // MonApplication définit l'application Flutter principale. [cite: 93, 94]
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Titre de l'application [cite: 96]
      title: 'Application Météo', 
      theme: ThemeData(
        // Thème par défaut avec couleur principale bleue [cite: 97, 99]
        primarySwatch: Colors.blue, 
      ),
      // La page d'accueil est PrevisionInterface [cite: 100, 101]
      home: PrevisionInterface(),
    );
  }
}

// Classe 2: PrevisionInterface (StatefulWidget)
class PrevisionInterface extends StatefulWidget {
  // PrevisionInterface représente l'interface utilisateur principale. [cite: 102, 103]
  @override
  _PrevisionInterfaceState createState() => _PrevisionInterfaceState();
}

// Classe 3: _PrevisionInterfaceState (L'état du widget principal)
class _PrevisionInterfaceState extends State<PrevisionInterface> {
  
  // Contrôleur pour le champ de texte de la ville
  final TextEditingController _villeController = TextEditingController();

  // Variable booléenne pour l'icône de chargement [cite: 107, 108]
  bool _isLoading = false; 

  // Stocke les données météorologiques récupérées au format Map<String, dynamic>? [cite: 119]
  Map<String, dynamic>? _DonneesMeteo; 

  // Clé API OpenWeather (À remplacer par votre clé réelle) [cite: 112]
  // Note: Il est préférable de stocker les clés API en dehors du code pour la sécurité !
  final String API_KEY = '1c1775f72d36bb0137495b4c18d70840'; 
  
  // Méthode pour effectuer la requête HTTP [cite: 111]
  Future<void> RecupererDonnees() async {
    final ville = _villeController.text.trim();
    if (ville.isEmpty) {
      return; 
    }

    // 1. Démarrer le chargement
    setState(() {
      _isLoading = true; // Affiche l'icône de chargement [cite: 109, 110]
      _DonneesMeteo = null; 
    });

    // Construire l'URL de l'API OpenWeather
    // Utilisation de 'units=metric' pour les degrés Celsius
    final String url = 
      'https://api.openweathermap.org/data/2.5/weather?q=$ville&appid=$API_KEY&units=metric&lang=fr';

    try {
      // 2. Effectuer la requête HTTP GET
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // La requête a réussi
        
        // 3. Convertir la réponse JSON en un objet Dart (Map) [cite: 120, 121, 122, 124]
        final donnees = json.decode(response.body) as Map<String, dynamic>;

        // 4. Mettre à jour l'état avec les données
        setState(() {
          _DonneesMeteo = donnees; // Stocke les données [cite: 119]
        });

      } else {
        // Gérer les erreurs (ex: 404 - Ville non trouvée)
        print('Erreur lors de la requête: ${response.statusCode}');
        // Si vous voulez effacer les données en cas d'erreur
        setState(() {
            _DonneesMeteo = null; 
        });
      }
    } catch (e) {
      print('Erreur réseau ou de décodage: $e');
    } finally {
      // 5. Terminer le chargement
      setState(() {
        _isLoading = false; // Masque l'icône de chargement [cite: 110]
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // L'interface utilisateur est mise à jour en fonction de _isLoading et des données récupérées. [cite: 113, 114]
    return Scaffold(
      appBar: AppBar(
        title: Text('Prévisions météo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Champ de texte (TextField) pour la ville [cite: 104, 105]
            TextField(
              controller: _villeController,
              decoration: InputDecoration(
                labelText: 'Entrez une ville',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => RecupererDonnees(),
            ),
            SizedBox(height: 20),
            
            // Bouton Obtenir la météo pour déclencher la récupération [cite: 106]
            ElevatedButton(
              onPressed: _isLoading ? null : RecupererDonnees, 
              child: Text('Obtenir la météo'),
            ),
            SizedBox(height: 30),

            // Affichage conditionnel
            if (_isLoading)
              // Afficher l'icône de chargement (Circular ProgressIndicator) [cite: 109]
              Center(child: CircularProgressIndicator())
            else if (_DonneesMeteo != null)
              // Afficher les données via le widget dédié
              DonneesMeteoWidget(donneesMeteo: _DonneesMeteo!)
            else
              // Message initial ou en cas d'absence/erreur de données [cite: 19]
              Center(child: Text('Aucune donnée météo disponible', style: TextStyle(fontStyle: FontStyle.italic))), 
          ],
        ),
      ),
    );
  }
}

// Classe 4: DonneesMeteoWidget (StatelessWidget)
class DonneesMeteoWidget extends StatelessWidget {
  // Reçoit les données météorologiques en tant que paramètre [cite: 126, 127]
  final Map<String, dynamic> donneesMeteo; 

  const DonneesMeteoWidget({Key? key, required this.donneesMeteo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extraction des données
    // Température principale: ['main']['temp']
    final double temperature = donneesMeteo['main']['temp'].toDouble(); 
    // Description du temps: ['weather'][0]['description']
    final String description = donneesMeteo['weather'][0]['description'] ?? 'N/A'; 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Affichage de la température et de la description [cite: 127]
        Text(
          'Température: ${temperature.toStringAsFixed(1)} °C', 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          // Met la première lettre en majuscule
          'Description: ${description[0].toUpperCase()}${description.substring(1)}', 
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
