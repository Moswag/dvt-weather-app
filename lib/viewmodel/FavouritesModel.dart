import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';

import '../models/Favorite.dart';

class FavoriteModel with ChangeNotifier {
  late List<Favorite> listFavorites;
  String dbName = 'favorite';
  bool isLoading = false;

  loadFavorites() async {
    setLoadingState(true);
    final box = await Hive.openBox<Favorite>(dbName);
    listFavorites = box.values.toList();
    setLoadingState(false);
  }

  saveFavorite(Favorite favorite) async {
    var box = await Hive.openBox<Favorite>(dbName);
    box.add(favorite);
    showSimpleNotification(const Text('Location successfully saved'), background: Colors.grey, duration: const Duration(seconds: 5), position: NotificationPosition.bottom);
  }

  void setLoadingState(bool isPending) {
    isLoading = isPending;
    notifyListeners();
  }
}
