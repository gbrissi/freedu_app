import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'components/quill_text_field_label.dart';

class TextFieldButton {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  TextFieldButton({
    required this.text,
    required this.icon,
    this.onTap,
  });
}

class QuillTextField extends StatefulWidget {
  const QuillTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    this.focusNode,
    this.keepExpanded = true,
    this.maxLines = 5,
    this.fontSize = 16,
    this.customButton,
  });
  final QuillController controller;
  final String label;
  final double fontSize;
  final FocusNode? focusNode;
  final String placeholder;
  final bool keepExpanded;
  final int maxLines;
  final TextFieldButton? customButton;

  @override
  State<QuillTextField> createState() => _QuillTextFieldState();
}

class _QuillTextFieldState extends State<QuillTextField> {
  bool isHovering = false;
  bool _visibility = false;
  late bool isContentFieldSelected = focusNode.hasFocus;
  final ScrollController _scrollController = ScrollController();

  late final FocusNode focusNode = widget.focusNode ?? FocusNode();
  late final double fontSize = widget.fontSize;

  bool get isExpanded => widget.keepExpanded
      ? true
      : isContentFieldSelected
          ? true
          : false;

  Widget get customButton {
    if (widget.customButton != null) {
      return ElevatedButton.icon(
        onPressed: widget.customButton!.onTap,
        icon: Icon(
          widget.customButton!.icon,
          size: 14,
        ),
        label: Text(
          widget.customButton!.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void setHoverState(bool value) {
    setState(() {
      isHovering = value;
    });
  }

  void _listenToFocusNode() {
    if (isContentFieldSelected != focusNode.hasFocus && mounted) {
      setState(() {
        isContentFieldSelected = focusNode.hasFocus;
      });
    }
  }

  void _listenToController() {
    final bool isTextEmpty =
        widget.controller.document.toPlainText().trim().isEmpty;
    if (_visibility != !isTextEmpty && mounted) {
      setState(() {
        _visibility = !isTextEmpty;
      });
    }
  }

  @override
  void initState() {
    focusNode.addListener(_listenToFocusNode);
    widget.controller.addListener(_listenToController);

    super.initState();
  }

  Color get color => const Color.fromARGB(255, 165, 165, 165);
  Color get highlightColor =>
      Theme.of(context).buttonTheme.colorScheme!.primary;

  Color get detailsColor => isContentFieldSelected
      ? highlightColor
      : isHovering
          ? color.withOpacity(0.7)
          : color.withOpacity(0.5);

  Color? get textColor => isContentFieldSelected
      ? highlightColor
      : Theme.of(context).textTheme.bodyMedium!.color?.withOpacity(0.7);

  @override
  Widget build(BuildContext context) {
    return TextFieldTapRegion(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuillTextFieldLabel(
                label: widget.label,
                color: textColor,
                isSelected: isContentFieldSelected,
              ),
              MouseRegion(
                onEnter: (_) => setHoverState(true),
                onExit: (_) => setHoverState(false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: detailsColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: isExpanded
                            ? fontSize * widget.maxLines + fontSize
                            : fontSize * 2,
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: QuillEditor(
                          focusNode: focusNode, // focusNode,
                          scrollController: _scrollController,
                          scrollable: true,
                          padding: EdgeInsets.zero,
                          autoFocus: false,
                          expands: false,
                          enableSelectionToolbar: false,
                          placeholder: widget.placeholder,
                          controller: widget.controller,
                          readOnly: false,
                          customStyles: DefaultStyles(
                            placeHolder: DefaultTextBlockStyle(
                              TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.55),
                              ),
                              const VerticalSpacing(0, 0),
                              const VerticalSpacing(0, 0),
                              const BoxDecoration(),
                            ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isExpanded ? 1.0 : 0.0,
                        child: Visibility(
                          visible: isExpanded,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                QuillToolbar.basic(
                                  locale: const Locale('pt', 'BR'),
                                  toolbarIconSize: 18,
                                  toolbarSectionSpacing: 4,
                                  toolbarIconCrossAlignment:
                                      WrapCrossAlignment.start,
                                  toolbarIconAlignment: WrapAlignment.start,
                                  showAlignmentButtons: false,
                                  showBackgroundColorButton: false,
                                  showBoldButton: true,
                                  showCenterAlignment: false,
                                  showClearFormat: false,
                                  showCodeBlock: false,
                                  showColorButton: false,
                                  showDirection: false,
                                  showDividers: false,
                                  showFontFamily: false,
                                  showFontSize: false,
                                  showIndent: false,
                                  showHeaderStyle: false,
                                  showItalicButton: true,
                                  showInlineCode: false,
                                  showJustifyAlignment: false,
                                  showLeftAlignment: false,
                                  showLink: true,
                                  showListBullets: true,
                                  showListCheck: false,
                                  showListNumbers: true,
                                  showQuote: true,
                                  showRedo: false,
                                  showRightAlignment: false,
                                  showSearchButton: false,
                                  showSmallButton: false,
                                  showStrikeThrough: false,
                                  showSubscript: false,
                                  showSuperscript: false,
                                  showUnderLineButton: false,
                                  showUndo: false,
                                  controller: widget.controller,
                                  multiRowsDisplay: true,
                                  color: Colors.red,
                                  iconTheme: const QuillIconTheme(
                                    borderRadius: 12,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: customButton,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // TODO: Create a class attributes as "showCustomButtonOnText" to enable such functionality in customButton class.
          Positioned(
            top: 8,
            right: 8,
            child: AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 200,
                ),
                child: _visibility && !isExpanded
                    ? ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.customButton?.onTap,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                widget.customButton?.icon,
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme
                                    ?.primary,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
