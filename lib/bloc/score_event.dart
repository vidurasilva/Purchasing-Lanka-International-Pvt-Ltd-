import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ScoreEvent extends Equatable {
  const ScoreEvent();
}

class ScoreLoading extends ScoreEvent {
  @override
  List<Object> get props => [];
}
