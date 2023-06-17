import 'package:flutter/material.dart';

import '../../data/dataSource/remote/VlilleApi.dart';
import '../widgets/ListStation.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key, required this.favorites});
  List<int> favorites;
  VlilleApi api = VlilleApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: api.getVlille(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.records != null) {
              if (favorites.isNotEmpty) {
                snapshot.data?.records!.removeWhere((record) => !favorites.contains(record.fields!.libelle));
                return ListStation(records: snapshot.data!.records, favorites: favorites,);
              } else {
                return const Center(child: Text("Aucune station en favoris"));
          }
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
