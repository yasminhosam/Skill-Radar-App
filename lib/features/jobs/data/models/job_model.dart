class Job {
  final String guid;
  final String? title;
  final String? companyName;
  final String? companyLogo;
  final String? employmentType;
  final List<String> seniority;
  final List<String> categories;
  final List<String> parentCategories;
  final String? description;
  final String? applicationLink;


  Job({
    required this.guid,
    this.title,
    this.companyName,
    this.companyLogo,
    this.employmentType,
    this.seniority = const [],
    this.categories = const [],
    this.parentCategories = const [],
    this.description,
    this.applicationLink,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    final guid =json['guid'] as String?;
    if (guid == null || guid.isEmpty) {
      throw FormatException('Job JSON is missing a required guid: $json');
    }
    return Job(
      guid: guid,
      title: json['title'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      employmentType: json['employmentType'],
      seniority: (json['seniority'] as List?)?.cast<String>() ?? const [],
      categories: (json['categories'] as List?)?.cast<String>() ?? const [],
      parentCategories:
      (json['parentCategories'] as List?)?.cast<String>() ?? const [],
      description: json['description'],
      applicationLink: json['applicationLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'title': title,
      'companyName': companyName,
      'companyLogo': companyLogo,
      'employmentType': employmentType,
      'seniority': seniority,
      'categories': categories,
      'parentCategories': parentCategories,
      'description': description,
      'applicationLink': applicationLink,
    };
  }
}