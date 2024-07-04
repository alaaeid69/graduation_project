import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/cubit/auth_cubit/login_cubit/login_cubit.dart';
import 'package:gradproj/cubit/auth_cubit/register_cubit/register_cubit.dart';
import 'package:gradproj/screens/welcome&login/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void userState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('=================user is currently signed out');
      } else {
        debugPrint('=================user is signed in');
      }
    });
  }

  // getToken() async {
  //   String? myToken = await FirebaseMessaging.instance.getToken();
  //   debugPrint('=======================================');
  //   print(myToken);
  //   print('=======================================');
  // }
  // requestPermission()async{
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     debugPrint('User granted permission');
  //   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //     debugPrint('User granted provisional permission');
  //   } else {
  //     debugPrint('User declined or has not accepted permission');
  //   }
  // }

  @override
  void initState() {
    userState();
    super.initState();
    // getToken();
    // requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<RegisterCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<LoginCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Pulse',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
        ),
        home: Welcome(),
      ),
    );
  }
}
