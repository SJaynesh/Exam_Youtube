import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/History_Model.dart';

class History_Proivider extends ChangeNotifier {
  History_Model h1;

  History_Proivider({required this.h1});

  addValueHistory(val) async {
    h1.History.add(val);

    SharedPreferences Pref = await SharedPreferences.getInstance();
    Pref.setStringList("History", h1.History);
    notifyListeners();
  }

  deleteHistory(i) {
    h1.History.removeAt(i);

    notifyListeners();
  }
}
