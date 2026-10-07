import 'package:flutter/material.dart';

import '../../core/routes/app_pages.dart';
import '../../core/routes/app_routes.dart';

class RestaurentApp extends StatelessWidget {
  const RestaurentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurent App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.OnGenerateRoute,
      initialRoute: AppPages.waitlist ,
    );
  }
}