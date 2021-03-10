import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Components/GetPass.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/MyWacther.dart';
import 'package:watcher_app_for_user/Modules/UserApp/UserDashboard.dart';

import 'Constants/appColors.dart';
import 'Data/Providers/BottomNavigationBarProvider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
            create: (context) => BottomNavigationBarProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: appPrimaryMaterialColor,
                centerTitle: true,
                textTheme: TextTheme(
                    // ignore: deprecated_member_use
                    title: TextStyle(color: Colors.white, fontSize: 18))),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: appPrimaryMaterialColor),
            primaryColor: appPrimaryMaterialColor,
            fontFamily: 'Montserrat'),
        home: UserDashboard(),
      ),
    );
  }
}
