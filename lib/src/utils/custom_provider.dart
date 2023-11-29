import 'package:flutter/material.dart';
import 'package:saudi_adaminnovations/src/utils/app_tags.dart';
class ThemeProvider extends ChangeNotifier {
  String sortKey="latest_on_top";
  getSortKey()=>sortKey;
  setSortKey(String sort){
    sortKey=sort;
    notifyListeners();
  }
  String sort=AppTags.latestontop;
  getSort()=>sort;
  setSort(String s){
    sort=s;
    notifyListeners();
  }

}