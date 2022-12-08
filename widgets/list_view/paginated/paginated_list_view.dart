import 'dart:io';

import 'package:be_universe/src/widgets/list_view/paginated/paginated_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';
import 'package:shimmer/shimmer.dart';

class PaginatedListView<T, U>
    extends ControlledWidget<PaginatedListViewController<T, U>> {
  const PaginatedListView({
    Key? key,
    required this.viewController,
    required this.itemBuilder,
    this.noDataWidget,
    this.errorWidget,
    this.loadingWidget,
  })  : _type = _Type.simpler,
        super(key: key, controller: viewController);

  const PaginatedListView.sliver({
    Key? key,
    required this.viewController,
    required this.itemBuilder,
    this.noDataWidget,
    this.errorWidget,
    this.loadingWidget,
  })  : _type = _Type.sliver,
        super(key: key, controller: viewController);

  final PaginatedListViewController<T, U> viewController;
  final Widget Function(U) itemBuilder;
  final Widget? errorWidget;
  final Widget? noDataWidget;
  final Widget? loadingWidget;
  final _Type _type;

  @override
  State<PaginatedListView<T, U>> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState<T, U> extends State<PaginatedListView<T, U>> {
  @override
  Widget build(BuildContext context) {
    late Widget shimmerWidget;
    switch (widget._type) {
      case _Type.simpler:
        shimmerWidget = Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Shimmer.fromColors(
              baseColor: const Color(0xff202020),
              highlightColor: Colors.black45,
              child: ListView.builder(
                itemBuilder: _cardBuilder,
                itemCount: 5,
              ),
            ),
          ),
        );
        break;
      case _Type.sliver:
        shimmerWidget = SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              _cardBuilder,
              childCount: 5,
            ),
          ),
        );
        break;
    }
    final loadingWidget = widget.loadingWidget ?? shimmerWidget;
    final subLoadingWidget = Platform.isAndroid
        ? const CircularProgressIndicator()
        : const CupertinoActivityIndicator();
    final noDataWidget = widget.noDataWidget ??
        const Center(
          child: Text('Data not found!', style: TextStyle(color: Colors.white)),
        );
    final errorWidget = Center(
      child: widget.errorWidget ??
          Column(children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 70,
              color: Colors.white,
            ),
            Text(
              widget.controller.error?.description ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ]),
    );
    if (widget.controller.isMainLoading) {
      return loadingWidget;
    } else if (widget.controller.error != null) {
      switch (widget._type) {
        case _Type.simpler:
          return errorWidget;
        case _Type.sliver:
          return SliverToBoxAdapter(child: errorWidget);
      }
    } else if (widget.controller.data.isEmpty) {
      switch (widget._type) {
        case _Type.simpler:
          return noDataWidget;
        case _Type.sliver:
          return SliverToBoxAdapter(child: noDataWidget);
      }
    } else {
      switch (widget._type) {
        case _Type.simpler:
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: widget.controller.scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: widget.controller.data.length,
                  itemBuilder: (ctx, index) {
                    return widget.itemBuilder(widget.controller.data[index]);
                  },
                ),
              ),
              if (widget.controller.isSubLoading) subLoadingWidget,
            ],
          );
        case _Type.sliver:
          var count = widget.controller.data.length;
          if (widget.controller.isSubLoading) count++;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                if (index == widget.controller.data.length) {
                  return subLoadingWidget;
                }
                return widget.itemBuilder(widget.controller.data[index]);
              },
              childCount: count,
            ),
          );
      }
    }
  }

  Widget _cardBuilder(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const SizedBox(
        height: 150,
        width: double.infinity,
      ),
    );
  }
}

enum _Type { simpler, sliver }
