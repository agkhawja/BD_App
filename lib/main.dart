import 'package:bd_app/screens/route.dart';
import 'package:bd_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionStatus locationPermissionStatus = await Permission.locationWhenInUse.request();
  if (locationPermissionStatus.isDenied || locationPermissionStatus.isPermanentlyDenied) {
    // Exiting the app if permission is denied
    SystemNavigator.pop();
    return;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BD App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: RoutePage(),
        );
      },
    );
  }
}
