import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:flutter/cupertino.dart';

class CustomListViewController<T> extends ChangeNotifier {
  CustomListViewController({
    this.dataFunction,
    this.onDataFetched,
    this.listDataFunction,
    this.paginatedFunction,
    this.limit = 20,
  }) : assert(
            dataFunction == null ||
                listDataFunction == null ||
                paginatedFunction == null,
            'Cannot pass both functions at same time') {
    isList = listDataFunction != null || paginatedFunction != null;
    if (paginatedFunction != null) {
      _scrollController.addListener(_loadMore);
    }
    _fetchData();
  }

  late bool isList;
  final Future<T> Function()? dataFunction;
  final Future<List<T>> Function()? listDataFunction;
  final Future<List<T>> Function(int page, int limit)? paginatedFunction;
  final VoidCallback? onDataFetched;
  final int limit;

  @override
  void dispose() {
    if (paginatedFunction != null) {
      _scrollController.removeListener(_loadMore);
      _scrollController.dispose();
    }
    super.dispose();
  }

  final _scrollController = ScrollController();
  var _isLoading = true;
  var _isSubLoading = false;
  T? _data;
  var _listData = <T>[];
  DioException? _error;
  var _page = 1;
  var _hasMoreData = true;

  bool get isLoading => _isLoading;

  bool get isSubLoading => _isSubLoading;

  DioException? get error => _error;

  T? get data => _data;

  List<T> get listData => _listData;

  ScrollController get scrollController => _scrollController;

  Future<void> _fetchData() async {
    try {
      if (isList) {
        if (listDataFunction != null) {
          _listData = await listDataFunction?.call() ?? [];
        } else if (paginatedFunction != null) {
          if (_page > 1) {
            _isSubLoading = true;
            notifyListeners();
          } else {
            _listData.clear();
          }
          final result = await paginatedFunction!(_page, limit);
          if (result.length < limit) {
            _hasMoreData = false;
          }
          _listData.addAll(result);
          _page++;
        }
      } else {
        _data = await dataFunction?.call();
      }
      _error = null;
      onDataFetched?.call();
    } catch (e) {
      _error = DioException.withDioError(e);
    }
    _isLoading = false;
    _isSubLoading = false;
    notifyListeners();
  }

  void _loadMore() {
    if (!_scrollController.hasClients) {
      return;
    }
    if (!_scrollController.position.atEdge) {
      return;
    }
    if (_isLoading || _isSubLoading) {
      return;
    }
    if (!_hasMoreData) {
      return;
    }
    _page++;
    _fetchData();
  }

  Future<void> refresh() {
    _page = 1;
    return _fetchData();
  }
}
