import 'package:flutter/material.dart';
import 'package:cours_flutter/data/model/VlilleApiResponse.dart';

class ListStation extends StatelessWidget {
  ListStation({required this.records, Key? key}) : super(key: key);
  List<Records>? records;

  bool active = true;

  @override
  ListView build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, int index) {
        records![index].fields!.etat == "RÉFORMÉ" || records![index].fields!.etatconnexion == "DÉCONNECTÉ" ? active = false : active = true;
        if (records![index].fields != null) {
          if (records![index].fields!.adresse != null) {

            return Card(
              color: active ? Colors.white : Colors.white38,
              child: ListTile(
                visualDensity: VisualDensity.comfortable,
                isThreeLine: true,
                minVerticalPadding: 8,
                title: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text.rich(
                    TextSpan(style: TextStyle(fontSize: 20), children: [
                      TextSpan(text: records![index].fields!.nom!),
                      WidgetSpan(child: SizedBox(width: 10)),
                      WidgetSpan(child:
                      records![index].fields!.type == "AVEC TPE" ?
                      Icon(Icons.credit_card) : Icon(Icons.credit_card_off)
                      )
                    ]),
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), children: [
                          WidgetSpan(child: Icon(Icons.bike_scooter_rounded)),
                          TextSpan(text: records![index].fields!.nbvelosdispo!.toString()),
                          WidgetSpan(child: SizedBox(width: 10)),
                          WidgetSpan(child: Icon(Icons.place)),
                          TextSpan(text: records![index].fields!.nbplacesdispo!.toString()),
                        ]),
                      ),
                      Text('XX mètres'),
                    ]
                  )
                ),

                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.star_border),
                      onPressed: () {},
                    ),
                    /*IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {},
                    ),*/
                  ],
                )
              ),

            );
          }
        }
      },
      itemCount: records!.length,
    );
  }
}
