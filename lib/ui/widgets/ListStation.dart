import 'package:flutter/material.dart';
import 'package:cours_flutter/data/model/VlilleApiResponse.dart';

class ListStation extends StatelessWidget {
  ListStation( { required this.records, Key? key}) : super(key: key);
  List<Records>? records;


  @override

  ListView build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, int index) {
      return ListTile(
        title: Text(records![index].fields!.nom!)
      );
    }, itemCount: records!.length,
    );
  }
}
