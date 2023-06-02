import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  // const DetailsScreen({super.key, required this.fields});
  const DetailsScreen({super.key});

  // final Fields fields;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  void startHammering() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('https://picsum.photos/500/600'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    'Station test youhou youhou youhou',
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Text(
                  '20 km',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: Icon(
                  Icons.star_border,
                  color: CupertinoColors.systemYellow,
                  size: 40,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    /*Uri googleMapsUri = Uri.parse('https://maps.google.com/maps?saddr=50.630238,3.056559&daddr=${records![index].fields!.localisation![0]},${records![index].fields!.localisation![1]}');
                    launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);*/
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Y aller', style: TextStyle(color: Colors.white, fontSize: 16)), // <-- Text
                      SizedBox(
                        width: 5,
                      ),
                      Icon( // <-- Icon
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                    child: Icon(Icons.pedal_bike_sharp, color: Colors.blue)),
                SizedBox(width: 8),
                Text(
                  '5 vélos',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                    child:
                        Icon(Icons.local_parking_outlined, color: Colors.blue)),
                SizedBox(width: 8),
                Text(
                  '5 places',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                    child: Icon(Icons.credit_score, color: Colors.blue)),
                SizedBox(width: 8),
                Text(
                  'Paiement en carte',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Chip(label: Text("Test")),
                Chip(label: Text("Test")),
                Chip(label: Text("Test")),
                Chip(label: Text("Test")),
                Chip(label: Text("Test"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
