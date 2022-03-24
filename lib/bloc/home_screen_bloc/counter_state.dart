part of 'counter_cubit.dart';

// @immutable
// abstract class CounterState {}

class CounterState {
  int counterValue;
  bool wasIncremented;

  CounterState({
    required this.counterValue,
    required this.wasIncremented,
  });

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    if (map == null) return CounterState(
      counterValue: 0,
      wasIncremented: false,
    );

    return CounterState(
      counterValue: map['counterValue'],
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));
}
