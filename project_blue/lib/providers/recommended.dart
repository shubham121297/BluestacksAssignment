import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class RecommendedData{
  final String name;
  final String gameName;
  final String coverUrl;
  
  RecommendedData({required this.coverUrl,required this.gameName,required this.name});

}
class Recommended with ChangeNotifier{

  List<RecommendedData>_items=[];
  
  List<RecommendedData> get items{
    return [..._items];
  }

  Future<void> fetchDetails() {
    const url='http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all';
    return http.get(Uri.parse(url)).then((response) {
      var extractedData=json.decode(response.body)as Map<String,dynamic>;
      String extractedCursor=extractedData['data']['cursor'];
      String url='http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor='+extractedCursor;
      return http.get(Uri.parse(url)).then((value) {
        var finalData=json.decode(value.body)as Map<String,dynamic>;
        final List<dynamic> data=finalData['data']['tournaments'];
        List<RecommendedData>loadedData=[];
        for(int i=0;i<data.length;i++){
          loadedData.add(RecommendedData(coverUrl: data[i]['cover_url'],gameName: data[i]['game_name'],name: data[i]['name']));
        }
        _items=loadedData;
        notifyListeners();


      }).catchError((err){
        throw err;
      });

    }
    ).catchError((err){
      throw err;
    });



  }


}