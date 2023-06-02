import 'package:flutter/material.dart';
import 'package:cours_flutter/data/dataSource/remote/VlilleApi.dart';
import 'package:cours_flutter/ui/widgets/ListStation.dart';

import '../../data/model/VlilleApiResponse.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  VlilleApi api = VlilleApi();

  List<Records>? records;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: api.getVlille(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.records != null) {
              if (records == null) {
                records = snapshot.data?.records;
              }
              return Column(children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Rechercher...',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                    onChanged: (searchValue) {
                      setState(() {
                        if (searchValue != "") {
                          records = records!
                              .where((record) =>
                                  record.fields!.commune!
                                      .contains(searchValue.toUpperCase()) ||
                                  record.fields!.nom!
                                      .contains(searchValue.toUpperCase()))
                              .toList();
                        } else {
                          records = snapshot.data?.records;
                        }
                      });
                    },
                  ),
                ),
                Expanded(child: ListStation(records: records))
              ]);
            } else {
              return const CircularProgressIndicator();
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
