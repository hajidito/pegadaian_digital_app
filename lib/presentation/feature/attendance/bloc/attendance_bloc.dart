import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/model/request/absences_request.dart';
import 'package:pegadaian_digital/data/model/response/absences_response.dart';
import 'package:pegadaian_digital/data/pegadaian_repository.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  PegadaianRepository pegadaianRepository;
  Logger log;

  AttendanceBloc({
    required this.pegadaianRepository,
    required this.log,
  }) : super(AttendanceInitial()) {
    on<AttendanceClickEvent>(_attendance);
  }

  void _attendance(
      AttendanceClickEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoadingState());

    final result = await pegadaianRepository.absences(event.absencesRequest);
    await result.fold(
      (failure) async {
        emit(AttendanceErrorState(message: failure.message ?? "Gagal Login"));
      },
      (response) async {
        emit(AttendanceLoadedState(attendanceResponse: response));
      },
    );
  }
}
