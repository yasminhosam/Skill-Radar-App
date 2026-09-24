import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class TargetRoleView extends StatelessWidget {
  final TextEditingController roleController;
  final FocusNode roleFocusNode;

  const TargetRoleView({
    super.key,
    required this.roleController,
    required this.roleFocusNode,
  });

  static const List<String> _roleSuggestions = [
    'Flutter Developer',
    'Mobile Developer',
    'iOS Developer',
    'Android Developer',
    'Frontend Engineer',
    'Backend Engineer',
    'Full Stack Engineer',
    'React Developer',
    'Vue.js Developer',
    'Angular Developer',
    'Node.js Developer',
    'Python Developer',
    'Java Developer',
    'DevOps Engineer',
    'Cloud Engineer',
    'Site Reliability Engineer',
    'Data Engineer',
    'Data Scientist',
    'Machine Learning Engineer',
    'AI Engineer',
    'QA Engineer',
    'Security Engineer',
    'Embedded Engineer',
    'Blockchain Developer',
    'Tech Lead',
    'Engineering Manager',
    'Product Manager',
    'CTO',
    'VP of Engineering',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What\'s your target role?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Type your desired job title. We\'ll use this to find the most relevant job listings and skills.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          Autocomplete<String>(
            textEditingController: roleController,
            focusNode: roleFocusNode,
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.trim().isEmpty) {
                return const Iterable<String>.empty();
              }
              final query = textEditingValue.text.trim().toLowerCase();
              return _roleSuggestions.where(
                (r) => r.toLowerCase().contains(query),
              );
            },
            onSelected: (value) {},
            fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                onFieldSubmitted: (_) => onSubmitted(),
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  labelText: 'Target Role',
                  hintText: 'e.g. Flutter Developer, Backend Engineer...',
                  prefixIcon: const Icon(
                    Icons.work_outline_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.borderFocused,
                      width: 1.8,
                    ),
                  ),
                ),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  shadowColor: Colors.black12,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: options.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: AppColors.border,
                      ),
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return InkWell(
                          onTap: () => onSelected(option),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.work_outline_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  option,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Popular roles',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: roleController,
            builder: (context, value, child) {
              final currentText = value.text.trim();
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Flutter Developer',
                  'Frontend Engineer',
                  'Backend Engineer',
                  'Full Stack Engineer',
                  'DevOps Engineer',
                  'ML Engineer',
                ].map((role) {
                  final isSelected = currentText == role;
                  return GestureDetector(
                    onTap: () => roleController.text = role,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withAlpha(15) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Text(
                        role,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
