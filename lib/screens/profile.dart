import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<dynamic> _taxi;

  Future<dynamic> _getTaxi() async {
    try {
      final response = await http.get(
          Uri.parse("http://192.168.88.24:8000/api/taxis/id/${widget.id}"));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _taxi = _getTaxi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(widget.appBarTitle),
      ),
      body: FutureBuilder<dynamic>(
        future: _taxi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Skeletonizer.zone(
              child: ListTile(
                leading: Bone.circle(size: 48),
                title: Bone.text(words: 2),
                subtitle: Bone.text(words: 1),
                trailing: Bone.icon(),
                isThreeLine: true,
              ),
            );
          }

          if (snapshot.hasData) {
            final taxi = snapshot.data['data']['taxi'];

            print("taxi_photos: ${taxi['taxi_photos']}");

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ListTile(
                        leading: taxi['taxi_profile'] != null
                            ? ClipOval(
                                child: Image.network(
                                  taxi['taxi_profile'],
                                  width: 56,
                                  height: 56,
                                  semanticLabel: "Profile Image",
                                ),
                              )
                            : SizedBox(
                                width: 56,
                                height: 56,
                                child: CircleAvatar(),
                              ),
                        title: Text(taxi['taxi_name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@${taxi['taxi_username']}",
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white54
                                    : Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white54
                                      : Colors.black54,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${taxi['taxi_city']}",
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white54
                                        : Colors.black54,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${taxi['taxi_address']}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "${taxi['taxi_popularity']}",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 3),
                                RatingBar.builder(
                                  updateOnDrag: false,
                                  itemCount: 5,
                                  itemSize: 14,
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  initialRating: taxi['taxi_popularity'],
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  unratedColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white24
                                      : Colors.black26,
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await launchUrl(
                                      Uri(
                                        scheme: "tel",
                                        path: taxi['taxi_phone'],
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    // elevation: 0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 18,
                                        semanticLabel: "Phone",
                                      ),
                                      SizedBox(width: 6),
                                      Text("Phone")
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await launchUrl(
                                      Uri(
                                        scheme: "https",
                                        host: "api.whatsapp.com",
                                        path: "send",
                                        queryParameters: {
                                          'phone': taxi['taxi_phone']
                                        },
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.green,
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        MaterialCommunityIcons.whatsapp,
                                        size: 18,
                                        semanticLabel: "WhatsApp",
                                      ),
                                      SizedBox(width: 6),
                                      Text("WhatsApp")
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_outline,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white54
                                    : Colors.black54,
                          ),
                        ),
                        isThreeLine: true,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: taxi['taxi_photos']?.length ?? 0,
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 6,
                                      sigmaY: 6,
                                    ),
                                    child: Hero(
                                      transitionOnUserGestures: true,
                                      tag: 'imageHero$index',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          taxi['taxi_photos'][index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              taxi['taxi_photos'][index],
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) {
                                  return child;
                                } else {
                                  return Skeletonizer.zone(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Bone.square(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );

            return Text("The data has just come!");
          }

          return Text("");
        },
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final appBarTitle;
  final id;
  const ProfileScreen({required this.id, required this.appBarTitle, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
