import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class UserDetails  {
  final String userName;
  final String name;
  final String imageUrl;
  final double rating;
  final double played;
  final double won;
  final double winPercent;

  UserDetails({required this.imageUrl,required this.name,required this.played,required this.rating,required this.userName,required this.winPercent,required this.won});


}

class UserDetailsData with ChangeNotifier{
  List<UserDetails> _users=[];
  List<UserDetails> get users {
    return [..._users];
  }
  List<UserDetails>loadedData=[];
  Future<UserDetails> fetchUser(String user) {
    const url="https://5ab072efd1af.ngrok.io/getUsers";//https://6d4c4c48b9a1.ngrok.io/getUsers
    return http.get(Uri.parse(url)).then((response) {
      var extractedData=json.decode(response.body)as Map<String,dynamic>;
      List<UserDetails>loadedData=[];
      loadedData.add(UserDetails(
          imageUrl: extractedData['user1']['imageurl'],
          name: extractedData['user1']['name'],
          played: double.parse(extractedData['user1']['tournamentsplayed']),
          rating: double.parse(extractedData['user1']['rating']),
          userName: extractedData['user1']['userId'],
          winPercent: double.parse(extractedData['user1']['winningpercentage']),
          won: double.parse(extractedData['user1']['tournamentswon'])));
      loadedData.add(UserDetails(
          imageUrl: extractedData['user2']['imageurl'],
          name: extractedData['user2']['name'],
          played: double.parse(extractedData['user2']['tournamentsplayed']),
          rating: double.parse(extractedData['user2']['rating']),
          userName: extractedData['user2']['userId'],
          winPercent: double.parse(extractedData['user2']['winningpercentage']),
          won: double.parse(extractedData['user2']['tournamentswon'])));
          _users=loadedData;
          notifyListeners();
          if(user==_users[0].userName)return _users[0];
          else return _users[1];

    }).catchError((err){
      //print(err);
      throw(err);

    });}
  UserDetails user(int i){
    print(users.length);
    return users[i];
  }

}

