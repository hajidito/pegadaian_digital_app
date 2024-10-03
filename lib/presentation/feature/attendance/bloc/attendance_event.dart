part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

final class AttendanceClickEvent extends AttendanceEvent {
  final AbsencesRequest absencesRequest;

  const AttendanceClickEvent({
    required this.absencesRequest,
  });

  @override
  List<Object> get props => [absencesRequest];
}
