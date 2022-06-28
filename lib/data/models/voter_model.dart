class Voters {
  bool isVoted;
  int? votedId;
  String userHrCode;

  int votes1 = 3;
  int votes2 = 2;
  int votes3 = 3;

  Voters({required this.userHrCode,this.isVoted = false, this.votedId});
}