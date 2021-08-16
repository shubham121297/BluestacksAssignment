import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recommended.dart';
class RecommendedFor extends StatelessWidget {

  final String coverUrl;
  final String gameName;
  final String name;
  RecommendedFor({required this.coverUrl,required this.gameName,required this.name});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
            child: Image.network(coverUrl,height: 135,width: double.infinity,fit: BoxFit.cover,),
          ),
          SizedBox(height: 100,
              child: Column(
                  children: [
                    SizedBox(height:10),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 10, 0),
                            child: Text(name,softWrap:false,overflow: TextOverflow.ellipsis,maxLines:1 ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),))),

                    SizedBox(
                      height:20,
                      child: Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.symmetric(vertical:0,horizontal: 2),
                          child: IconButton(onPressed: (){},icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black45,),)),

                    ),

                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                        child: Text(gameName,maxLines:1,style: TextStyle(fontSize: 16,),)),
                    SizedBox(height:7),
                  ])

          ),
        ],
        // height:100,width: MediaQuery.of(context).size.width,
        // child:Image.network(recData[index].coverUrl),
      ),
    );
  }
}
