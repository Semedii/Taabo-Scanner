import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/cubits/details/details_cubit.dart';
import 'package:taabo/utils/text_validators.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({required this.trackingNumber, super.key});

  final String trackingNumber;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        backgroundColor: const Color(0xFF1e78c1),
        leading: _buildAppBarIcon(context),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => DetailsCubit(),
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            state as DetailsInitial;
            final cubit = BlocProvider.of<DetailsCubit>(context);
            return Container(
              color: const Color(0xFFF9FAFB),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField(
                        label: "Tracking Number",
                        initialvalue: trackingNumber,
                        icon: Icons.qr_code,
                        isReadOnly: true,
                      ),
                      _buildInputField(
                        label: 'Weight',
                        icon: Icons.scale,
                        onChanged: cubit.onWeightChanged,
                      ),
                      _buildInputField(
                        label: 'Name',
                        icon: Icons.person,
                        onChanged: cubit.onNameChanged,
                      ),
                      _buildInputField(
                        label: 'Store',
                        icon: Icons.corporate_fare,
                        onChanged: cubit.onStoreChanged,
                        textInputAction: TextInputAction.done,
                      ),
                      _buildSubmitButton(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Text _buildAppBarTitle() {
    return const Text(
      'Enter Details',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  IconButton _buildAppBarIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    String? initialvalue,
    bool isReadOnly = false,
    Function(String)? onChanged,
    TextInputAction? textInputAction = TextInputAction.next,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [_getInputFieldBoxshadow()],
      ),
      child: TextFormField(
        textInputAction: textInputAction,
        autofocus: true,
        enabled: !isReadOnly,
        initialValue: initialvalue,
        readOnly: isReadOnly,
        decoration: _getTextFormFieldDecoration(label, icon),
        validator: TextValidators.required,
        onChanged: onChanged,
      ),
    );
  }

  BoxShadow _getInputFieldBoxshadow() {
    return const BoxShadow(
      color: Colors.black12,
      blurRadius: 4,
      offset: Offset(0, 2),
    );
  }

  InputDecoration _getTextFormFieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF6B7280)),
      prefixIcon: Icon(icon, color: const Color(0xFF1e78c1)),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(16),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
        child: AppButton(
            text: "Submit",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<DetailsCubit>(context)
                    .onSubmitButton(trackingNumber);
              }
            }));
  }
}
