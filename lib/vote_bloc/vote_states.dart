import 'package:sondage/votes.dart';

abstract class VotesState {}

class VotesInitial extends VotesState {}

class VotesLoading extends VotesState {}

class VotesLoaded extends VotesState {
  final Votes votes;

  VotesLoaded(this.votes);
}

class VotesError extends VotesState {
  final String message;

  VotesError(this.message);
}

class AddVote extends VotesState {
  
}
