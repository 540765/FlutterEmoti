import 'package:flutter/widgets.dart';

/// 延迟初始化的IndexedStack
class LazyIndexedStack extends StatefulWidget {
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;
  final int index;

  // reuse the created view
  final bool reuse;

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const LazyIndexedStack(
      {super.key,
      this.alignment = AlignmentDirectional.topStart,
      this.textDirection,
      this.sizing = StackFit.loose,
      this.index = 0,
      this.reuse = true,
      required this.itemBuilder,
      required this.itemCount});

  @override
  State<StatefulWidget> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<Widget> _children;
  late List<bool> _loaded;

  @override
  void initState() {
    _loaded = [];
    _children = [];
    for (int i = 0; i < widget.itemCount; ++i) {
      if (i == widget.index) {
        _children.add(widget.itemBuilder(context, i));
        _loaded.add(true);
      } else {
        _children.add(Container());
        _loaded.add(false);
      }
    }
    super.initState();
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    for (int i = 0; i < widget.itemCount; ++i) {
      if (i == widget.index) {
        if (!_loaded[i]) {
          _children[i] = widget.itemBuilder(context, i);
          _loaded[i] = true;
        } else {
          if (widget.reuse) {
            return;
          }
          _children[i] = widget.itemBuilder(context, i);
        }
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }
}
