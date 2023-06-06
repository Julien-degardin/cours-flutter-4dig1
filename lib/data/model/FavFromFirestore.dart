class FavFromFirestore {
  List<int>? stationId;

  FavFromFirestore({this.stationId});

  FavFromFirestore.fromJson(Map<String, dynamic> json) {
    stationId = json['stationId'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stationId'] = stationId;
    return data;
  }
}