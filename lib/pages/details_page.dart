import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/components/app_text_form_field.dart';
import 'package:taabo/cubits/details/details_cubit.dart';
import 'package:taabo/utils/store_enums.dart';
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
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  color: const Color(0xFFF9FAFB),
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height - 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextFormField(
                        label: "Tracking Number",
                        initialvalue: trackingNumber,
                        prefixIcon: Icons.qr_code,
                        isReadOnly: true,
                      ),
                      AppTextFormField(
                        label: 'Name',
                        prefixIcon: Icons.person,
                        onChanged: cubit.onNameChanged,
                      ),
                      AppTextFormField(
                        label: 'Weight',
                        prefixIcon: Icons.scale,
                        onChanged: (value) => cubit.onWeightChanged(
                          double.parse(value),
                        ),
                        validator: TextValidators.required,
                      ),
                      _buildStoreDropDown(cubit),
                      Spacer(),
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

  Widget _buildStoreDropDown(DetailsCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownMenu(
        hintText: "Store",
        leadingIcon: Icon(
          Icons.shopping_bag,
          color: Color(0xFF1e78c1),
        ),
        width: double.infinity,
        menuStyle: _getDropMenuStyle(),
        inputDecorationTheme: _getDropInputDecoration(),
        dropdownMenuEntries: [
          DropdownMenuEntry<StoreEnums>(
            value: StoreEnums.EMPTY,
            label: "<EMPTY>",
          ),
          DropdownMenuEntry<StoreEnums>(
            value: StoreEnums.SHEIN,
            label: StoreEnums.SHEIN.name,
            leadingIcon: Image.asset(
              "assets/images/shein.webp",
              height: 20,
              width: 20,
            ),
          ),
          DropdownMenuEntry<StoreEnums>(
            value: StoreEnums.ALIEXPRESS,
            label: StoreEnums.ALIEXPRESS.name,
            leadingIcon: Image.asset(
              "assets/images/aliexpress.png",
              height: 20,
              width: 20,
            ),
          ),
          DropdownMenuEntry<StoreEnums>(
            value: StoreEnums.AMAZON,
            label: StoreEnums.AMAZON.name,
            leadingIcon: Image.asset(
              "assets/images/amazon.png",
              height: 20,
              width: 20,
            ),
          ),
          DropdownMenuEntry<StoreEnums>(
              value: StoreEnums.OTHER,
              label: StoreEnums.OTHER.name,
              leadingIcon: Icon(Icons.question_mark)),
        ],
        onSelected: (selectedEnum) => cubit.onStoreChanged(selectedEnum?.name),
      ),
    );
  }

  MenuStyle _getDropMenuStyle() {
    return MenuStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  InputDecorationTheme _getDropInputDecoration() {
    return InputDecorationTheme(
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24));
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
          child: AppButton(
              text: "Add",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<DetailsCubit>(context).onSubmitButton(
                    trackingNumber,
                  );
                }
              })),
    );
  }
}
