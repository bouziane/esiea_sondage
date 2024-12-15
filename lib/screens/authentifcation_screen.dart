import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:sondage/screens/sondage_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sondage/vote_bloc/vote_blocs.dart';
import 'package:sondage/vote_bloc/vote_events.dart';

class AuthentifcationScreen extends StatelessWidget {
  const AuthentifcationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
          );
        }
        return BlocProvider(
          create: (context) => VoteBlocs()..add(FetchVotes()),
          child: const SondageScreen()
        );
      },
    );
  }
}
