import '../../../domain/models/health_habits_response.dart';
import '../../../domain/usecases/authcases.dart';

class HealthHabitsPresenter {
  HealthHabitsPresenter(this.authCases);
  final AuthCases authCases;

  Future<HealthHabitsResponse> healthHabitUserModel({
    required String healthHabit,
  }) async =>
      authCases.healthHabitUserModel(
        healthHabit: healthHabit,
      );
}
