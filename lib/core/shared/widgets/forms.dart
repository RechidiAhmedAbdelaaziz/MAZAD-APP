import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/themes/colors.dart';

class AppForm extends StatelessWidget {
  final Widget infoForm;
  final Widget attachmentForm;
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final bool isLoading;
  final String title;

  const AppForm({
    super.key,
    required this.infoForm,
    required this.attachmentForm,
    required this.isSaving,
    required this.onSave,
    required this.onCancel,
    required this.isLoading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.grey[100],
      ),
      child:
          isLoading
              ? _buildLoading()
              : Column(
                children: [
                  Row(
                    children: [
                      _buildTitle(),
                      const Spacer(),
                      _buildButtons(),
                    ],
                  ),
                  heightSpace(20),
                  Expanded(child: _buildForms()),
                ],
              ),
    );
  }

  Widget _buildLoading() =>
      Stack(children: [LinearProgressIndicator()]);

  Widget _buildTitle() {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.spMax,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        _buildButton(
          'Sauvegarder',
          onSave,
          isPrimary: true,
          isLoading: isSaving,
          isDisabled: isSaving || isLoading,
        ),
        widthSpace(20),
        _buildButton('Annuler', onCancel),
      ],
    );
  }

  Widget _buildButton(
    String title,
    VoidCallback onPressed, {
    bool isPrimary = false,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return InkWell(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isPrimary ? KColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isPrimary ? KColors.primary : Colors.black,
          ),
        ),
        child:
            isLoading
                ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                )
                : Text(
                  title,
                  style: TextStyle(
                    color: isPrimary ? Colors.white : Colors.black,
                    fontSize: 14.spMax,
                    fontWeight: FontWeight.w500,
                  ),
                ),
      ),
    );
  }

  Widget _buildForms() {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildForm(infoForm)),
        widthSpace(8),
        Expanded(child: _buildForm(attachmentForm)),
      ],
    );
  }

  Widget _buildForm(Widget form) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: form,
    );
  }
}
