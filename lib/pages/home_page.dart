import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taabo/authentication/auth_provider.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/components/package_card.dart';
import 'package:taabo/cubits/package/package_cubit.dart';
import 'package:taabo/model/package.dart';
import 'package:taabo/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Package> availablePackages = [
      Package(
        trackingNumber: "1232123212321232123",
        name: "Abdisamad Ibrahim",
        weight: 12,
        store: "Shein",
      ),
      Package(
        trackingNumber: "1232123212321232123",
        name: "Abdisamad Ibrahim",
        weight: 12,
      ),
      Package(
        trackingNumber: "1232123212321232123",
        weight: 12,
        store: "AMAZON",
      ),
      Package(
        trackingNumber: "1232123212321232123",
        weight: 10,
      ),
      Package(
        trackingNumber: "1232123212321232123",
        name: "Abdisamad Yusuf",
        weight: 12,
        store: "ALIBABA",
      ),
    ];

    return BlocProvider(
      create: (context) => PackageCubit()..loadPackages(availablePackages),
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
        body: BlocBuilder<PackageCubit, PackageState>(
          builder: (context, state) {
            if (state is PackageLoaded) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.packages.map(
                          (package) => PackageCard(
                            package: package,
                            isSelected:
                                state.selectedPackages[package] ?? false,
                            onSelect: () =>
                                BlocProvider.of<PackageCubit>(context)
                                    .togglePackageSelection(package),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.selectedPackages.containsValue(true))
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
