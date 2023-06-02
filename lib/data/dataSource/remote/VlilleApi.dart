
import 'dart:convert';

import 'package:cours_flutter/data/model/VlilleApiResponse.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VlilleApi {

  VlilleApiResponse? memory;

  Future<VlilleApiResponse> getVlille() async {
    if (memory == null) {
      Uri url = Uri.parse(
          "https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&q=&facet=nom&facet=commune&facet=etat&facet=type&facet=etatconnexion&rows=300");
      http.Response response = await http.get(url);
      memory = await compute(vlilleApiResponseFromJson, response.body);
    }
    return Future.value(memory);
  }

  VlilleApiResponse vlilleApiResponseFromJson(String body) {
    return VlilleApiResponse.fromJson(jsonDecode(body));
  }
}