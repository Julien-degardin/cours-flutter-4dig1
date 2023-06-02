import 'package:flutter/material.dart';
import 'package:cours_flutter/data/dataSource/remote/VlilleApi.dart';
import 'package:cours_flutter/ui/widgets/ListStation.dart';
import 'package:flutter/material.dart';

import '../../data/model/VlilleApiResponse.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  VlilleApi api = VlilleApi();

  List<Records>? records;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        decoration: const InputDecoration(
          hintText: 'Rechercher...',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          // Appeler une fonction pour traiter la recherche ici
          //print('Recherche : $value');
        },
      ),
      FutureBuilder(
          future: api.getVlille(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.records != null) {
                return ListStation(records: snapshot.data!.records);
              } else {
                return const CircularProgressIndicator();
              }
            } else {
              return const CircularProgressIndicator();
            }
          }),
    ]);
  }
}
