enum ExperienceLevel {
  entryLevel('Entry-level', 'Just starting out or less than 2 years'),
  midLevel('Mid-level', '2–5 years of hands-on experience'),
  senior('Senior', '5+ years with deep technical expertise'),
  manager('Manager', 'Leading teams and engineering processes'),
  director('Director', 'Overseeing multiple teams or departments'),
  executive('Executive', 'C-suite or VP-level leadership');

  final String label;
  final String description;

  const ExperienceLevel(this.label, this.description);

  /// Matches the seniority strings used in the Himalayas Jobs API / JobModel.
  static ExperienceLevel? fromSeniorityString(String value) {
    for (final level in ExperienceLevel.values) {
      if (level.label.toLowerCase() == value.toLowerCase()) return level;
    }
    return null;
  }
}
