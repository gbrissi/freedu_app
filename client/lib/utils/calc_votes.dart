import '../shared/http/models/vote_model.dart';

int calcVotes(List<VoteModel> votes) {
  int calc = 0;
  for (final VoteModel vote in votes) {
    calc = calc + vote.value;
  }

  return calc;
}
