import 'package:flutter/foundation.dart';
import '../../data/models/work.dart';
import '../../data/repositories/work_repository.dart';

class PortfolioProvider extends ChangeNotifier {
  WorkCategory? _activeFilter;
  List<Work> _works = [];
  bool _loading = true;

  PortfolioProvider() {
    _init();
  }

  Future<void> _init() async {
    _works = await WorkRepository.loadWorks();
    _loading = false;
    notifyListeners();
  }

  WorkCategory? get activeFilter => _activeFilter;
  bool get loading => _loading;

  List<Work> get filteredWorks => _activeFilter == null
      ? _works
      : _works.where((w) => w.category == _activeFilter).toList();

  void setFilter(WorkCategory? category) {
    _activeFilter = category;
    notifyListeners();
  }
}
