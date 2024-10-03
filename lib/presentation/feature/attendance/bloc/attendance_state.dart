part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();
}

final class AttendanceInitial extends AttendanceState {
  @override
  List<Object> get props => [];
}

final class AttendanceLoadingState extends AttendanceState {
  @override
  List<Object> get props => [];
}

final class AttendanceErrorState extends AttendanceState {
  final String message;

  const AttendanceErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class AttendanceLoadedState extends AttendanceState {
  final AbsencesResponse attendanceResponse;

  const AttendanceLoadedState({required this.attendanceResponse});

  @override
  List<Object> get props => [attendanceResponse];
}
