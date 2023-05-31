import 'package:cours_flutter/data/dataSource/remote/VlilleApi.dart';
import 'package:cours_flutter/ui/widgets/CustomBottomNavigationBar.dart';
import 'package:cours_flutter/ui/widgets/ListStation.dart';

import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);
  VlilleApi api = VlilleApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: FutureBuilder(
        future: api.getVlille(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.records != null) {
              return ListStation(records: snapshot.data!.records);
              /*return ListView.builder(itemBuilder: (context, index) {
                if (snapshot.data?.records![index] != null) {
                  if (snapshot.data?.records![index].fields != null) {
                    if (snapshot.data?.records![index].fields!.adresse != null) {
                      return ListTile(
                          title: Text(
                              snapshot.data!.records![index].fields!.adresse!)
                      );
                    }
                  }
                }
              }, itemCount: snapshot.data?.nhits);*/
            } else {
              return const CircularProgressIndicator();
            }
          } else {
              return const CircularProgressIndicator();
          }
        }
      ),
    );
  }
}
