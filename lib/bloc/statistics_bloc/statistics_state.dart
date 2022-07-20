part of 'statistics_cubit.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();
}

enum StatisticsEnumStates { initial, success, failed }

class StatisticsInitial extends Equatable {
  final StatisticsEnumStates statisticsStates;
  final List<Statistics> statisicsList;

  const StatisticsInitial({
    this.statisticsStates = StatisticsEnumStates.initial,
    this.statisicsList = const <Statistics>[],
  });

  StatisticsInitial copyWith({
    StatisticsEnumStates? statisticsStates,
    List<Statistics>? statisicsList,
  }) {
    return StatisticsInitial(
      statisticsStates: statisticsStates ?? this.statisticsStates,
      statisicsList: statisicsList ?? this.statisicsList,
    );
  }

  @override
  List<Object> get props => [
        statisticsStates,
        statisicsList,
      ];
}
