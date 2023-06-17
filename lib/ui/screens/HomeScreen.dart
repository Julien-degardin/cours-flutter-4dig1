import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/ui/screens/FavoritesScreen.dart';
import 'package:cours_flutter/ui/screens/ListScreen.dart';
import 'package:cours_flutter/ui/screens/SearchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/model/FavFromFirestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<int> favorites = [];

  void initState() {
    super.initState();
    _getFav();
  }

  // On récupère les favoris dans une liste qu'on pourra transférer entre les écrans
  void _getFav() async {
    final fieldsRef =
    FirebaseFirestore.instance.collection('FAVORIS')
        .withConverter<FavFromFirestore>(
      fromFirestore: (snapshots, _) => FavFromFirestore.fromJson(snapshots.data()!),
      toFirestore: (station, _) => station.toJson(),
    );
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentSnapshot<FavFromFirestore> snapshot = await fieldsRef.doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (snapshot.exists) {
        if (snapshot.data() != null) {
          if (snapshot.data()!.stationId != null) {
            setState(() {
              favorites = snapshot.data()!.stationId!;
            });
          }
        }
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.amber[800],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Rechercher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favoris',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [ListScreen(favorites: favorites), SearchScreen(favorites: favorites) , FavoritesScreen(favorites: favorites)],
      ),
    );
  }
}
