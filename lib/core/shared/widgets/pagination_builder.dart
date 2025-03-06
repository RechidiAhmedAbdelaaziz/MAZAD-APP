import 'package:flutter/material.dart';
import 'package:mazad_app/core/themes/colors.dart';

class PaginationBuilder<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final VoidCallback? onLoadMore;
  final Axis scrollDirection;
  final Widget? separator;
  final bool isLoading;
  final VoidCallback? onAdd;

  const PaginationBuilder({
    super.key,
    this.scrollDirection = Axis.vertical,
    required this.items,
    required this.itemBuilder,
    this.onLoadMore,
    this.separator,
    this.isLoading = false,
    this.onAdd,
  });

  @override
  State<PaginationBuilder<T>> createState() =>
      _PaginationBuilderState<T>();
}

class _PaginationBuilderState<T> extends State<PaginationBuilder<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.onLoadMore?.call();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      itemCount: widget.items.length + 1,
      itemBuilder:
          (context, index) =>
              index < widget.items.length
                  ? widget.itemBuilder(widget.items[index])
                  : widget.isLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        KColors.primary,
                      ),
                    ),
                  )
                  : widget.onAdd != null
                  ? Center(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: widget.onAdd,
                    ),
                  )
                  : SizedBox.shrink(),
      separatorBuilder:
          (context, index) => widget.separator ?? SizedBox.shrink(),
    );
  }
}
