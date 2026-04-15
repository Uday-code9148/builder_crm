import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateful_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_snackbar.dart';
import 'package:temp_architecture_app_setup/core/extensions/string_extension.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

/// Generic bottom-sheet selector for single/multi pick use-cases.
///
/// Designed to follow app theme via `context.colors`.
class SelectableItemBottomSheet<T> extends BaseStatefulWidget {
  final String title;

  /// Single selection callback. Use when [isMultipleSelection] is false.
  final ValueChanged<SelectableItem<T>>? onItemSelected;

  /// Multi selection callback. Use when [isMultipleSelection] is true.
  final ValueChanged<List<SelectableItem<T>>>? onItemsSelected;

  final List<SelectableItem<T>> selectableItems;

  /// Initially selected item for single-selection mode.
  final SelectableItem<T>? selectedItem;

  /// Initially selected items for multi-selection mode.
  final List<SelectableItem<T>>? initialSelectedItems;

  final bool isMultipleSelection;
  final bool canSearchItems;
  final String searchHintText;

  /// Optional trigger widget instead of default "Select" field.
  final Widget? child;
  final EdgeInsets childPadding;

  final bool isEnabled;
  final String? disabledSnackBarMessage;

  const SelectableItemBottomSheet({
    super.key,
    required this.title,
    required this.selectableItems,
    this.onItemSelected,
    this.onItemsSelected,
    this.selectedItem,
    this.initialSelectedItems,
    this.isMultipleSelection = false,
    this.canSearchItems = false,
    this.searchHintText = 'Search',
    this.child,
    this.childPadding = EdgeInsets.zero,
    this.isEnabled = true,
    this.disabledSnackBarMessage,
  }) : assert(
          (isMultipleSelection && onItemsSelected != null) || (!isMultipleSelection && onItemSelected != null),
          'Provide onItemSelected for single selection or onItemsSelected for multiple selection',
        );

  @override
  State<SelectableItemBottomSheet<T>> createState() => _SelectableItemBottomSheetState<T>();
}

class _SelectableItemBottomSheetState<T> extends BaseState<SelectableItemBottomSheet<T>> {
  late List<SelectableItem<T>> _items;
  late List<SelectableItem<T>> _filteredItems;
  late List<SelectableItem<T>> _selectedItems;
  late List<SelectableItem<T>> _tempSelectedItems;
  late final TextEditingController _searchController;

  @override
  void onInit() {
    _searchController = TextEditingController();
    _initializeItems();
  }

