import 'package:flutter/material.dart';
import 'package:cours_flutter/data/model/VlilleApiResponse.dart';

class ListStation extends StatelessWidget {
  ListStation({required this.records, Key? key}) : super(key: key);
  List<Records>? records;

  bool active = true;
  int? nbvelos = 0;
  int? nbplaces = 0;

  @override
  ListView build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, int index) {
        records![index].fields!.etat == "RÉFORMÉ" || records![index].fields!.etatconnexion == "DÉCONNECTÉ" ? active = false : active = true;
        nbvelos = records![index].fields!.nbvelosdispo;
        nbplaces = records![index].fields!.nbvelosdispo;


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
                      Text('XX mètres'),
                      Text.rich(
                        TextSpan(style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), children: [
                          const WidgetSpan(child: CircleAvatar(child: const Icon(Icons.pedal_bike, color: Colors.blue,), backgroundColor: Color.fromRGBO(
                              64, 197, 253, 0.3176470588235294),)
                          ),
                          const WidgetSpan(child: SizedBox(width: 5,)),
                          TextSpan(text: records![index].fields!.nbvelosdispo!.toString()),
                          const WidgetSpan(child: SizedBox(width: 10)),
                          const WidgetSpan(child: CircleAvatar(child: const Icon(Icons.local_parking, color: Colors.blue,), backgroundColor: Color.fromRGBO(
                              64, 197, 253, 0.3176470588235294),)
                          ),
                          const WidgetSpan(child: SizedBox(width: 5)),
                          TextSpan(text: records![index].fields!.nbplacesdispo!.toString()),
                        ]),
                      ),
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
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {},
                    ),
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
