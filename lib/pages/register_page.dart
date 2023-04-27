import 'package:codigo6_qr/db/db_admin.dart';
import 'package:codigo6_qr/models/qr_model.dart';
import 'package:codigo6_qr/pages/home_page.dart';
import 'package:codigo6_qr/ui/widgets/common_button_widget.dart';
import 'package:codigo6_qr/ui/widgets/common_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisterPage extends StatefulWidget {
  String urlData;

  RegisterPage({super.key, required this.urlData});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _observationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.amber,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        content: const Text("El libro se registró correctamente"),
      ),
    );
  }

  void saveQR() {
    if (_formKey.currentState!.validate()) {
      FocusScopeNode myFocusScope = FocusScope.of(context);
      myFocusScope.unfocus();

      DateFormat myFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
      String myDate = myFormat.format(DateTime.now());

      QRModel model = QRModel(
        title: _titleController.text,
        observation: _observationController.text,
        dateTime: myDate,
        url: widget.urlData,
      );

      Future.delayed(const Duration(milliseconds: 400), () {
        DBAdmin().inserQR(model).then((value) {
          if (value >= 0) {
            // Navigator.pop(context);
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
            showSuccess();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Registrar Contenido",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        "Por favor ingresa los campos requeridos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CommonTextFieldWidget(
                        hintText: "Ingresa un título...",
                        controller: _titleController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CommonTextFieldWidget(
                        hintText: "Ingresa una observación...",
                        controller: _observationController,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                        ),
                        child: QrImage(
                          data: widget.urlData,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CommonButtonWidget(
                onPressed: () {
                  saveQR();
                },
                text: "Guardar",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
