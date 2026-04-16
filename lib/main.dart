import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import core services
import 'core/services/local_storage_service.dart';

//Global Providerss
//1. SharedPreferences Provider(Overriden in main )
final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPrefsProvider not initialized');
});

//2.LocalStorageService Provider
final localSharedProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('localstorageProvider not initalized ');
});

void main() async {
  //Ensure native bindings are ready
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Firebase
  //try catch to handle any initialization errors
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initalization warning: $e');
  }

  //Load SharedPreferences before the UI starts to prevent layout jumping
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
    //check if userID already exists locally
    final localStorage = ref.watch(localSharedProvider);
    final savedUserId = localStorage.getUserId();

    return MaterialApp(
      title: 'Bus Vendor Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),

      //basic routing logic based on session
      home: savedUserId != null
          ? const DashboardPlaceholder()
          : const LoginPlaceholder(),
    );
  }
}

// temporary placeholders
class LoginPlaceholder extends StatelessWidget {
  const LoginPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Login Screen Goes Here', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class DashboardPlaceholder extends StatelessWidget {
  const DashboardPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Vendor dashboard goes here',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
