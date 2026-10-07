import 'package:flutter/material.dart';

import '../../features/waitlist/presentation/view/waitlist_screen.dart';

class AppRoutes {
   static Route? OnGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
     
      case '/waitlist':
        return MaterialPageRoute(builder: (_) => WaitlistScreen());
      
     
      default:
        return null; // Return null for undefined routes
   }}
}