  @override
  void didUpdateWidget(covariant SelectableItemBottomSheet<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectableItems != widget.selectableItems ||
        oldWidget.selectedItem != widget.selectedItem ||
        oldWidget.initialSelectedItems != widget.initialSelectedItems) {
      _initializeItems();
    }
  }

  void _initializeItems() {
    _items = List<SelectableItem<T>>.from(widget.selectableItems);
    _filteredItems = List<SelectableItem<T>>.from(_items);
    _selectedItems = widget.isMultipleSelection
        ? (widget.initialSelectedItems != null ? List<SelectableItem<T>>.from(widget.initialSelectedItems!) : <SelectableItem<T>>[])
        : (widget.selectedItem != null ? <SelectableItem<T>>[widget.selectedItem!] : <SelectableItem<T>>[]);
    _tempSelectedItems = List<SelectableItem<T>>.from(_selectedItems);

    for (final s in _selectedItems) {
      final index = _items.indexWhere((e) => e.value == s.value);
      if (index != -1) _items[index] = _items[index].copyWith(isSelected: true);
    }
    _updateFilteredItems();
  }

  @override
  void onDispose() {
    _searchController.dispose();
  }

  void _updateFilteredItems() {
    final combined = <SelectableItem<T>>[
      ..._tempSelectedItems,
      ..._items.where((item) => !_tempSelectedItems.any((s) => s.value == item.value)),
    ];

    final Map<Object?, SelectableItem<T>> uniq = {};
    for (final i in combined) {
      uniq[i.value ?? i.title] = i;
    }
    _filteredItems = uniq.values.toList();
  }

  void _searchItems(String value) {
    setState(() {
      final q = value.trim().toLowerCase();
      if (q.length > 1) {
        _filteredItems = _items.where((e) => e.title.toLowerCase().contains(q)).toList();
      } else {
        _updateFilteredItems();
      }
    });
  }

  void _toggleItemSelection(SelectableItem<T> item) {
    setState(() {
      if (widget.isMultipleSelection) {
        final newSelected = !item.isSelected;
        final updated = item.copyWith(isSelected: newSelected);
        _items = _items.map((e) => e.value == item.value ? updated : e).toList();
        item = updated;
        if (newSelected) {
          _tempSelectedItems.add(item);
        } else {
          _tempSelectedItems.removeWhere((e) => e.value == item.value);
        }
      } else {
        _tempSelectedItems
          ..clear()
          ..add(item.copyWith(isSelected: true));
        _items = _items.map((e) => e.value == item.value ? e.copyWith(isSelected: true) : e.copyWith(isSelected: false)).toList();
      }
      _updateFilteredItems();
    });
  }

  void _showItemListModal(BuildContext context) {
    if (!widget.isEnabled || widget.selectableItems.isEmpty) {
      if (widget.disabledSnackBarMessage?.isNotNullOrEmpty() ?? false) {
        AppSnackbar.showError(context: context, message: widget.disabledSnackBarMessage!);
      }
      return;
    }

    FocusScope.of(context).unfocus();
    final colors = context.colors;

    showModalBottomSheet<void>(
      context: context,
      isDismissible: !widget.isMultipleSelection,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (ctx) {
        return GestureDetector(
          onTap: () => FocusScope.of(ctx).unfocus(),
          child: DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.5,
            maxChildSize: 0.85,
            expand: false,
            builder: (ctx, scrollController) {
              return PopScope(
                canPop: true,
                onPopInvokedWithResult: (didPop, _) {
                  if (!didPop) return;
                  setState(() {
                    _tempSelectedItems = List<SelectableItem<T>>.from(_selectedItems);
                    _updateFilteredItems();
                    _searchController.clear();
                  });
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 12, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _tempSelectedItems = List<SelectableItem<T>>.from(_selectedItems);
                                _updateFilteredItems();
                                _searchController.clear();
                              });
                              Navigator.of(ctx).pop();
                            },
                            icon: Icon(Icons.close_rounded, color: colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: colors.outlineVariant.withValues(alpha: 0.25)),
                    if (widget.canSearchItems)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          controller: _searchController,
                          cursorColor: colors.primaryTeal,
                          style: AppTextStyles.s12Regular.copyWith(color: colors.onSurface),
                          onChanged: _searchItems,
                          decoration: InputDecoration(
                            hintText: widget.searchHintText,
                            hintStyle: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceDim),
                            prefixIcon: Icon(Icons.search, color: colors.onSurfaceDim, size: 20),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear, color: colors.onSurfaceDim, size: 18),
                                    onPressed: () {
                                      setState(() {
                                        _searchController.clear();
                                        _updateFilteredItems();
                                      });
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: colors.surfaceContainer,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colors.primaryTeal.withValues(alpha: 0.55)),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: _filteredItems.isEmpty
                          ? Center(
                              child: Text(
                                'No items found',
                                style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceVariant),
                              ),
                            )
                          : ListView.separated(
                              controller: scrollController,
                              itemCount: _filteredItems.length,
                              separatorBuilder: (_, index) =>
                                  Divider(height: 1, thickness: 1, color: colors.outlineVariant.withValues(alpha: 0.12)),
                              itemBuilder: (ctx, index) {
                                final item = _filteredItems[index];
                                final selected = _tempSelectedItems.any((s) => s.value == item.value);
                                final titleColor = !item.isEnabled ? colors.onSurfaceDim : (selected ? colors.primaryTeal : colors.onSurface);
                                return ListTile(
                                  enabled: item.isEnabled,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                  title: Text(item.title, style: AppTextStyles.s12Regular.copyWith(color: titleColor)),
                                  trailing: selected
                                      ? Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: colors.primaryTeal, width: 1.5),
                                          ),
                                          child: Icon(Icons.check_rounded, size: 16, color: colors.primaryTeal),
                                        )
                                      : null,
                                  onTap: () {
                                    if (!item.isEnabled) return;
                                    _toggleItemSelection(item);
                                    if (!widget.isMultipleSelection) {
                                      widget.onItemSelected?.call(item);
                                      Navigator.of(ctx).pop();
                                    }
                                  },
                                );
                              },
                            ),
                    ),
                    if (widget.isMultipleSelection)
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          border: Border(top: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.18))),
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _tempSelectedItems = List<SelectableItem<T>>.from(_selectedItems);
                                  _updateFilteredItems();
                                  _searchController.clear();
                                });
                                Navigator.of(ctx).pop();
                              },
                              child: Text('Cancel', style: AppTextStyles.s12SemiBold.copyWith(color: colors.onSurfaceVariant)),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedItems = List<SelectableItem<T>>.from(_tempSelectedItems);
                                });
                                widget.onItemsSelected?.call(_selectedItems);
                                Navigator.of(ctx).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primaryTeal,
                                foregroundColor: colors.onPrimaryTeal,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ).whenComplete(() => FocusManager.instance.primaryFocus?.unfocus());
  }

  @override
  Widget buildContent(BuildContext context) {
    if (widget.child != null) {
      return GestureDetector(onTap: () => _showItemListModal(context), child: widget.child!);
    }

    final colors = context.colors;
    final label = _selectedItems.isEmpty
        ? 'Select'
        : _selectedItems.length == 1
            ? _selectedItems.first.title
            : '${_selectedItems.length} selected';

    return GestureDetector(
      onTap: () => _showItemListModal(context),
      child: Padding(
        padding: widget.childPadding,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.22)),
          ),
          child: Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyles.s12Regular.copyWith(color: colors.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis)),
              Icon(Icons.keyboard_arrow_down_rounded, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectableItem<T> {
  final String title;
  final bool isEnabled;
  final bool isSelected;
  final T? value;

  const SelectableItem({required this.title, this.value, this.isEnabled = true, this.isSelected = false});

  SelectableItem<T> copyWith({String? title, bool? isEnabled, bool? isSelected, T? value}) {
    return SelectableItem<T>(
      title: title ?? this.title,
      isEnabled: isEnabled ?? this.isEnabled,
      isSelected: isSelected ?? this.isSelected,
      value: value ?? this.value,
    );
  }
}

