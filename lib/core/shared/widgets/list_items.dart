import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/shared/widgets/search_bar.dart';
import 'package:mazad_app/core/themes/colors.dart';

class FlexItem<T> {
  final Widget Function(T) builder;
  final Widget header;
  final int flex;

  FlexItem({
    required this.builder,
    required this.header,
    this.flex = 1,
  });
}

class ListItems<T> extends StatelessWidget {
  final List<T> items;
  final List<FlexItem<T>> flexItems;
  final VoidCallback? onAdd;
  final VoidCallback? showFilter;
  final TextEditingController searchController;
  final VoidCallback onSearch;
  final VoidCallback onLoad;
  final bool isLoading;

  const ListItems({
    super.key,
    required this.items,
    required this.flexItems,
    this.onAdd,
    this.showFilter,
    required this.searchController,
    required this.onSearch,
    required this.onLoad,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.grey[100],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildButtons(),
              const Spacer(),
              KSearchBar(
                controller: searchController,
                onSearch: onSearch,
                width: 300.w,
              ),
            ],
          ),
          heightSpace(20),
          Expanded(child: _buildItemsBox()),
        ],
      ),
    );
  }

  Widget _buildItemsBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children:
                flexItems
                    .map(
                      (e) => Expanded(flex: e.flex, child: e.header),
                    )
                    .toList(),
          ),
          const Divider(),
          heightSpace(12),
          Expanded(
            child: PaginationBuilder(
              items: items,
              onLoadMore: onLoad,
              isLoading: isLoading,
              separator: heightSpace(12),
              itemBuilder:
                  (item) => Row(
                    children:
                        flexItems
                            .map(
                              (e) => Expanded(
                                flex: e.flex,
                                child: e.builder(item),
                              ),
                            )
                            .toList(),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        if (showFilter != null)
          _buildButton(
            icon: Icons.filter_list,
            title: 'Filter',
            color: Colors.white,
            textColor: Colors.black,
            borderColor: Colors.black,
            onTap: showFilter,
          ),
        widthSpace(20),
        if (onAdd != null)
          _buildButton(
            icon: Icons.add,
            title: 'Ajouter',
            color: KColors.primary,
            textColor: Colors.white,
            borderColor: KColors.primary,
            onTap: onAdd,
          ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String title,
    required Color color,
    required Color textColor,
    VoidCallback? onTap,
    required Color borderColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor),
            widthSpace(12),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 14.spMax,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
