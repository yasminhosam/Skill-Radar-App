import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';


class ProfileTopBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProfileTopBar({super.key, required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    final stepTitles = ['Your Role', 'Experience', 'Skills'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.radar_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              RichText(
                text: const TextSpan(
                  text: 'Skill',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Radar',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Step ${currentStep + 1} of $totalSteps',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / totalSteps,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (i) {
              final active = i == currentStep;
              final done = i < currentStep;
              return Text(
                stepTitles[i],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                  color: done
                      ? AppColors.primary
                      : active
                      ? AppColors.textPrimary
                      : AppColors.textMuted,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}