import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taabo/authentication/auth_provider.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/components/app_text_form_field.dart';
import 'package:taabo/components/parcel_card.dart';
import 'package:taabo/cubits/package/parcel_cubit.dart';
import 'package:taabo/pages/details_page.dart';
import 'package:taabo/pages/scanner_page.dart';
import 'package:taabo/utils/text_validators.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParcelCubit()..loadParcels(),
      child: BlocBuilder<ParcelCubit, ParcelState>(
        builder: (context, state) {
          ParcelCubit cubit = BlocProvider.of<ParcelCubit>(context);
          return Scaffold(
            backgroundColor: const Color(0xFFF9FAFB),
            appBar: AppBar(
              title: const Text(
                'TAJMEX SCANNER',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF1e78c1),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                  onPressed: () => _showBottomDrawer(context),
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  )),
              actions: [
                if (state is ParcelLoaded && state.parcels.length > 0)
                  _buildScanButton(context, state, cubit)
              ],
            ),
            body: _buildBody(context, state),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScannerPage(
                            onSelect: (trackingNumber) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    trackingNumber: trackingNumber!,
                                  ),
                                ),
                              );
                            },
                          )),
                );
              },
              backgroundColor: const Color(0xFF1e78c1),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  GestureDetector _buildScanButton(
      BuildContext context, ParcelLoaded state, ParcelCubit cubit) {
    return GestureDetector(
      onTap: () {
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScannerPage(
                        onSelect: (trackingNumber) {
                          try {
                            final selectedParcel = state.parcels.firstWhere(
                              (parcel) => parcel.refNumber == trackingNumber,
                            );

                            cubit.togglePackageSelection(selectedParcel);
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'No parcel found with tracking number: $trackingNumber'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      )));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.barcode_reader,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ParcelState state) {
    if (state is ParcelLoaded) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          RefreshIndicator(
            onRefresh: BlocProvider.of<ParcelCubit>(context).loadParcels,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (state.parcels.length > 0) ...{
                    _buidlSelectAllButton(context, state),
                  },
                  ...state.parcels.map(
                    (parcel) => ParcelCard(
                      parcel: parcel,
                      isSelected: state.selectedParcels[parcel] ?? false,
                      onSelect: () => BlocProvider.of<ParcelCubit>(context)
                          .togglePackageSelection(parcel),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state.selectedParcels.containsValue(true))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(
                  onPressed: () {
                    _onShipPressed(context);
                  },
                  text: "Ship"),
            )
        ],
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Row _buidlSelectAllButton(BuildContext context, ParcelLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Select All",
          style: TextStyle(
            color: Color(0xFF1e78c1),
            fontWeight: FontWeight.bold,
          ),
        ),
        Checkbox(
          value: state.isSelectAll,
          onChanged: BlocProvider.of<ParcelCubit>(context).onIsSelectAllChanged,
          activeColor: Color(0xFF1e78c1),
        ),
      ],
    );
  }

  Future<dynamic> _onShipPressed(BuildContext context) {
    final cubit = BlocProvider.of<ParcelCubit>(context);
    final totalParcels = cubit.getTotalSelectedParcels();
    final totalCartoons = cubit.getTotalSelectedCartoons();
    final totalWeight = cubit.getTotalSelectedWeight();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)), // Rounded corners
          elevation: 4, // Subtle shadow
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB), // Background color
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Please Enter Flight Information",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1e78c1), // Primary color
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      label: "Flight Number",
                      prefixIcon: Icons.flight,
                      onChanged: cubit.onFlightNumberChanged,
                      validator: TextValidators.required,
                    ),
                    const SizedBox(height: 16),
                    _getTitleAndValue("Total Parcels", "$totalParcels"),
                    const SizedBox(height: 8),
                    _getTitleAndValue("Total Cartoons", "$totalCartoons"),
                    const SizedBox(height: 8),
                    _getTitleAndValue("Total Weight", "$totalWeight kg"),
                    const SizedBox(height: 24),
                    AppButton(
                      text: "Confirm",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.onShipConfirm();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getTitleAndValue(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1e78c1), // Primary color
          ),
        ),
      ],
    );
  }

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.pop(context);
                },
                text: "Confirm Logout",
              ),
            ],
          ),
        );
      },
    );
  }
}
