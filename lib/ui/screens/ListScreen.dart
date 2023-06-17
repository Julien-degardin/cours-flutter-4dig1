import 'package:cours_flutter/data/dataSource/remote/VlilleApi.dart';
import 'package:cours_flutter/ui/widgets/ListStation.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  ListScreen({Key? key, required this.favorites}) : super(key: key);
  List<int> favorites;
  VlilleApi api = VlilleApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getVlille(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.records != null) {
            return ListStation(records: snapshot.data!.records, favorites: favorites,);
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
