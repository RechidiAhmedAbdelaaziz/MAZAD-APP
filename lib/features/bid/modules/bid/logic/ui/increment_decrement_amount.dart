part of 'bid_form.dart';

class _IncrementAmount extends StatelessWidget {
  final List<int> amounts;

  const _IncrementAmount({required this.amounts });

  @override
  Widget build(BuildContext context) {
    final amountController =
        context.read<BidCubit>().state.bidDto.amountController;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: amountController,
          builder: (context, value, child) {
            return Text(
              '$value DA',
              style: TextStyle(
                fontSize: 20.sp,
                color: KColors.dark,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        Text(
          "IncrementBy".tr(context),
          style: TextStyle(
            fontSize: 16.sp,
            color: KColors.darkGrey,
            fontWeight: FontWeight.w400,
          ),
        ),
        heightSpace(2),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              amounts
                  .map(
                    (amount) => ElevatedButton(
                      onPressed:
                          () => amountController.setValue(
                            amount + (amountController.value ?? 0),
                          ),
                      child: Text(
                        "+$amount",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: KColors.dark,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
