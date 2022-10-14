import 'package:flutter/material.dart';
import 'package:search_photo/api/collection/searchApis.dart';

class MainProvider extends ChangeNotifier {
  bool _isShimmerLoading = false, _atBottom = false;
  int _pageIndex = 0;
  String _currSearchQuery = '';
  List<dynamic> _imagesCollection = [];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  ScrollController get scrollController => _scrollController;

  List<dynamic> get imagesCollection => _imagesCollection;

  TextEditingController get searchController => _searchController;

  bool get isShimmerLoading => _isShimmerLoading;

  updateShimmerLoadingStatus(bool update) {
    _isShimmerLoading = update;
    notifyListeners();
  }

  updateSearchQuery(String newQuery) {
    if (_currSearchQuery == newQuery) return;

    _currSearchQuery = newQuery;
    notifyListeners();
  }

  onSearch({bool considerCurrSearchQuery = false}) async {
    final _searchQuery =
        considerCurrSearchQuery ? _currSearchQuery : _searchController.text;
    if (_searchQuery.isEmpty || _searchQuery.length < 3) return;

    _searchQuery == _currSearchQuery ? updatePageIndex(true) : resetPageIndex();

    if (_pageIndex == 1) updateShimmerLoadingStatus(true);

    final _response =
        await SearchApis.onImageSearch(_searchQuery, pageIndex: _pageIndex);

    if (_pageIndex == 1) updateShimmerLoadingStatus(false);

    if (_response['error'] != null) return;

    dataInclusion(_response['photos'] ?? [], _searchQuery);
  }

  dataInclusion(List<dynamic> remoteImages, String _searchQuery) {
    if (_currSearchQuery != _searchQuery) {
      updateSearchQuery(_searchQuery);
      clearImageContainer();
    }

    if (remoteImages.isEmpty && _pageIndex == 1) {
      _imagesCollection = [];
      notifyListeners();
      return;
    }

    _imagesCollection = [..._imagesCollection, ...remoteImages];
    notifyListeners();
    updateAtBottomStatus(false);
  }

  updatePageIndex(bool increase) {
    if (!increase && _pageIndex > 0) {
      _pageIndex -= 1;
    }

    if (increase) {
      _pageIndex += 1;
    }

    notifyListeners();
  }

  resetPageIndex() {
    _pageIndex = 1;
    notifyListeners();
  }

  clearImageContainer() {
    _imagesCollection.clear();
    notifyListeners();
  }

  scrollInitialize() {
    _scrollController.addListener(listener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    super.dispose();
  }

  void listener() {
    if (!_atBottom &&
        _scrollController.position.pixels.toInt() >=
            (_scrollController.position.maxScrollExtent.toInt()) - 200) {
      updateAtBottomStatus(true);
      onSearch(considerCurrSearchQuery: true);
    }

    if (_atBottom &&
        _scrollController.position.pixels.toInt() <
            (_scrollController.position.maxScrollExtent.toInt()) - 200) {
      updateAtBottomStatus(false);
    }
  }

  updateAtBottomStatus(bool updated) {
    _atBottom = updated;
    notifyListeners();
  }
}
