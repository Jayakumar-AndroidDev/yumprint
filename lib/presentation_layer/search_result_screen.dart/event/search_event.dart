class SearchEvent {
  String searchMeal;
  SearchEvent({required this.searchMeal});
}

class OnSearchSubmitClick extends SearchEvent{
  OnSearchSubmitClick({required searchMeal}):super(searchMeal: searchMeal);
}