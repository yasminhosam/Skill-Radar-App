class Job {
  String? title;
  String? companyName;
  String? companyLogo;
  String? employmentType;
  List<String>? seniority;
  List<String>? categories;
  List<String>? parentCategories;
  String? description;
  String? applicationLink;
  String? guid;

  Job(
      {this.title,
        this.companyName,
        this.companyLogo,
        this.employmentType,
        this.seniority,
        this.categories,
        this.parentCategories,
        this.description,
        this.applicationLink,
        this.guid});

  Job.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    companyName = json['companyName'];
    companyLogo = json['companyLogo'];
    employmentType = json['employmentType'];
    seniority = json['seniority'].cast<String>()??[];
    categories = json['categories'].cast<String>()??[];
    parentCategories = json['parentCategories'].cast<String>()??[];
    description = json['description'];
    applicationLink = json['applicationLink'];
    guid = json['guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['companyName'] = this.companyName;
    data['companyLogo'] = this.companyLogo;
    data['employmentType'] = this.employmentType;
    data['seniority'] = this.seniority;
    data['categories'] = this.categories;
    data['parentCategories'] = this.parentCategories;
    data['description'] = this.description;
    data['applicationLink'] = this.applicationLink;
    data['guid'] = this.guid;
    return data;
  }
}