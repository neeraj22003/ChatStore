import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class DropdownWidget extends StatelessWidget {
  final String yourDefaultvalue;
  final String yourdefaultlabel;
  final ValueNotifier<String?> onTaponCurrentlocation;
  final ValueNotifier<bool> isloading;
  final void Function(String?)? onSelected;
  const DropdownWidget({
    super.key,
    required this.isloading,
    required this.yourDefaultvalue,
    required this.yourdefaultlabel,
    required this.onTaponCurrentlocation,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),

      child: LayoutBuilder(
        builder: (context, constraints) {
        
          return ValueListenableBuilder(
            valueListenable: isloading,
            builder: (context, value, child) {
              return IgnorePointer(
                ignoring: value,
                child: ValueListenableBuilder(
                  valueListenable: onTaponCurrentlocation,
                  builder: (context, location, child) => DropdownMenuTheme(
                    data: DropdownMenuThemeData(
                      textStyle: TextStyle(fontSize: 12),
                    ),
                    child: DropdownMenuFormField<String?>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Error while fetching location ';
                        }
                        return null;
                      },

                      onSelected: onSelected,
                      alignmentOffset: Offset(0, 8),
                      trailingIcon: value
                          ? SizedBox(
                              height: 18,
                              width: 18,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Icon(Icons.arrow_drop_down),

                      initialSelection: location ?? yourDefaultvalue,
                      inputDecorationTheme: InputDecorationTheme(
                        isDense: true,
                        constraints: BoxConstraints(
                          maxHeight: 55,
                          minHeight: 40,
                        ),
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      menuStyle: MenuStyle(
                        elevation: MaterialStateProperty.all(6),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.transparent,
                              width: 80,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        maximumSize: MaterialStatePropertyAll(
                          Size(constraints.maxWidth, 200),
                        ),
                      ),
                      width: constraints.maxWidth,
                      selectOnly: true,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                          value: yourDefaultvalue,
                          label: yourdefaultlabel,
                        ),
                        DropdownMenuEntry(
                          value: location,
                          label: location ?? 'Use Current Location',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
