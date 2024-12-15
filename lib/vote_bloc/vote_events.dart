abstract class VotesEvent {}

class FetchVotes extends VotesEvent {}
class PostVotes extends VotesEvent {
  final String platform;

  PostVotes(this.platform);
}