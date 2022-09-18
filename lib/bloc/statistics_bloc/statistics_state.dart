part of 'statistics_cubit.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();
}

enum StatisticsEnumStates { initial, success, failed }

class StatisticsInitial extends Equatable {
  final StatisticsEnumStates statisticsStates;
  final List<Statistics> statisticsList;

  const StatisticsInitial({
    this.statisticsStates = StatisticsEnumStates.initial,
    this.statisticsList = const <Statistics>[],
  });

  StatisticsInitial copyWith({
    StatisticsEnumStates? statisticsStates,
    List<Statistics>? statisticsList,
  }) {
    return StatisticsInitial(
      statisticsStates: statisticsStates ?? this.statisticsStates,
      statisticsList: statisticsList ?? this.statisticsList,
    );
  }

  @override
  List<Object> get props => [
        statisticsStates,
        statisticsList,
      ];
}
