import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';
import 'package:memory_helper/model/result.dart';
import 'package:memory_helper/model/subject.dart';
import 'group.dart';
import 'history.dart';

class Manager {
  static Manager? _instance;
  static Logger logger = Logger();
  final List<Group> groups;
  final History history;

  const Manager._({required this.groups, required this.history});

  factory Manager() {
    return _instance ?? Manager._(groups: [], history: History.empty());
  }

  Group get wholeGroup {
    Group ret = const Group(name: '전체', subjects: []);
    for (final group in groups) {
      ret = ret.merge(group);
    }
    return ret;
  }

  Group findGroupByName(String groupName) {
    return groups.firstWhere((element) => element.name == groupName);
  }

  static Future<Manager> load() async {
    final ls = LocalStorage('data.json');
    await ls.ready;
    logger.i('load local storage: $ls');
    final groups = ls.getItem('groups');
    final history = ls.getItem('history');
    if (groups == null || history == null) {
      logger.i('returns initial manager');
      _instance = Manager._(groups: [], history: History.empty());
      return _instance!;
    }
    final List<Group> parseGroup = groups.map<Group>((json) {
      final group = Group.fromJson(json);
      return group;
    }).toList();
    _instance = Manager._(
      groups: parseGroup,
      history: History.fromJson(history),
    );
    return _instance!;
  }

  Future<void> save() async {
    final ls = LocalStorage('data.json');
    await ls.ready;
    await Future.wait([
      ls.setItem('groups', groups),
      ls.setItem('history', history),
    ]);
    logger.i('saved data');
  }

  void addGroup(Group group) => groups.add(group);
  void removeGroup(String groupName) =>
      groups.removeWhere((group) => group.name == groupName);
  void addHistory(Result result) {
    history.history = [...history.history, result];
  }
}
