import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoadMoreMixin on GetxController {
  int page = 1;
  RxBool isLoading = true.obs;
  bool isLoadMore = true;
  bool isLoadData = true;
  final scrollController = ScrollController();

  /// Func [getData] get list data.
  Future<void> getData();

  /// Func [updateData] update ui list.
  void updateData();

  void loadMoreData() {
    scrollController.addListener(() async {
      bool canLoadMore = (scrollController.position.extentAfter == 0);
      if (canLoadMore && isLoadMore && isLoadData) {
        page++;
        isLoadData = false;
        updateData();
        // await getData();
        isLoadData = true;
      }
    });
  }



  void refreshData() {
    page = 1;
    isLoading.value = true;
    isLoadMore = true;
    isLoadData = true;
    updateData();
    getData();
  }
}

