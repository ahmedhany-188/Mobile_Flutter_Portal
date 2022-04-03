import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/benefits_screen_bloc/benefits_cubit.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);

  List<dynamic> benefitsData = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BenefitsCubit()..getBenefits(),
      child: BlocConsumer(
        listener:(context, state) {
    if (state is BenefitsSuccessState) {
      benefitsData = state.benefits;
    }
    },
        builder: (context, state) => Center(child: Text(benefitsData[0]['benefitsDescription']),),
      ),
    );
  }
}
