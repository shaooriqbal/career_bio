import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:flutter/cupertino.dart';

class PaginatedListViewController<T, U> extends ChangeNotifier {
  PaginatedListViewController({
    required this.dataFunction,
    required this.limit,
    required this.parseData,
  }) {
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    _scrollController.dispose();
    super.dispose();
  }

  final Future<T> Function(int pageNumber, int limit) dataFunction;
  final List<U> Function(T) parseData;
  final int limit;

  void _loadMore() async {
    if (!_scrollController.hasClients) {
      return;
    }
    if (!_scrollController.position.atEdge) {
      return;
    }
    if (_isMainLoading || _isSubLoading) {
      return;
    }
    if (!_hasMoreData) {
      return;
    }
    _pageNumber++;
    _fetchData();
  }

  final _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  var _isMainLoading = true;
  var _isSubLoading = false;
  var _pageNumber = 0;
  T? _object;
  final _data = <U>[];
  var _hasMoreData = true;
  DioException? _error;

  bool get isMainLoading => _isMainLoading;

  bool get isSubLoading => _isSubLoading;

  List<U> get data => _data;

  DioException? get error => _error;

  Future<void> _fetchData() async {
    if (_pageNumber == 0) {
      _isMainLoading = true;
    } else {
      _isSubLoading = true;
    }
    notifyListeners();
    try {
      _object = await dataFunction(_pageNumber, limit);
      final result = parseData(_object as T);
      if (result.length < limit) {
        _hasMoreData = false;
      }
      if (_pageNumber == 0) {
        _data.clear();
      }
      _data.addAll(result);
      _error = null;
    } catch (e) {
      _error = DioException.withDioError(e);
    }
    _isSubLoading = false;
    _isMainLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    _pageNumber = 0;
    await _fetchData();
  }
}
