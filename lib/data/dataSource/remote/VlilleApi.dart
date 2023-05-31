
import 'dart:convert';

import 'package:cours_flutter/data/model/VlilleApiResponse.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VlilleApi {

  Future<VlilleApiResponse> getVlille() async {
    Uri url = Uri.parse("https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&q=&facet=nom&facet=commune&facet=etat&facet=type&facet=etatconnexion&rows=300");
    http.Response response = await http.get(url);
    return compute(vlilleApiResponseFromJson, response.body);
  }

  VlilleApiResponse vlilleApiResponseFromJson(String body) {
    return VlilleApiResponse.fromJson(jsonDecode(body));
  }
}