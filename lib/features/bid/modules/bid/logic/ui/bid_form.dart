import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/extension/snackbar.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/submit_button.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/bid/modules/bid/logic/bid_cubit.dart';

part 'increment_decrement_amount.dart';
part 'quantity.dart';

class BidForm extends StatelessWidget {
  final List<int> amounts;
  final int quantity;
  const BidForm({
    super.key,
    required this.amounts,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (BidCubit cubit) =>
          cubit.state.isLoading || !cubit.state.isLoaded,
    );
    return BlocListener<BidCubit, BidState>(
      listener: (context, state) {
        state.onError(context.showErrorSnackbar);
        state.onSave(context.back);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: KColors.darkGrey),
        ),
        child:
            isLoading
                ? LinearProgressIndicator()
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'YourOffer'.tr(context),
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: KColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightSpace(12),
                    _IncrementAmount(amounts: amounts),
                    heightSpace(12),
                    _Quantity(max: quantity),
                    heightSpace(12),
                    SubmitButton(
                      onTap: () => context.read<BidCubit>().saveBid(),
                      title: 'Submit'.tr(context),
                    ),
                  ],
                ),
      ),
    );
  }
}
