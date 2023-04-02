import 'package:localstorage/localstorage.dart';
import 'package:memory_helper/model/result.dart';
import 'group.dart';
import 'history.dart';

class Manager {
  static Manager? _instance;
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

  static Future<void> load() async {
    print('asdasdasd');
    final ls = LocalStorage('data.json');
    final r = await ls.ready;
    final groups = ls.getItem('groups');
    final history = ls.getItem('history');
    print('ready $r');
    print('groups = $groups');
    print('history = $history');
    print('key = ${ls.getItem('key')}');
    if (groups == null || history == null) {
      _instance = Manager._(groups: [], history: History.empty());
      return;
    }
    _instance = Manager._(groups: groups, history: history);
  }

  void save() async {
    final ls = LocalStorage('data.json');
    await ls.ready;
    await Future.wait([
      ls.setItem('groups', groups),
      ls.setItem('history', history),
      ls.setItem('key', 'value'),
    ]);
    print('saved $groups and $history');
  }

  void addGroup(Group group) => groups.add(group);
  void removeGroup(String groupName) =>
      groups.removeWhere((group) => group.name == groupName);
  void addHistory(Result result) {
    history.history = [...history.history, result];
  }
}
