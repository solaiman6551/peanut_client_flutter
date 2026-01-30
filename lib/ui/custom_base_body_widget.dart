import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/base/base_consumer_state.dart';
import '../utils/dimension/app_dimen.dart';


class CustomBaseBodyWidget extends ConsumerStatefulWidget{

  final Widget child;
  final EdgeInsetsGeometry padding;

  const CustomBaseBodyWidget({
    super.key,
    required this.child,
    this.padding = AppDimen.commonAllSidePadding10
  });

  @override
  BaseConsumerState<CustomBaseBodyWidget> createState() => _CustomBaseBodyWidgetState();
}

class _CustomBaseBodyWidgetState extends BaseConsumerState<CustomBaseBodyWidget> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: widget.padding,
          child: widget.child,
        )
      ],
    );
  }
}