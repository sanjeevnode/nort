import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/theme/app_colors.dart';
import 'package:nort/core/theme/app_text_style.dart';
import 'package:nort/ui/widgets/custom_app_bar.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.light100,
      appBar: CustomAppBar(
        title: 'Add Note',
        prefix: SvgPicture.asset(
          'assets/icons/add.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.dark900,
            BlendMode.srcIn,
          ),
        ),
        actions: [
          ValueListenableBuilder(
              valueListenable: _titleController,
              builder: (context, title, child) {
                return ValueListenableBuilder(
                    valueListenable: _contentController,
                    builder: (context, content, child) {
                      final isDisabled =
                          title.text.isEmpty || content.text.isEmpty;
                      return InkWell(
                        onTap: () {
                          log('save note');
                        },
                        child: Icon(
                          Icons.check_sharp,
                          color: isDisabled ? Colors.grey : AppColors.dark900,
                          size: 24,
                        ),
                      );
                    });
              }),
        ],
      ),
      body: GestureDetector(
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
                controller: _titleController,
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
                      controller: _contentController,
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
      ),
    );
  }
}
