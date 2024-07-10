import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:flutter_application_1/core/login_modal.dart';
import 'package:flutter_application_1/entities/favorite_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Map<String, dynamic>> _favorites = [];
  bool isLoading = true;
  String token = GlobalVariables().token;
  void _refreshFavorites() async {
    final data = await FavoriteHelper.getItems();
    setState(() {
      _favorites = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshFavorites();
    debugPrint(" Number of items: ${_favorites.length}");
  }

  @override
  Widget build(BuildContext context) {
    Future<void> deleteFavorite(String name) async {
      await FavoriteHelper.deleteItemByName(name);
      _refreshFavorites();
    }

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.favorites,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gill'),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          if (GlobalVariables().loggedIn) {
                            Navigator.pushNamed(context, '/webpage',
                                arguments: {
                                  'url': '${_favorites[index]['url']}',
                                  'name': '${_favorites[index]['name']}'
                                });
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                GlobalVariables().globalUrl =
                                    '${_favorites[index]['url']}';
                                return LoginModal();
                              },
                            );
                          }
                        },
                        title: Text('${_favorites[index]['name']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline_outlined),
                          onPressed: () {
                            debugPrint('Delete this');
                            deleteFavorite(_favorites[index]['name']);
                          },
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
