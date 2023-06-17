import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/data/model/VlilleApiResponse.dart';
import 'package:cours_flutter/ui/screens/ListScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/dataSource/remote/VlilleApi.dart';
import '../../data/model/FavFromFirestore.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, required this.stationId, required this.favorites});

  // const DetailsScreen({super.key});

  final int stationId;
  List<int> favorites;

  VlilleApi api = VlilleApi();

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Records>? station;

  Color defineColor(nb) {
    if (nb == 0) {
      return Colors.red;
    } else if (nb <= 5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  // On crée une variable pour simplifier l'ouverture de la connexion
  // à la collection de Firestore
  final fieldsRef = FirebaseFirestore.instance
      .collection('FAVORIS')
      .withConverter<FavFromFirestore>(
        fromFirestore: (snapshots, _) =>
            FavFromFirestore.fromJson(snapshots.data()!),
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
      fieldsRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(FavFromFirestore(stationId: widget.favorites));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.api.getVlille(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.records != null) {
              station = snapshot.data?.records
                  ?.where(
                      (record) => record.fields?.libelle == widget.stationId)
                  .toList();
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: BackButton(
                      color: Colors.black54,
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen(
                                      favorites: widget.favorites,
                                    )),
                          )),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('https://picsum.photos/500/550'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 16, 16, 0),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              station![0].fields!.nom!,
                              softWrap: true,
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 26),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Text(
                            '${station![0].fields!.distance!.toStringAsFixed(0)} mètres',
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(
                              verifyFav(widget.stationId)
                                  ? Icons.star
                                  : Icons.star_border,
                            ),
                            onPressed: () {
                              toggleFavorite(widget.stationId);
                            },
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Uri googleMapsUri = Uri.parse(
                                  'https://maps.google.com/maps?saddr=50.630238,3.056559&daddr=${station![0].fields!.localisation![0]},${station![0].fields!.localisation![1]}');
                              launchUrl(googleMapsUri,
                                  mode: LaunchMode.externalApplication);
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Y aller',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                // <-- Text
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_sharp,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                defineColor(station![0].fields!.nbvelosdispo)
                                    .withOpacity(0.2),
                            child: Icon(
                              Icons.pedal_bike,
                              color:
                                  defineColor(station![0].fields!.nbvelosdispo),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${station![0].fields!.nbvelosdispo!} vélos',
                            style: TextStyle(
                                fontSize: 16,
                                color: defineColor(
                                    station![0].fields!.nbvelosdispo)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                defineColor(station![0].fields!.nbplacesdispo)
                                    .withOpacity(0.2),
                            child: Icon(Icons.local_parking,
                                color: defineColor(
                                    station![0].fields!.nbplacesdispo)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${station![0].fields!.nbplacesdispo!} places',
                            style: TextStyle(
                                fontSize: 16,
                                color: defineColor(
                                    station![0].fields!.nbplacesdispo)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text.rich(TextSpan(children: [
                            WidgetSpan(
                                child: station![0].fields!.type == "AVEC TPE"
                                    ? const CircleAvatar(
                                        child: Icon(Icons.credit_score,
                                            color: Colors.blue))
                                    : CircleAvatar(
                                        backgroundColor:
                                            Colors.redAccent.withOpacity(0.2),
                                        child: const Icon(
                                            Icons.credit_card_off_outlined,
                                            color: Colors.redAccent)))
                          ])),
                          const SizedBox(width: 8),
                          Text(
                            'Paiement en carte',
                            style: TextStyle(
                                fontSize: 16,
                                color: station![0].fields!.type == "AVEC TPE"
                                    ? Colors.blue
                                    : Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.red));
          }
        });
  }
}
