import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:google_mobile_ads/google_mobile_ads.dart";
import "package:provider/provider.dart";
import "app.dart";
import "providers/bookmark.dart";
import "providers/theme.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider())
      ],
      child: const MyApp(),
    ),
  );
}
