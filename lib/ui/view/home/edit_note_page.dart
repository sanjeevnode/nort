// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nort/core/core.dart';
import 'package:nort/data/data.dart';
import 'package:nort/domain/cubit/app_cubit.dart';
import 'package:nort/ui/ui.dart';
import 'package:nort/ui/widgets/loading_overlay.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, required this.note});
  final Note note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _scrollController = ScrollController();

  Future<void> _handleSave() async {
    _hideKeyboard();
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      return;
    }
    final pin = await Navigator.pushNamed(context, AppRouteNames.enterPassword);
    if (pin == null) {
      return;
    }
    _hideKeyboard();
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final note = widget.note.copyWith(title: title, content: content);
    await context.read<AppCubit>().updateNote(
          note: note,
          pin: pin.toString(),
        );
    Navigator.pop(context);
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  void _hideKeyboard() {
    // This uses system channels to directly request keyboard hiding
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _unfocus();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
  }

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return LoadingWrapper(
        child: Scaffold(
          backgroundColor: AppColors.light100,
          appBar: CustomAppBar(
            title: 'Edit Note',
            enableBack: true,
            prefix: SvgPicture.asset(
              'assets/icons/add.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.dark900,
                BlendMode.srcIn,
              ),
            ),
          ),
          floatingActionButton: ValueListenableBuilder(
            valueListenable: _titleController,
            builder: (context, title, child) {
              return ValueListenableBuilder(
                valueListenable: _contentController,
                builder: (context, content, child) {
                  final isDisabled = title.text.isEmpty || content.text.isEmpty;
                  return FloatingActionButton(
                    backgroundColor:
                        isDisabled ? AppColors.primary500 : AppColors.primary,
                    onPressed: () {
                      if (isDisabled) {
                        return;
                      }
                      _hideKeyboard();
                      _handleSave();
                    },
                    child: const Icon(
                      Icons.check,
                      color: AppColors.light100,
                    ),
                  );
                },
              );
            },
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
        ),
      );
    });
  }
}
