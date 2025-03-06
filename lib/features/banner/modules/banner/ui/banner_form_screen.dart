import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/constants/static_data.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/extension/snackbar.extension.dart';
import 'package:mazad_app/core/extension/validator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/drop_down_menu.dart';
import 'package:mazad_app/core/shared/widgets/image_field.dart';
import 'package:mazad_app/core/shared/widgets/submit_button.dart';
import 'package:mazad_app/core/shared/widgets/text_form_field.dart';
import 'package:mazad_app/features/banner/modules/banner/logic/banner_cubit.dart';

class BannerFormScreen extends StatelessWidget {
  const BannerFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BannerCubit, BannerState>(
      listener: (context, state) {
        state.onError(context.showErrorSnackbar);

        state.onSave(context.back);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Banner'.tr(context))),
        body:
            !context.select(
                      (BannerCubit cubit) => cubit.state.isLoaded,
                    ) ||
                    context.select(
                      (BannerCubit cubit) => cubit.state.isLoading,
                    )
                ? Center(child: CircularProgressIndicator())
                : Builder(
                  builder: (context) {
                    final dto = context.read<BannerCubit>().state.dto;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Form(
                        key: dto.formKey,
                        child: Column(
                          children: [
                            ImageField(
                              controller: dto.imageController,
                              height: 509.h,
                              width: 408.w,
                              borderRadius: 33.r,
                            ),
                            heightSpace(16),

                            AppTextFormField(
                              controller: dto.titleController,
                              title: 'Title'.tr(context),
                              validator:
                                  (value) =>
                                      value.isEmpty
                                          ? 'RequiredField'.tr(
                                            context,
                                          )
                                          : null,
                            ),
                            heightSpace(16),

                            KDropDownMenu(
                              items: StaticData.regions,
                              controller: dto.regionController,
                              title: 'Region'.tr(context),
                              validator:
                                  (value) =>
                                      value.isEmpty
                                          ? 'RequiredField'.tr(
                                            context,
                                          )
                                          : null,
                            ),
                            heightSpace(16),

                            Builder(
                              builder: (context) {
                                return SubmitButton(
                                  title: 'Save'.tr(context),
                                  onTap:
                                      context
                                          .read<BannerCubit>()
                                          .save,
                                  isLoading: context.select(
                                    (BannerCubit cubit) =>
                                        cubit.state.isLoading,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
