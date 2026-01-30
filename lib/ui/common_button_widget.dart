import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/base/base_consumer_state.dart';
import '../utils/colors.dart';
import '../utils/dimension/dimen.dart';
import '../utils/text_style.dart';
import 'common_text_widget.dart';


class CommonButtonWidget extends ConsumerStatefulWidget {

  final String text;
  final VoidCallback? onPressedFunction;
  final Duration reEnableTime;

  const CommonButtonWidget({
    super.key,
    required this.text,
    required this.onPressedFunction,
    this.reEnableTime = const Duration(milliseconds: 3000),
  });

  @override
  ConsumerState<CommonButtonWidget> createState() => _CommonButtonWidgetState();
}

class _CommonButtonWidgetState extends BaseConsumerState<CommonButtonWidget> {

  bool _canTap = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DimenSizes.dimen_50,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: transparentColor,
            offset: const Offset(1.1, 1.1),
            blurRadius: DimenSizes.dimen_3,
          ),
        ],
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize .shrinkWrap,
        color: primaryColor,
        disabledColor: suvaGreyColor,
        minWidth: MediaQuery.of(context).size.width,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimenSizes.dimen_10)
        ),
        onPressed: widget.onPressedFunction != null ? () => operate() : null,
        child: CommonTextWidget(
            text: widget.text,
            style: semiBold20(color: primaryWhite),
            textAlign: TextAlign.center,
            shouldShowMultipleLine: true
        ),
      ),
    );
  }

  void operate() {
    if (_canTap && widget.onPressedFunction != null) {
      _canTap = false;
      widget.onPressedFunction!();
      Future.delayed(widget.reEnableTime, () {
        if (mounted) {
          _canTap = true;
        }
      });
    } else {
      debugPrint("===================================CLICK IGNORED===================================");
    }
  }

}
