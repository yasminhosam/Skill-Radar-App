import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/core/di/service_locator.dart';
import 'package:flutter_projects/core/enums/experience_level.dart';
import 'package:flutter_projects/core/routes/app_routes.dart';
import 'package:flutter_projects/core/theme/app_colors.dart';
import 'package:flutter_projects/features/profile/presentation/ui/widgets/experience_level_view.dart';
import 'package:flutter_projects/features/profile/presentation/ui/widgets/profile_bottom_nav.dart';
import 'package:flutter_projects/features/profile/presentation/ui/widgets/profile_top_bar.dart';
import 'package:flutter_projects/features/profile/presentation/ui/widgets/skills_view.dart';
import 'package:flutter_projects/features/profile/presentation/ui/widgets/target_role_view.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileSetupScreen extends StatelessWidget {
  final String uid;
  const ProfileSetupScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>(),
      child: _ProfileSetupView(uid: uid),
    );
  }
}

class _ProfileSetupView extends StatefulWidget {
  final String uid;
  const _ProfileSetupView({required this.uid});

  @override
  State<_ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<_ProfileSetupView> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  static const int _totalSteps = 3;

  // Step 1 — Target Role
  final TextEditingController _roleController = TextEditingController();
  final FocusNode _roleFocusNode = FocusNode();

  // Step 2 — Experience Level
  ExperienceLevel? _selectedLevel;

  // Step 3 — Skills
  final Set<String> _selectedSkills = {};

  // ── Validation helpers ────────────────────────────────────────────────────

  bool get _step1Valid => _roleController.text.trim().isNotEmpty;
  bool get _step2Valid => _selectedLevel != null;
  bool get _step3Valid => _selectedSkills.isNotEmpty;

  bool get _canGoNext {
    if (_currentStep == 0) return _step1Valid;
    if (_currentStep == 1) return _step2Valid;
    return true;
  }

  // ── Navigation ────────────────────────────────────────────────────────────

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _roleFocusNode.unfocus();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    } else {
      _submit();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    }
  }

  void _submit() {
    if (!_step3Valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select at least one skill.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    context.read<ProfileCubit>().saveProfile(
      uid: widget.uid,
      targetRole: _roleController.text.trim(),
      skills: _selectedSkills.toList(),
      experienceLevel: _selectedLevel!,
    );
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _roleController.addListener(_onRoleChanged);
  }

  void _onRoleChanged() => setState(() {});

  @override
  void dispose() {
    _roleController.removeListener(_onRoleChanged);
    _pageController.dispose();
    _roleController.dispose();
    _roleFocusNode.dispose();
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSaveSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeScreen,
            (_) => false,
          );
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(state.message)),
                ],
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              ProfileTopBar(currentStep: _currentStep, totalSteps: _totalSteps),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TargetRoleView(
                      roleController: _roleController,
                      roleFocusNode: _roleFocusNode,
                    ),
                    ExperienceLevelView(
                      selectedLevel: _selectedLevel,
                      onLevelSelected: (level) {
                        setState(() => _selectedLevel = level);
                      },
                    ),
                    SkillsView(
                      selectedSkills: _selectedSkills,
                      onSkillToggled: (skill) {
                        setState(() {
                          if (_selectedSkills.contains(skill)) {
                            _selectedSkills.remove(skill);
                          } else {
                            _selectedSkills.add(skill);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              ProfileBottomNav(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
                canGoNext: _canGoNext,
                onPrevStep: _prevStep,
                onNextStep: _nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
