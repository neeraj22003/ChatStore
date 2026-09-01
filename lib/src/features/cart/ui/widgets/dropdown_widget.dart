import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String yourDefaultvalue;
  final String yourdefaultlabel;
  final ValueNotifier<String?> onTaponCurrentlocation;
  final ValueNotifier<bool> isloading;
  final void Function(String?)? onSelected;
  final TextEditingController? controller;

  const DropdownWidget({
    super.key,

    required this.controller,
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
                    child: DropdownMenu<String?>(
                    
                      controller: controller,
                      
                      onSelected: onSelected,
                      alignmentOffset: Offset(0, 8),
                      trailingIcon: value
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : ValueListenableBuilder(
                              valueListenable: controller!,
                              builder: (context, v, child) {
                                return Icon(
                                  v.text.trim() == yourDefaultvalue.trim()
                                      ? Icons.home
                                      : Icons.my_location,
                                );
                              },
                            ),

                      initialSelection:location?? yourDefaultvalue ,
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
                        elevation: WidgetStateProperty.all(6),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.transparent,
                              width: 80,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        maximumSize: WidgetStatePropertyAll(
                          Size(constraints.maxWidth, 200),
                        ),
                      ),
                      width: constraints.maxWidth,
                      selectOnly: true,
                      dropdownMenuEntries: (location==null||location.isEmpty)?
                      [ DropdownMenuEntry(
                          leadingIcon: const Icon(Icons.home),
                          value: yourDefaultvalue,
                          label: yourdefaultlabel,
                        ),]:
                       [
                        DropdownMenuEntry(
                          leadingIcon: const Icon(Icons.home),
                          value: yourDefaultvalue,
                          label: yourdefaultlabel,
                        ),
                        DropdownMenuEntry(
                          leadingIcon: const Icon(Icons.my_location),
                          value: location,
                          label: location ,
                        ),
                      ]
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
