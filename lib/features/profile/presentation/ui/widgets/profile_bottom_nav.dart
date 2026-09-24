import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_state.dart';

class ProfileBottomNav extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final bool canGoNext;
  final VoidCallback onPrevStep;
  final VoidCallback onNextStep;

  const ProfileBottomNav({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.canGoNext,
    required this.onPrevStep,
    required this.onNextStep,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final isLoading = state is ProfileLoading;
        final isLastStep = currentStep == totalSteps - 1;

        return Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(color: AppColors.border),
            ),
          ),
          child: Row(
            children: [
              if (currentStep > 0)
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: isLoading ? null : onPrevStep,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (currentStep > 0) const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: _buildNextButton(isLoading, isLastStep, context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNextButton(bool isLoading, bool isLastStep, BuildContext context) {
    final enabled = canGoNext && !isLoading;
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: enabled ? AppColors.primaryGradient : null,
        color: enabled ? null : AppColors.primary.withAlpha(80),
        boxShadow: enabled
            ? [
          BoxShadow(
            color: AppColors.primary.withAlpha(70),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: enabled ? onNextStep : null,
          child: Center(
            child: isLoading
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                valueColor:
                AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLastStep ? 'Launch My Radar' : 'Continue',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  isLastStep
                      ? Icons.rocket_launch_outlined
                      : Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
