import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/constants/static_data.dart';
import 'package:mazad_app/core/extension/dialog.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/date_picker.dart';
import 'package:mazad_app/core/shared/widgets/drop_down_menu.dart';
import 'package:mazad_app/core/shared/widgets/submit_button.dart';
import 'package:mazad_app/core/shared/widgets/text_form_field.dart';
import 'package:mazad_app/features/auction/modules/auctionform/logic/auction_form_cubit.dart';

class AuctionFormScreen extends StatelessWidget {
  const AuctionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoaded = context.select(
      (AuctionFormCubit cubit) => cubit.state.isLoaded,
    );
    return BlocListener<AuctionFormCubit, AuctionFormState>(
      listener: (context, state) {
        state.onError(context.showErrorDialog);

        state.onSave(context.back);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Auction'.tr(context))),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 8.h,
          ),
          child: SingleChildScrollView(
            child:
                isLoaded
                    ? Column(
                      children: [
                        _Form(),
                        heightSpace(25),
                        _SaveButton(),
                      ],
                    )
                    : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auctionDto = context.read<AuctionFormCubit>().state.dto;
    return Form(
      key: auctionDto.formKey,
      child: Column(
        children: [
          AppTextFormField(
            title: 'Title'.tr(context),
            controller: auctionDto.titleController,
            validator:
                (value) =>
                    value!.isEmpty
                        ? 'RequiredField'.tr(context)
                        : null,
          ),
          heightSpace(20),

          KDropDownMenu(
            items: StaticData.regions,
            controller: auctionDto.regionController,
            title: 'Region'.tr(context),
            validator:
                (value) =>
                    value!.isEmpty
                        ? 'RequiredField'.tr(context)
                        : null,
          ),
          heightSpace(20),

          AppTextFormField(
            title: 'SubmitPrice'.tr(context),
            controller: auctionDto.priceController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            prefixIcon: Text(
              "DA",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            validator:
                (value) =>
                    value!.isEmpty
                        ? 'RequiredField'.tr(context)
                        : null,
          ),
          heightSpace(20),

          KDatePicker(
            controller: auctionDto.endingDateController,
            title: 'EndingDate'.tr(context),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      title: 'Save'.tr(context),
      onTap: context.read<AuctionFormCubit>().save,
      isLoading: context.select(
        (AuctionFormCubit cubit) => cubit.state.isLoading,
      ),
    );
  }
}
