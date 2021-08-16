import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import './user_details_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  static const routeName='./login_screen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _form=GlobalKey<FormState>();
  final _userIdController=TextEditingController();
  final _passwordController=TextEditingController();
  bool _isLoggedIn = false;
  String userId="";

  Alignment _fieldAlignment=Alignment.center;
  double _space=0;
  final _passwordFocusNode=FocusNode();
  //final _userIdFocusNode=FocusNode();
  List<Map<String,String>>users=[
    {"userName":"Flyingwolf","password":"1234"},
    {"userName":"Clutchgawd","password":"12345"}

  ];
  @override
  void initState() {
    // TODO: implement initState
    autoLogIn();
    super.initState();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('username').toString();
    //print(userId);print(users[0]['userName']);print(_userIdController.text);
    //final String? passWord=prefs.getString('password');

    if (userId == users[0]['userName']||userId==users[1]['userName']) {
      setState(() {
        _isLoggedIn = true;
      });
      return;
    }
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _userIdController.text);
    //prefs.setString('password',_passwordController.text );

    setState(() {
      _isLoggedIn = true;
    });

    //_userIdController.clear();
    //_passwordController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  // void _updateUserField(){
  //   if(!_userIdFocusNode.hasFocus){setState(() {
  //
  //   });}
  // }
  // void _updatePasswordField(){
  //   if(!_passwordFocusNode.hasFocus){setState(() {
  //
  //   });}
  // }
  void _saveForm(){
    var valid=_form.currentState!.validate();
    if(!valid)return;
      _form.currentState!.save();
      if((_userIdController.text==users[0]['userName']&&_passwordController.text==users[0]['password'])||
      (_userIdController.text==users[1]['userName']&&_passwordController.text==users[1]['password']))
      {
        loginUser();
        Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_){
            return _userIdController.text==users[0]['userName']?UserDetailsSection(users[0]['userName']):UserDetailsSection(users[1]['userName']);
          },
        ),
      );}
      else{
        showDialog(context: context,
            builder: (ctx)=>AlertDialog(
              title:Text("User not registered."),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(ctx).pop();
                }, child: Text("Okay.")
                )
              ],
            )

        );
      }


  }

  @override
  Widget build(BuildContext context) {
    _fieldAlignment=KeyboardVisibilityProvider.isKeyboardVisible(context)?Alignment.topCenter:Alignment.center;
    _space=KeyboardVisibilityProvider.isKeyboardVisible(context)?2:10;
     return _isLoggedIn?(userId==users[0]['userName']?UserDetailsSection(users[0]['userName']):UserDetailsSection(users[1]['userName'])):SingleChildScrollView(child:Form(
       key: _form,
       child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(height: _space),
              Align(
                alignment: _fieldAlignment,
                child: Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 100,
                    child: FittedBox(fit:BoxFit.contain,child: Image.network('https://cdn.game.tv/images/meet-tourney/game.tv-logo.png',))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: _space),
                child: Card(
                  shadowColor: Colors.red,
                  elevation: 10,
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                  child: TextFormField(
                    style: TextStyle(fontSize: 25),
                    decoration: InputDecoration(hasFloatingPlaceholder: true,contentPadding:EdgeInsets.all(15),enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color:Colors.pink),) ,filled:true,focusColor:Colors.blueAccent,hintText:"User Id" ,labelStyle: TextStyle(fontSize: 20,letterSpacing: 4,)),
                    controller: _userIdController,
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty)return "Enter UserId.";
                      if(value.length<3)return "Should be at least 3 characters long.";
                      if(value.length>10)return "Should be at most 10 characters long.";
                      if(users.contains(value))return "";
                      return null;
                    },
                    //focusNode: _userIdFocusNode,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    onSaved: (value){

                    },
          ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: _space),
                child: Card(
                  shadowColor: Colors.red,
                  margin: EdgeInsets.symmetric(vertical: _space,horizontal: 20),
                  elevation: 10,
                  child: TextFormField(
                    style: TextStyle(fontSize: 25),
                    controller: _passwordController,
                    decoration: InputDecoration(hasFloatingPlaceholder: true,contentPadding:EdgeInsets.all(15),enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color:Colors.green),),filled:true,focusColor:Colors.blueAccent,hintText:"Password",labelStyle: TextStyle(fontSize: 20,letterSpacing: 4) ),
                    textInputAction: TextInputAction.done,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    validator: (value){
                      if(value!.isEmpty)return "Enter Password.";
                      if(value.length<3)return "Should be at least 3 characters long.";
                      if(value.length>10)return "Should be at most 10 characters long.";
                      return null;
                    },
                    onFieldSubmitted: (_){
                      _saveForm();
                    },
                    onSaved: (value){

                    },
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: _space),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),color: Colors.blueAccent),
                  child: TextButton(
                    onPressed: (){
                      _saveForm();
                    },
                    child: Text("Enter",
                      style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),))),
             // SizedBox(height: 85),
              //,color: Colors.pinkAccent,child: TextButton(onPressed: (){}, child: Text("Enter",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white),))),
          ]
          ),


    ));




  }
}