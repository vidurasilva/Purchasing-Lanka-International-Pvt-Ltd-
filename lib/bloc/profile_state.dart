import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/user.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => null;
}

class ProfileLoadedState extends ProfileState {
  final User user;

  ProfileLoadedState(this.user);
  @override
  List<Object> get props => [user];
  @override
  String toString() => '{ "user: userMe"}';
}
