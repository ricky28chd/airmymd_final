import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/app/pages/chat_list/chat_list_binding.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/add_doctor.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/add_doctor_binding.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/visit/visit_binding.dart';
import 'package:airmymd/app/pages/new_screen/add_visit/add_visit_binding.dart';
import 'package:airmymd/app/pages/new_screen/add_visit/add_visit_screen.dart';
import 'package:airmymd/app/pages/new_screen/healtdashboard/view.dart';
import '../pages/new_screen/add_doctor/primary_care/primary_care_binding.dart';
import '../pages/new_screen/add_doctor/primary_care/primary_care_screen.dart';
import '../pages/new_screen/add_doctor/visit/visit_view.dart';
import '../pages/new_screen/healtdashboard/binding.dart';
part 'app_routes.dart';

class AppPages {
  static var fadeTransitionDuration = const Duration(milliseconds: 350);
  static var cupertinoTransitionDuration = const Duration(milliseconds: 400);
  static var cupertinoTransition = Transition.cupertino;
  static const initial = Routes.splash;

  static final pages = [
    GetPage<SplashScreen>(
        name: Routes.splash,
        page: SplashScreen.new,
        transition: Transition.fadeIn,
        binding: SplashBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<WalkThroughScreen>(
        name: Routes.walkthrough,
        page: WalkThroughScreen.new,
        transition: Transition.fade,
        binding: WalkThroughBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<LoginScreen>(
        name: Routes.login,
        page: LoginScreen.new,
        transition: Transition.fadeIn,
        binding: LoginBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<OtpScreen>(
        name: Routes.otp,
        page: OtpScreen.new,
        transition: Transition.fadeIn,
        binding: OtpBindings(),
        transitionDuration: fadeTransitionDuration),
    GetPage<RegisterScreen>(
        name: Routes.register,
        page: RegisterScreen.new,
        transition: Transition.fadeIn,
        binding: RegisterBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<SetLocationScreen>(
        name: Routes.setLocation,
        page: SetLocationScreen.new,
        transition: Transition.fadeIn,
        binding: SetLocationBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<BuildProfileScreen>(
        name: Routes.buildProfile,
        page: BuildProfileScreen.new,
        transition: cupertinoTransition,
        binding: BuildProfileBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<AllergiesScreen>(
        name: Routes.allergies,
        page: AllergiesScreen.new,
        transition: cupertinoTransition,
        binding: AllergiesBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<MedicalHistoryScreen>(
        name: Routes.medicalHistory,
        page: MedicalHistoryScreen.new,
        transition: cupertinoTransition,
        binding: MedicalHistoryBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<MedicationScreen>(
        name: Routes.medication,
        page: MedicationScreen.new,
        transition: cupertinoTransition,
        binding: MedicationBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<SurgeriesScreen>(
        name: Routes.surgeries,
        page: SurgeriesScreen.new,
        transition: cupertinoTransition,
        binding: SurgeriesBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<SexualHealthScreen>(
        name: Routes.sexualHealth,
        page: SexualHealthScreen.new,
        transition: cupertinoTransition,
        binding: SexualHealthBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<HealthHabitsScreen>(
        name: Routes.healthHabits,
        page: HealthHabitsScreen.new,
        transition: cupertinoTransition,
        binding: HealthHabitBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<GeneralHealthScreen>(
        name: Routes.generalHealth,
        page: GeneralHealthScreen.new,
        transition: cupertinoTransition,
        binding: GeneralHealthBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<TobaccoScreen>(
        name: Routes.tobacco,
        page: TobaccoScreen.new,
        transition: cupertinoTransition,
        binding: TobaccoBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<AlcoholScreen>(
        name: Routes.alcohol,
        page: AlcoholScreen.new,
        transition: cupertinoTransition,
        binding: AlcoholBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<DrugsScreen>(
        name: Routes.drugs,
        page: DrugsScreen.new,
        transition: cupertinoTransition,
        binding: DrugsBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<AddInsuranceScreen>(
        name: Routes.addInsurance,
        page: AddInsuranceScreen.new,
        transition: cupertinoTransition,
        binding: AddInsuranceBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<FindDoctorScreen>(
        name: Routes.home,
        page: FindDoctorScreen.new,
        transition: Transition.noTransition,
        binding: FindDoctorBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<DoctorProfileScreen>(
        name: Routes.doctorProfile,
        page: DoctorProfileScreen.new,
        transition: cupertinoTransition,
        binding: DoctorProfileBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<GoogleMapScreen>(
        name: Routes.googleMap,
        page: GoogleMapScreen.new,
        transition: cupertinoTransition,
        binding: GoogleMapBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<BookAppointmentScreen>(
        name: Routes.bookAppointment,
        page: BookAppointmentScreen.new,
        transition: cupertinoTransition,
        binding: BookAppointmentBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<PaymentScreen>(
        name: Routes.payment,
        page: PaymentScreen.new,
        transition: cupertinoTransition,
        binding: PaymentBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<AppointmentListScreen>(
        name: Routes.appointmentList,
        page: AppointmentListScreen.new,
        transition: Transition.noTransition,
        binding: AppointmentListBindings(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<UserSettingsScreen>(
        name: Routes.userSetting,
        page: UserSettingsScreen.new,
        transition: Transition.noTransition,
        binding: UserSettingBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<InsuranceListScreen>(
        name: Routes.insuranceList,
        page: InsuranceListScreen.new,
        transition: Transition.noTransition,
        binding: InsuranceListBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<ProfileSettingScreen>(
        name: Routes.profileSetting,
        page: ProfileSettingScreen.new,
        transition: Transition.noTransition,
        binding: ProfileSettingBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<AllProfileScreen>(
        name: Routes.allProfile,
        page: AllProfileScreen.new,
        transition: Transition.noTransition,
        binding: AllProfileBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<ProfileSettingScreen>(
        name: Routes.profileSetting,
        page: ProfileSettingScreen.new,
        transition: Transition.noTransition,
        binding: ProfileSettingBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<PaymentCardListScreen>(
        name: Routes.paymentCardList,
        page: PaymentCardListScreen.new,
        transition: Transition.noTransition,
        binding: PaymentCardListBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<AddNewCardScreen>(
        name: Routes.addNewCardScreen,
        page: AddNewCardScreen.new,
        transition: Transition.noTransition,
        binding: AddNewCardBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<ChatScreen>(
        name: Routes.chatScreen,
        page: ChatScreen.new,
        transition: Transition.noTransition,
        binding: ChatBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<ChatListScreen>(
        name: Routes.chatList,
        page: ChatListScreen.new,
        transition: Transition.noTransition,
        binding: ChatListBinding(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<NotificationListScreen>(
        name: Routes.notificationList,
        page: NotificationListScreen.new,
        transition: Transition.noTransition,
        binding: NotificationListBinging(),
        transitionDuration: cupertinoTransitionDuration),
    GetPage<FindDoctorLocationSearchDialog>(
      name: Routes.searchDialogue,
      page: FindDoctorLocationSearchDialog.new,
      transition: Transition.noTransition,
      binding: FindDoctorBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<ReviewListScreen>(
      name: Routes.reviewsList,
      page: ReviewListScreen.new,
      transition: Transition.noTransition,
      binding: ReviewsListBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<SupportScreen>(
      name: Routes.support,
      page: SupportScreen.new,
      transition: Transition.noTransition,
      binding: SupportBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<NotesScreen>(
      name: Routes.notes,
      page: NotesScreen.new,
      transition: Transition.noTransition,
      binding: NotesBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<NotesScreen>(
      name: Routes.addDoctor,
      page: AddDoctorScreen.new,
      transition: Transition.noTransition,
      binding: AddDoctorBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<PrimaryCareScreen>(
      name: Routes.primaryCare,
      page: PrimaryCareScreen.new,
      transition: Transition.noTransition,
      binding: PrimaryCareBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<AddVisitScreen>(
      name: Routes.addVisit,
      page: AddVisitScreen.new,
      transition: Transition.noTransition,
      binding: AddVisitBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<VisitView>(
      name: Routes.vist,
      page: VisitView.new,
      transition: Transition.noTransition,
      binding: VisitBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
    GetPage<HealthDashboard>(
      name: Routes.healthDashboard,
      page: HealthDashboard.new,
      transition: Transition.noTransition,
      binding: HealthBinding(),
      transitionDuration: cupertinoTransitionDuration,
    ),
  ];
}
