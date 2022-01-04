import 'package:flutter/material.dart';
import 'package:josequal/ui/screens/favorite_screen.dart';
import 'package:josequal/ui/screens/home_screen.dart';
import 'package:josequal/ui/screens/search%20_screen.dart';


class AppRouter{
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_)=> HomeScreen());
      case '/searchScreen':
        return MaterialPageRoute(builder: (_)=> SearchScreen());
      case '/favoriteScreen':
        return MaterialPageRoute(builder: (_)=> FavoriteScreen());
      default:
        return null;
    }
  }
}