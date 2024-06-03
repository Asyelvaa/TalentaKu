import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'controllers/pickimage.controller.dart';

class PickimageScreen extends StatefulWidget {
  const PickimageScreen({Key? key}) : super(key: key);

  @override
  State<PickimageScreen> createState() => _LoginSState();
}

class _LoginSState extends State<PickimageScreen> {
  Uint8List? _image;
  final PickimageController controller = Get.put(PickimageController());

  void _selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void submitRegistration(Uint8List? image) {
    if (_image == null) {
      // Jika gambar tidak diisi, tampilkan dialog peringatan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Peringatan"),
            content: Text("Apakah Anda ingin melanjutkan tanpa gambar?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.updateUserProfile(
                    _image,
                  );
                  // Get.to(() => ProfilePage(image: _image));
                },
                child: const Text("Skip"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
                child: Text(
                  'Tambah Gambar',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      controller.updateUserProfile(
        _image, // Meneruskan gambar ke metode updateUserProfile
      );
      //Get.to(() => ProfilePage(image: _image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.blue200,
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/talentaku.png',
                    height: 120,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                  Center(
                    child: Container(
                      width: 317,
                      height: 440,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Center(
                            child: Text(
                              'Selamat datang',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text(
                                'Semangat buat hari ini ya...',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        radius: 70,
                                        backgroundImage: MemoryImage(_image!),
                                      )
                                    : CircleAvatar(
                                        radius: 70,
                                        backgroundImage: NetworkImage(''),
                                      ),
                                Positioned(
                                  child: IconButton(
                                    iconSize: 20,
                                    color: AppColor.black,
                                    onPressed: _selectImage,
                                    icon: Icon(Icons.add_a_photo),
                                  ),
                                  bottom: -10,
                                  left: 80,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.blue500),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.blue500),
                                ),
                                labelText: "Masukan nomer induk anda",
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Center(
                            child: SizedBox(
                                width: 257,
                                child: MaterialButton(
                                    minWidth: double.infinity,
                                    height: 50,
                                    onPressed: () =>
                                        Get.toNamed(Routes.GRADE),
                                    color: AppColor.blue600,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Lanjut",
                                          style: GoogleFonts.manrope(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          size: 20,
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No image selected");
}
