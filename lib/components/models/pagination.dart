class Pagination {
  int initialPage = 1;
  int perPage = 10;
  int totalItem = 0;
  int totalPage = 0;
  set pageIndex(int newIndex) {
    initialPage = newIndex;
  }
}
