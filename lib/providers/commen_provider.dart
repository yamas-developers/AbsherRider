import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommenProvider<T> with ChangeNotifier {
  List<T> c_list = [];
  RefreshController c_refreshController = RefreshController();
  int c_limit = 10;
  int c_offset = 1;
  int c_total_size = 10000;
  bool c_loading = false;

  List<T> get list => c_list;

  RefreshController get refreshController => c_refreshController;

  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }

  bool get loading {
    return c_loading;
  }

  set list(List<T> list) {
    c_list.clear();
    c_list.addAll(list);
    notifyListeners();
  }

  set refreshController(RefreshController refreshController) {
    c_refreshController = refreshController;
    notifyListeners();
  }

  remove(index) {
    c_list.removeAt(index);
    notifyListeners();
  }

  c_reset(bool empty_list) {
    c_offset = 1;
    c_total_size = 1000;
    c_loading = false;
    if (empty_list) c_list.clear();
    c_refreshController.loadComplete();
    notifyListeners();
  }

  resetLoading({isMainLoading: true, isFooterLoading: true, isHeaderLoading: true}) {
    if (!isMainLoading) {
      loading = isMainLoading;
    }
    if (!isFooterLoading) {
      c_refreshController.footerMode!.value = LoadStatus.idle;
    }
    if (!isHeaderLoading) {
      c_refreshController.loadComplete();
    }
    notifyListeners();

  }

  setLoading(
      {isMainLoading: false, isFooterLoading: false, isHeaderLoading: false}) {
    if (isMainLoading) {
      loading = true;
    }
    if (isFooterLoading) {
      c_refreshController.footerMode!.value = LoadStatus.loading;
    }
    if (isHeaderLoading) {}
    notifyListeners();
  }

  setData(List<T> list, {isNoMore: false}) {
    //////empty list should be true for first call
    if (list == null) {
      resetLoading();
      return;
    }
    c_list.clear();
    c_list.addAll(list);
    c_refreshController.loadComplete();
    if (c_refreshController.footerMode != null) {
      c_refreshController.footerMode!.value = LoadStatus.idle;
    }
    if (isNoMore) {
      c_refreshController.footerMode!.value = LoadStatus.noMore;
    }
    notifyListeners();
  }

  setMoreData(List<T> mlist, {isNoMore: false}) {
    if (list != null) {
      resetLoading();
      return;
    }
    c_list.addAll(mlist);
    if (c_refreshController.footerMode != null)
      c_refreshController.footerMode!.value = LoadStatus.idle;
    if (isNoMore) {
      c_refreshController.footerMode!.value = LoadStatus.noMore;
    }
    notifyListeners();
  }
}
