import 'package:flutter/material.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sc.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Title',
              style: AppTextStyle.textMdRegular.copyWith(
                color: AppColors.dark100,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              cursorColor: AppColors.dark900,
              style: AppTextStyle.textXlSemibold.copyWith(
                color: AppColors.dark900,
              ),
              decoration: InputDecoration.collapsed(
                hintText: 'Enter title here...',
                hintStyle: AppTextStyle.textXlMedium.copyWith(
                  color: AppColors.dark100,
                ),
              ),
            ),
          ),
          SizedBox(height: sc.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Content',
              style: AppTextStyle.textMdRegular.copyWith(
                color: AppColors.dark100,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(
                    AppColors.dark900,
                  ),
                  radius: const Radius.circular(2),
                  crossAxisMargin: -15,
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  child: TextFormField(
                    scrollController: _scrollController,
                    controller: _textController,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: null,
                    expands: true,
                    cursorColor: AppColors.dark900,
                    style: AppTextStyle.textXlSemibold.copyWith(
                      color: AppColors.dark900,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintStyle: AppTextStyle.textXlMedium.copyWith(
                        color: AppColors.dark100,
                      ),
                      hintText: 'Write your content here...',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
