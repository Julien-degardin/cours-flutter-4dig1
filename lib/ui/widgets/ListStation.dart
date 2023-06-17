import 'package:cours_flutter/ui/screens/DetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/data/model/FavFromFirestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cours_flutter/data/model/VlilleApiResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class ListStation extends StatefulWidget {
  ListStation({required this.records, required this.favorites, Key? key}) : super(key: key);
  List<Records>? records;
  List<int> favorites;

  @override
  State<ListStation> createState() => _ListStationState();
}

class _ListStationState extends State<ListStation> {
  bool active = true;
  int? nbvelos = 0;
  int? nbplaces = 0;
  bool isFav = false;


  Color defineColor(nb) {
    if(nb == 0) {
      return Colors.red;
    } else if (nb <= 5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  // On crée une variable pour simplifier l'ouverture de la connexion
  // à la collection de Firestore
  final fieldsRef =
      FirebaseFirestore.instance.collection('FAVORIS')
        .withConverter<FavFromFirestore>(
          fromFirestore: (snapshots, _) => FavFromFirestore.fromJson(snapshots.data()!),
          toFirestore: (station, _) => station.toJson(),
        );

  // Fonction simple pour verifier si le libelle de la station est dans la liste de favoris
  bool verifyFav(int libelle) {
    return widget.favorites.contains(libelle);
  }

  // On ajoute ou supprime de la liste des favoris le libelle de la station
  // Et on renvoie cette liste à Firestore
  void toggleFavorite(int libelle) {
    setState(() {
      if (verifyFav(libelle)) {
        widget.favorites.remove(libelle);
      } else {
        widget.favorites.add(libelle);
      }
      fieldsRef.doc(FirebaseAuth.instance.currentUser!.uid).set(FavFromFirestore(stationId: widget.favorites));
    });
  }

  @override

  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, int index) {
        widget.records![index].fields!.etat == "RÉFORMÉ" || widget.records![index].fields!.etatconnexion == "DÉCONNECTÉ" ? active = false : active = true;
        nbvelos = widget.records![index].fields!.nbvelosdispo;
        nbplaces = widget.records![index].fields!.nbplacesdispo;

        if (widget.records![index].fields != null) {
          if (widget.records![index].fields!.adresse != null) {
            return Card(
              color: active ? Colors.white : Colors.white38,
              child: Column(
                children: [
              ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailsScreen(stationId: widget.records![index].fields!.libelle!, favorites: widget.favorites)),
                ),
                visualDensity: VisualDensity.comfortable,
                isThreeLine: true,
                title:
                Text.rich(
                    TextSpan(style: const TextStyle(fontSize: 20), children: [
                      TextSpan(text: widget.records![index].fields!.nom!),
                      const WidgetSpan(child: SizedBox(width: 10)),
                      WidgetSpan(child:
                      widget.records![index].fields!.type == "AVEC TPE" ?
                      const Icon(Icons.credit_score) : const Icon(Icons.credit_card_off)
                      )
                    ]),
                  ),

                subtitle:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.records![index].fields!.distance!.toStringAsFixed(0)} mètres'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: defineColor(nbvelos).withOpacity(0.2),
                                child: Icon(Icons.pedal_bike, color: defineColor(nbvelos),),),
                              const SizedBox(width: 5,),
                              Text(widget.records![index].fields!.nbvelosdispo!.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: defineColor(nbvelos)),),
                              const SizedBox(width: 15),
                              CircleAvatar(backgroundColor: defineColor(nbplaces).withOpacity(0.2),
                                child: Icon(Icons.local_parking, color: defineColor(nbplaces)),),
                              const SizedBox(width: 5),
                              Text(widget.records![index].fields!.nbplacesdispo!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: defineColor(nbplaces)),),
                              const SizedBox(width: 10),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Uri googleMapsUri = Uri.parse('https://maps.google.com/maps?saddr=50.630238,3.056559&daddr=${widget.records![index].fields!.localisation![0]},${widget.records![index].fields!.localisation![1]}');
                              launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
                            },
                            child: const Icon(Icons.directions, size: 28, color: Colors.red,),
                          )
                        ],
                      ),
                    ]
                  ),

                trailing:
                    IconButton(
                      icon: Icon(
                        verifyFav(widget.records![index].fields!.libelle!) ? Icons.star : Icons.star_border,
                      ),
                      onPressed: () {toggleFavorite(widget.records![index].fields!.libelle!);},
                    ),
              ),
                ])
            );
          }
        }
      },
      itemCount: widget.records!.length,
    );
  }
}
