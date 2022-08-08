import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polls/flutter_polls.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../data/models/voter_model.dart';

class PollsScreen extends StatefulWidget {
  const PollsScreen({Key? key}) : super(key: key);
  static const routeName = 'polls-screen';
  @override
  State<PollsScreen> createState() => _PollsScreenState();
}
Voters votedUser = Voters(userHrCode:'user.userHRCode!');

class _PollsScreenState extends State<PollsScreen> {
  // int votes1 = votedUser.votes1;
  // int votes2 = votedUser.votes2;
  // int votes3 = votedUser.votes3;

  @override
  Widget build(BuildContext context) {
    final userData = context.select((AppBloc bloc) => bloc.state.userData);
    if (kDebugMode) {
      print('${votedUser.isVoted}''  ${votedUser.votedId.toString()}' );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Container(

      )
    //FlutterPolls(
      //   userToVote: userData.user!.token,
      //   pollStartDate: DateTime.now(),
      //   pollId: 'Example',
      //   onVoted:
      //       (PollOption pollOption, int newTotalVotes) {
      //     switch (pollOption.id) {
      //       case 1:
      //         votedUser.votes1++;
      //         break;
      //       case 2:
      //         votedUser.votes2++;
      //         break;
      //       case 3:
      //         votedUser.votes3++;
      //         break;
      //     }
      //     setState(() {
      //       votedUser.votedId = pollOption.id!;
      //       votedUser.isVoted = true;
      //     });
      //   }
      //   ,
      //   pollTitle: const Text('Example Polls'),
      //   userVotedOptionId: votedUser.votedId,
      //   hasVoted: votedUser.isVoted,
      //   pollOptions: [
      //     PollOption(title: const Text('Option 1'), votes: votedUser.votes1, id: 1),
      //     PollOption(title: const Text('Option 2'), votes: votedUser.votes2, id: 2),
      //     PollOption(title: const Text('Option 3'), votes: votedUser.votes3, id: 3),
      //   ],
      // ),
    );
  }
}


