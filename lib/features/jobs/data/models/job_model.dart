class Job {
  final String title;
  final String companyName;
  final String? companyLogo;
  final String employmentType;
  final List<String> seniority;
  final List<String> categories;
  final List<String> parentCategories;
  final String description;
  final String applicationLink;
  final String guid;

  const Job({
    required this.title,
    required this.companyName,
    this.companyLogo,
    required this.employmentType,
    required this.seniority,
    required this.categories,
    required this.parentCategories,
    required this.description,
    required this.applicationLink,
    required this.guid,
  });


  static List<String> _stringList(dynamic value) =>
      (value as List?)?.map((e) => e.toString()).toList() ?? const [];

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      title: json['title'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      companyLogo: json['companyLogo'] as String?,
      employmentType: json['employmentType'] as String? ?? '',
      seniority: _stringList(json['seniority']),
      categories: _stringList(json['categories']),
      parentCategories: _stringList(json['parentCategories']),
      description: json['description'] as String? ?? '',
      applicationLink: json['applicationLink'] as String? ?? '',
      guid: json['guid'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'companyName': companyName,
    'companyLogo': companyLogo,
    'employmentType': employmentType,
    'seniority': seniority,
    'categories': categories,
    'parentCategories': parentCategories,
    'description': description,
    'applicationLink': applicationLink,
    'guid': guid,
  };
}