import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:cours_flutter/data/model/VlilleApiResponse.dart';

class ListStation extends StatelessWidget {
  ListStation({required this.records, Key? key}) : super(key: key);
  List<Records>? records;

  bool active = true;
  int? nbvelos = 0;
  int? nbplaces = 0;

   Color defineColor(nb) {
    if(nb == 0) {
      return Colors.red;
    } else if (nb <= 5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }


  /*double? calculateDistance(lat1, lgt1, latDest, lgtDest) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((latDest - lat1) * p)/2 +
        c(lat1 * p) * c(latDest * p) *
            (1 - c((lgtDest - lgt1) * p))/2;
    return 1000 * (12742 * asin(sqrt(a)));
  }*/

  @override
  ListView build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, int index) {
        records![index].fields!.etat == "RÉFORMÉ" || records![index].fields!.etatconnexion == "DÉCONNECTÉ" ? active = false : active = true;
        nbvelos = records![index].fields!.nbvelosdispo;
        nbplaces = records![index].fields!.nbplacesdispo;


        if (records![index].fields != null) {
          if (records![index].fields!.adresse != null) {
            return Card(
              color: active ? Colors.white : Colors.white38,
              child: Column(
                children: [
              ListTile(
                visualDensity: VisualDensity.comfortable,
                isThreeLine: true,
                title:
                Text.rich(
                    TextSpan(style: const TextStyle(fontSize: 20), children: [
                      TextSpan(text: records![index].fields!.nom!),
                      const WidgetSpan(child: SizedBox(width: 10)),
                      WidgetSpan(child:
                      records![index].fields!.type == "AVEC TPE" ?
                      const Icon(Icons.credit_score) : const Icon(Icons.credit_card_off)
                      )
                    ]),
                  ),

                subtitle:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${records![index].fields!.distance!.toStringAsFixed(0)} mètres'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: defineColor(nbvelos).withOpacity(0.2),
                                child: Icon(Icons.pedal_bike, color: defineColor(nbvelos),),),
                              const SizedBox(width: 5,),
                              Text(records![index].fields!.nbvelosdispo!.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: defineColor(nbvelos)),),
                              const SizedBox(width: 15),
                              CircleAvatar(backgroundColor: defineColor(nbplaces).withOpacity(0.2),
                                child: Icon(Icons.local_parking, color: defineColor(nbplaces)),),
                              const SizedBox(width: 5),
                              Text(records![index].fields!.nbplacesdispo!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: defineColor(nbplaces)),),
                              const SizedBox(width: 10),
                            ],
                          ),
                          ElevatedButton(onPressed: () {},
                            child: const Icon(Icons.directions, size: 28, color: Colors.red,),
                          )
                        ],
                      ),
                    ]
                  ),

                trailing:
                    IconButton(
                      icon: const Icon(Icons.star_border, size: 26,),
                      onPressed: () {},
                    ),
              ),
                ])
            );
          }
        }
      },
      itemCount: records!.length,
    );
  }
}
