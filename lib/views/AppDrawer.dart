import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/FavoritesPage.dart';

import '../utils/Globals.dart';
import '../viewmodel/HomePageModel.dart';
import 'HomePage.dart';
import 'MapScreen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  HomePageModel get homepageModel => getIt<HomePageModel>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Provider.of<HomePageModel>(context, listen: false).backgroundColor),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
              ),
            ),
            accountName: const Text("User Loc"),
            accountEmail: const Text(
              "user@dvt.co.za",
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            leading: const Icon(Icons.home),
            hoverColor: Colors.grey,
            title: const Text("Home"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
            leading: const Icon(Icons.favorite),
            hoverColor: Colors.grey,
            title: const Text("Favourites"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapScreen(),
                ),
              );
            },
            leading: const Icon(Icons.location_on_outlined),
            hoverColor: Colors.grey,
            title: const Text("Map"),
          ),
        ],
      ),
    );
  }
}
