import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taabo/authentication/auth_provider.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/components/parcel_card.dart';
import 'package:taabo/cubits/package/parcel_cubit.dart';
import 'package:taabo/model/package.dart';
import 'package:taabo/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Parcel> availablePackages = [
      Parcel(
        refNumber: "1232123212321232123",
        recipientName: "Abdisamad Ibrahim",
        kg: 12,
        store: "Shein",
      ),
      Parcel(
        refNumber: "1232123212321232123",
        recipientName: "Abdisamad Ibrahim",
        kg: 12,
      ),
      Parcel(
        refNumber: "1232123212321232123",
        kg: 12,
        store: "AMAZON",
      ),
      Parcel(
        refNumber: "1232123212321232123",
        kg: 10,
      ),
      Parcel(
        refNumber: "1232123212321232123",
        recipientName: "Abdisamad Yusuf",
        kg: 12,
        store: "ALIBABA",
      ),
    ];

    return BlocProvider(
      create: (context) => ParcelCubit()..loadParcels(availablePackages),
      child: Scaffold(
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
        ),
        body: BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            if (state is ParcelLoaded) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.parcels.map(
                          (parcel) => ParcelCard(
                            parcel: parcel,
                            isSelected: state.selectedParcels[parcel] ?? false,
                            onSelect: () =>
                                BlocProvider.of<ParcelCubit>(context)
                                    .togglePackageSelection(parcel),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.selectedParcels.containsValue(true))
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: AppButton(onPressed: () {}, text: "Submit"),
                    )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScannerPage()),
            );
          },
          backgroundColor: const Color(0xFF1e78c1),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
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
