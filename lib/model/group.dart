import 'package:memory_helper/model/subject.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String name;
  final List<Subject> subjects;

  const Group({
    required this.name,
    required this.subjects,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Subject get wholeSubject {
    return subjects.fold(
      const Subject(name: '전체', problems: []),
      (prev, elem) => prev.merge(elem),
    );
  }

  Group merge(Group group) {
    final Map<String, Subject> subjectMap = {};
    for (final subject in subjects + group.subjects) {
      if (subjectMap[subject.name] != null) {
        subjectMap[subject.name] = subjectMap[subject.name]!.merge(subject);
      } else {
        subjectMap[subject.name] = subject;
      }
    }
    return Group(name: name, subjects: subjectMap.values.toList());
  }
}
