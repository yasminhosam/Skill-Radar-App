import 'package:flutter/material.dart';
import '../../../../../core/enums/experience_level.dart';
import '../../../../../core/theme/app_colors.dart';

class ExperienceLevelView extends StatelessWidget {
  final ExperienceLevel? selectedLevel;
  final ValueChanged<ExperienceLevel> onLevelSelected;

  const ExperienceLevelView({
    super.key,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    const levelIcons = <ExperienceLevel, IconData>{
      ExperienceLevel.entryLevel: Icons.school_outlined,
      ExperienceLevel.midLevel: Icons.trending_up_rounded,
      ExperienceLevel.senior: Icons.star_outline_rounded,
      ExperienceLevel.manager: Icons.people_outline_rounded,
      ExperienceLevel.director: Icons.business_center_outlined,
      ExperienceLevel.executive: Icons.military_tech_outlined,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your experience level',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'This helps us calibrate job matches and skill benchmarks to where you are right now.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ...ExperienceLevel.values.map((level) {
            final isSelected = selectedLevel == level;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onLevelSelected(level),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withAlpha(12)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 1.8 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(30),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withAlpha(20)
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          levelIcons[level]!,
                          size: 22,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              level.label,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              level.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
