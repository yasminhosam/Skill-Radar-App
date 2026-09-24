import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class SkillsView extends StatefulWidget {
  /// Same mutable set owned by the parent. Custom skills live in it too,
  /// so the parent's toggle logic and validation keep working unchanged.
  final Set<String> selectedSkills;
  final ValueChanged<String> onSkillToggled;

  const SkillsView({
    super.key,
    required this.selectedSkills,
    required this.onSkillToggled,
  });

  static const Map<String, List<String>> skillsByCategory = {
    'Languages': [
      'Python', 'JavaScript', 'TypeScript', 'Dart', 'Java', 'Kotlin',
      'Swift', 'Go', 'C#', 'PHP', 'Ruby', 'Rust', 'SQL', 'R', 'C++',
    ],
    'Frontend': [
      'React', 'Vue.js', 'Angular', 'Next.js', 'HTML/CSS',
      'Tailwind CSS', 'GraphQL', 'Redux',
    ],
    'Mobile': [
      'Flutter', 'React Native', 'SwiftUI', 'Jetpack Compose',
      'Android SDK', 'iOS SDK',
    ],
    'Backend': [
      'Node.js', 'Django', 'FastAPI', 'Spring Boot',
      'Laravel', 'Express.js', 'NestJS', 'ASP.NET',
    ],
    'DevOps & Cloud': [
      'Docker', 'Kubernetes', 'AWS', 'GCP', 'Azure',
      'CI/CD', 'Terraform', 'Linux',
    ],
    'Databases': [
      'PostgreSQL', 'MySQL', 'MongoDB', 'Redis', 'Firebase', 'Supabase',
    ],
    'AI / ML': [
      'TensorFlow', 'PyTorch', 'Scikit-learn',
      'Pandas', 'LangChain', 'OpenAI API',
    ],
  };

  /// lowercase -> canonical catalog spelling, used to avoid duplicates such as
  /// "react native" vs "React Native".
  static final Map<String, String> _catalogByLowerCase = {
    for (final skill in skillsByCategory.values.expand((s) => s))
      skill.toLowerCase(): skill,
  };

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView> {
  static const int _maxSkillLength = 40;

  final TextEditingController _customController = TextEditingController();
  final FocusNode _customFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Rebuild so the add button enables/disables while typing.
    _customController.addListener(_onTextChanged);
  }

  void _onTextChanged() => setState(() {});

  @override
  void dispose() {
    _customController.removeListener(_onTextChanged);
    _customController.dispose();
    _customFocusNode.dispose();
    super.dispose();
  }

  bool get _hasText => _customController.text.trim().isNotEmpty;

  /// Adds one or more skills typed by the user (comma-separated).
  void _addCustomSkills() {
    for (final raw in _customController.text.split(',')) {
      // Trim and collapse repeated whitespace.
      final cleaned = raw.trim().replaceAll(RegExp(r'\s+'), ' ');
      if (cleaned.isEmpty) continue;

      // Reuse the catalog spelling when the skill already exists there.
      final canonical =
          SkillsView._catalogByLowerCase[cleaned.toLowerCase()] ?? cleaned;

      final alreadySelected = widget.selectedSkills
          .any((s) => s.toLowerCase() == canonical.toLowerCase());
      if (!alreadySelected) {
        // The parent toggles: since it is not selected yet, this adds it.
        widget.onSkillToggled(canonical);
      }
    }
    _customController.clear();
    _customFocusNode.requestFocus();
  }

  /// Selected skills that are not part of the catalog.
  List<String> get _customSkills => widget.selectedSkills
      .where((s) => !SkillsView._catalogByLowerCase.containsKey(s.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    final selectedSkills = widget.selectedSkills;
    final customSkills = _customSkills;

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your key skills',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Pick from the list or add your own.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: selectedSkills.isEmpty
                      ? AppColors.background
                      : AppColors.primary.withAlpha(15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selectedSkills.isEmpty
                        ? AppColors.border
                        : AppColors.primary,
                  ),
                ),
                child: Text(
                  '${selectedSkills.length} selected',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: selectedSkills.isEmpty
                        ? AppColors.textMuted
                        : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Free-text input
          _buildCustomInput(),
          if (customSkills.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: customSkills
                  .map((skill) => _buildChip(skill, removable: true))
                  .toList(),
            ),
          ],
          const SizedBox(height: 24),

          // Catalog
          ...SkillsView.skillsByCategory.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                  entry.value.map((skill) => _buildChip(skill)).toList(),
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCustomInput() {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: width),
        );

    return TextField(
      controller: _customController,
      focusNode: _customFocusNode,
      maxLength: _maxSkillLength * 4, // room for several comma-separated skills
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.words,
      onSubmitted: (_) {
        if (_hasText) _addCustomSkills();
      },
      style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Not listed? Type a skill, e.g. Unity, Kafka',
        helperText: 'Separate multiple skills with commas.',
        counterText: '',
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.textMuted),
        prefixIcon: const Icon(
          Icons.edit_outlined,
          color: AppColors.textSecondary,
          size: 20,
        ),
        suffixIcon: IconButton(
          tooltip: 'Add skill',
          icon: Icon(
            Icons.add_circle_rounded,
            color: _hasText ? AppColors.primary : AppColors.textMuted,
          ),
          onPressed: _hasText ? _addCustomSkills : null,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: border(AppColors.border),
        enabledBorder: border(AppColors.border),
        focusedBorder: border(AppColors.borderFocused, 1.8),
      ),
    );
  }

  Widget _buildChip(String skill, {bool removable = false}) {
    final isSelected = widget.selectedSkills.contains(skill);
    return GestureDetector(
      onTap: () => widget.onSkillToggled(skill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.only(
          left: 14,
          right: removable ? 8 : 14,
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              skill,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
            if (removable) ...[
              const SizedBox(width: 6),
              const Icon(Icons.close_rounded, size: 16, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}