import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/data/dataSource/remote/VlilleApi.dart';
import 'package:cours_flutter/data/model/VlilleApiResponse.dart';
import 'package:cours_flutter/ui/widgets/ListStation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);
  VlilleApi api = VlilleApi();

  // final fieldsRef = FirebaseFirestore.instance
  //     .collection('FAVORIS')
  //     .withConverter<List<Int>>(
  //   fromFirestore: (snapshots, _) => Fields.fromJson(snapshots.data()!),
  //   toFirestore: (movie, _) => movie.toJson(),
  // );

  @override
  Widget build(BuildContext context) {

    // Ajouter un favori
    // if (FirebaseAuth.instance.currentUser != null) {
    //   fieldsRef.doc(FirebaseAuth.instance.currentUser!.uid).set(data);
    // }


    // fieldsRef.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
    //   value.data();
    // });

    // Changer l'icône après récupération des favoris
    // fieldsRef.get().then((value) => state(() {
    //
    // }));

    return Scaffold(
      body: FutureBuilder(
          future: api.getVlille(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.records != null) {
                snapshot.data?.records!.sort((a, b) => a.fields!.distance!.compareTo(b.fields!.distance!));
                return ListStation(records: snapshot.data!.records);
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
          }),
    );
  }
}
