class Pagination {
  int initialPage = 1;
  int perPage = 4;
  set pageIndex(int newIndex) {
    initialPage = newIndex;
  }

  get currentPage => initialPage;
}
