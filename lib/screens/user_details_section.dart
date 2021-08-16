import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_blue/screens/log_in_screen.dart';
import 'package:provider/provider.dart';
import '../providers/recommended.dart';
import '../widgets/recommended_for.dart';
import '../providers/user_details.dart';
class UserDetailsSection extends StatefulWidget {
  
  final String? user;
  UserDetailsSection(this.user);

  @override
  _UserDetailsSectionState createState() => _UserDetailsSectionState();
}

class _UserDetailsSectionState extends State<UserDetailsSection> {
  var _isInIt=true;
  var _isLoading=true;
  var x;
  UserDetails userData=UserDetails(imageUrl: "", name: "", played: 0, rating: 0, userName: "", winPercent: 0, won: 0);
  
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   //Future.delayed(Duration.zero).then((_) => Provider.of<Recommended>(context).fetchDetails());
  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
     x=MediaQuery.of(context).size.width;
    // TODO: implement didChangeDependencies
    if(_isInIt){
            Provider.of<UserDetailsData>(context).fetchUser(widget.user.toString())
           .catchError((err){
             showDialog(context: context,
             builder: (ctx)=>AlertDialog(
               title:Text("An error occurred!"),
               content: Text("Something went wrong."),//we don't want to show the exact technical error to user for confidential reasons.
               actions: [
                 TextButton(onPressed: (){
                   Navigator.of(ctx).pop();
                  // Navigator.of(context).pushNamed(LogInScreen.routeName);
                 }, child: Text("Okay.")
                 )
               ],
             )

         );
       })
           .then((value) {
             userData=UserDetails(
               imageUrl: value.imageUrl, 
               name: value.name, 
               played: value.played, 
               rating: value.rating, 
               userName: value.userName, 
               winPercent: value.winPercent, 
               won: value.won);
              setState(() {
                //_isLoading1=false;
                //print("hey");
         });

       });
       //_isLoading1=true;
      Provider.of<Recommended>(context).fetchDetails()
        .catchError((err){
          return showDialog<Null>(context: context,
              builder: (ctx)=>AlertDialog(
                title:Text("An error occurred!"),
                content: Text("Something went wrong."),//we don't want to show the exact technical error to user for confidential reasons.
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(ctx).pop();
                  }, child: Text("Okay.")
                  )
                ],
              )

          );

    })
        .then((value) {
          setState(() {
            _isLoading=false;
      });
    });
    }
    _isInIt=false;
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsData>(context).users;
    var recData=Provider.of<Recommended>(context).items;
    return _isLoading?Scaffold(body: Center(child:CircularProgressIndicator()),):Scaffold(
      appBar: AppBar(
        leading:(
          Icon(Icons.short_text,
          textDirection: TextDirection.rtl,
          color: Colors.black,size: 40,)),
        title: Container(
          margin: EdgeInsets.fromLTRB(x*0.2, 2, x*0.2,2),
          child: Text(
            widget.user.toString(),
            style: TextStyle(color: Colors.black),)),
          // actions: [
          //   IconButton(
          //     icon:Icon(Icons.logout,color: Colors.black),
          //     onPressed: (){
                
          //        //Navigator.of(context).pop();
                  
                
                
          //     },)],
          backgroundColor: Colors.white,
          elevation: 0,),
      body: Column(
        children: [Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 90,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(userData.imageUrl),
                      fit: BoxFit.fill
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5,20,20,20),
                  child: Text(
                    userData.name,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                Chip(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blueAccent),
                  label:Row(children: [
                    Text(
                      userData.rating.toInt().toString(),
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.blueAccent),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,1,10,1),
                      child: Text("Elo rating",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),)),
                  ],)
                )
              ],)
            ]),
          Container(
            width: MediaQuery.of(context).size.width*0.87,
            height: 90,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.amber,),
            child: Row(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.29,
                      color: Colors.orange,
                      child:Column(
                        children: [
                          SizedBox(height: 8),
                          Text(userData.played.toInt().toString(),style: TextStyle(color: Colors.white,fontSize: 17),),
                          SizedBox(height: 8),
                          Text("Tournaments",style: TextStyle(color: Colors.white),),
                          SizedBox(height: 8),
                          Text("played",style: TextStyle(color: Colors.white),),

                                ],
                              ),
                              ),
                  ),
                          ),
                Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.29,
                              color: Colors.purple,
                              child: Column(
                                children: [
                                  SizedBox(height: 8),
                                  Text(userData.won.toInt().toString(),style: TextStyle(color: Colors.white,fontSize: 17),),
                                  SizedBox(height: 8),
                                  Text("Tournaments",style: TextStyle(color: Colors.white),),
                                  SizedBox(height: 8),
                                  Text("won",style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.29,
                                color: Colors.red,
                                child:Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text("${userData.winPercent.toInt().toString()}%",
                                      style: TextStyle(color: Colors.white,fontSize: 17),),
                                    SizedBox(height: 8),
                                    Text("Winning",style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 8),
                                    Text("percentage",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
        Align(
          alignment:Alignment.centerLeft,
          child: Padding(
            padding:EdgeInsets.fromLTRB(26, 10 , 20, 10),
            child: Text(
              "Recommended for you",
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),))),
        Expanded(
          child: ListView.builder(
            itemCount: recData.length,
            itemBuilder: (ctx,index){
              return _isLoading
              ?Center(child: CircularProgressIndicator(),)
              :RecommendedFor(
                coverUrl: recData[index].coverUrl, 
                gameName: recData[index].gameName, 
                name: recData[index].name);
            }
            ),
        )




        ]
      ),


    );}}
