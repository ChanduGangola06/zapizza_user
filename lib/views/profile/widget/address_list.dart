import 'package:flutter/material.dart';
import 'package:zapizza/constants/constants.dart';
import 'package:zapizza/models/addresses_response.dart';
import 'package:zapizza/views/profile/widget/address_tile.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key, required this.addresses});

  final List<AddressResponse> addresses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: kGray,
                  width: 0.5,
                ),
                top: BorderSide(
                  color: kGray,
                  width: 0.5,
                ),
              )),
          child: AddressTile(address: address),
        );
      },
    );
  }
}
