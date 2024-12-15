import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sondage/firebase_repository.dart';
import 'package:sondage/vote_bloc/vote_events.dart';
import 'package:sondage/vote_bloc/vote_states.dart';
import 'package:sondage/votes.dart';

class VoteBlocs extends Bloc<VotesEvent, VotesState> {
  Votes votes = Votes(windows: 0, apple: 0);

  VoteBlocs() : super(VotesInitial()) {
    on<FetchVotes>((event, emit) async {
      emit(VotesLoading());

      try {
        votes = await FirebaseRepository.getVotes();
        emit(VotesLoaded(votes));
      } catch (e) {
        emit(VotesError("Erreur lors du chargement des films"));
      }
    });

    on<PostVotes>((event, emit) async {
      try {
        if (event.platform == "windows") {
          votes.windows += 1;
        } else if (event.platform == "apple") {
          votes.apple += 1;
        }

        await FirebaseRepository.saveVotes(votes);

        emit(VotesLoaded(votes));
      } catch (e) {
        emit(VotesError("Erreur lors de l'ajout d'un vote"));
      }
    });
  }
}
