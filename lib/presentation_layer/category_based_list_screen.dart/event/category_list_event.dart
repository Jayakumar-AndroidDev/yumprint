class CategoryListEvent {

}

class CategoryListLoadEvent extends CategoryListEvent{
  String selectedCategory;
  CategoryListLoadEvent({required this.selectedCategory});
}