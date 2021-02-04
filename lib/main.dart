import 'package:curbwheel/ui/features/features_screen.dart';
import 'package:curbwheel/ui/map/map_screen.dart';
import 'package:curbwheel/ui/projects/project_list_screen.dart';
import 'package:curbwheel/service/bluetooth_service.dart';
import 'package:curbwheel/ui/splash/splash_screen.dart';
import 'package:curbwheel/ui/wheel/wheel_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (BuildContext context) => BleConnection()),
      ChangeNotifierProxyProvider<BleConnection, WheelCounter>(
        create: (BuildContext context) => WheelCounter(),
        update: (BuildContext context, BleConnection bleConnection,
                WheelCounter existingWheelCounter) =>
            existingWheelCounter.updateConnection(bleConnection),
      )
    ], child: CurbWheel()));

class CurbWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => CurbWheelDatabase(),
      child: MaterialApp(
        title: 'CurbWheel',
        theme: ThemeData(
          fontFamily: 'Raleway',
          primaryColor: Colors.black,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            subtitle2: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == WheelScreen.routeName) {
            final WheelScreenArguments args = settings.arguments;
            return MaterialPageRoute(
              builder: (context) {
                return WheelScreen(args.project, args.survey, args.incompleteSpans,
                    listItem: args.listItem);
              },
            );
          } else {
            return null;
          }
        },
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          ProjectListScreen.routeName: (context) => ProjectListScreen(),
          MapScreen.routeName: (context) => MapScreen(),
          //WheelScreen.routeName: (context) => WheelScreen(),
          FeatureSelectScreen.routeName: (context) => FeatureSelectScreen(),
        },
      ),
    );
  }
}
