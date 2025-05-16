class Portfolio {
final int? id;
final String name;
final String college;
final List<String> skills;
final String projectTitle;
final String projectDescription;

Portfolio({
this.id,
required this.name,
required this.college,
required this.skills,
required this.projectTitle,
required this.projectDescription,
});

Map<String, dynamic> toMap() {
return {
'id': id,
'name': name,
'college': college,
'skills': skills.join(','), // Save as comma-separated string
'projectTitle': projectTitle,
'projectDescription': projectDescription,
};
}

factory Portfolio.fromMap(Map<String, dynamic> map) {
return Portfolio(
id: map['id'],
name: map['name'],
college: map['college'],
skills: (map['skills'] as String).split(','),
projectTitle: map['projectTitle'],
projectDescription: map['projectDescription'],
);
}
}