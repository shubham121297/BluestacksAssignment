import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project_blue/screens/log_in_screen.dart';
import 'package:provider/provider.dart';
import './screens/log_in_screen.dart';
import './providers/recommended.dart';
import './providers/user_details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context)=>Recommended(),),
        ChangeNotifierProvider(
          create: (context)=>UserDetailsData(),),
    ],
        child: MaterialApp(
          title: "BlueApp",
          theme: ThemeData(textSelectionTheme:TextSelectionThemeData(cursorColor: Colors.pinkAccent)),
          routes: {
           LogInScreen.routeName: (context) => LogInScreen(),
         },
          home: KeyboardVisibilityProvider(
            child: Scaffold(
              body: Stack(
                children: [Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                  Center(child: LogInScreen()),
            ],
              ),

            ),
          ),
        ),
    );

  }
}


