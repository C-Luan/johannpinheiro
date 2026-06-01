import 'package:flutter/foundation.dart';
import '../../data/models/work.dart';
import '../../data/repositories/static_data.dart';

class PortfolioProvider extends ChangeNotifier {
  WorkCategory? _activeFilter;
  WorkCategory? get activeFilter => _activeFilter;

  List<Work> get filteredWorks => _activeFilter == null
      ? StaticData.works
      : StaticData.works.where((w) => w.category == _activeFilter).toList();

  void setFilter(WorkCategory? category) {
    _activeFilter = category;
    notifyListeners();
  }
}
