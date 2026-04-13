/// Generic model for dropdown items, selection lists, radio groups, etc.
class ItemSimpleModel<T> {
  final String title;
  final String? description;
  final String? imageResource;
  final bool isSelected;
  final bool? isEnabled;
  final T? value;
  final List<ItemSimpleModel<T>>? items;
  final int? itemIndex;

  const ItemSimpleModel({
    required this.title,
    this.description,
    this.imageResource,
    this.isSelected = false,
    this.isEnabled,
    this.value,
    this.items = const [],
    this.itemIndex,
  });

  ItemSimpleModel<T> copyWith({
    String? title,
    String? description,
    String? imageResource,
    bool? isSelected,
    bool? isEnabled,
    T? value,
    List<ItemSimpleModel<T>>? items,
    int? itemIndex,
  }) {
    return ItemSimpleModel<T>(
      title: title ?? this.title,
      description: description ?? this.description,
      imageResource: imageResource ?? this.imageResource,
      isSelected: isSelected ?? this.isSelected,
      isEnabled: isEnabled ?? this.isEnabled,
      value: value ?? this.value,
      items: items ?? this.items,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }
}
