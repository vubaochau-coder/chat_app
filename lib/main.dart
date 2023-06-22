import 'package:chat_app/Authentication/ui/authentication_page.dart';
import 'package:chat_app/Chat/bloc/chat_bloc.dart';
import 'package:chat_app/Friends/bloc/friends_bloc.dart';
import 'package:chat_app/Friends/ui/friend_list_page.dart';
import 'package:chat_app/Login/bloc/login_bloc.dart';
import 'package:chat_app/Register/bloc/register_bloc.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => FriendsBloc()),
        BlocProvider(create: (context) => ChatBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const FriendListPage();
            } else {
              return const AuthenticationPage();
            }
          },
        ),
      ),
    );
  }
}
