import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sondage/vote_bloc/vote_blocs.dart';
import 'package:sondage/vote_bloc/vote_events.dart';
import 'package:sondage/vote_bloc/vote_states.dart';

class SondageScreen extends StatelessWidget {
  const SondageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<VoteBlocs>().add(PostVotes("windows"));
              },
              child: Row(
                children: [
                  const Expanded( 
                    flex: 1, 
                    child: Row(
                      children: [
                        Icon(Icons.window),
                        Text('Windows'),
                      ],
                    ),
                  ),
                  BlocBuilder<VoteBlocs, VotesState>(
                    builder: (context, state) {
                      if (state is VotesInitial || state is VotesLoading) {
                        return const CircularProgressIndicator();

                      } else if (state is VotesLoaded) {
                        return Text('${state.votes.getWindowsPercent()} %');
                      }
                      return Container();
                    },
                  )
                ],
              )
            ),
            ElevatedButton(
              onPressed: () {
                context.read<VoteBlocs>().add(PostVotes("apple"));
              },
              child: Row(
                children: [
                  const Expanded( 
                    flex: 1, 
                    child: Row(
                      children: [
                        Icon(Icons.apple),
                        Text('Apple'),
                      ],
                    ),
                  ),
                  BlocBuilder<VoteBlocs, VotesState>(
                    builder: (context, state) {
                      if (state is VotesInitial || state is VotesLoading) {
                        return const CircularProgressIndicator();

                      } else if (state is VotesLoaded) {
                        return Text('${state.votes.getApplePercent()} %');
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Déconnexion'),
            )
          ],
        ),
      ),
    );
  }
}
