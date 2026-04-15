import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(sharedPreferences)],
      child: const VendorApp(),
    ),
  );
}

class VendorApp extends ConsumerWidget {
  const VendorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title:'Bus Vendor Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:Colors.blueAccent),
        useMaterial3:true,
      ),

      home: const Scaffold(
        body:Center(
          child:Text('Vendor App Initialized Successfully!'),
        ),
      ),
    );
  }
}
