import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/category.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/add_item_screen/add_item_navigator.dart';
import 'package:mzady/screens/add_item_screen/add_item_vm.dart';
import 'package:mzady/screens/layout/home_layout.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';
import 'package:mzady/shared/combonent/utilis.dart' as utils;
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends BaseView<AddItemScreen, AddItemViewModel>
    implements AddItemNavigator {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _weightController = TextEditingController();
  String dropDownValue = Category.categories[0].name;
  final infoForm = GlobalKey<FormState>();
  int currentStep = 0;
  DateTime auctionDate = DateTime.now();

  File? myImage;
  bool isPicked = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MyUser user=Provider.of<MainProvider>(context).user!;
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(title: const Text('GoBid')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stepper(
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            if (currentStep < getSteps().length) {
              switch (currentStep) {
                case 0:
                  print('=============next 1 BUTTON PRESSSED');

                  if (infoForm.currentState!.validate()) {
                    currentStep++;
                    setState(() {});
                  }
                  break;
                case 1:
                  print('=============next 2 BUTTON PRESSSED');

                  currentStep++;
                  setState(() {});
                  break;
                case 2:
                  print(currentStep);
                  print('=============Upload BUTTON PRESSSED');
                  uploadProductToFireStore();
                  break;
              }
            }
          },
          onStepCancel: () {
            if (currentStep > 0) {
              setState(() {
                currentStep--;
              });
            }
          },
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text('Product Info'),
        content: firstStepContent(),
      ),
      Step(
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text('Date'),
        content: secondStepContent(),
      ),
      Step(
        isActive: currentStep >= 2,
        title: const Text('Image'),
        content: thirdStepContent(),
      ),
    ];
  }

  Widget thirdStepContent() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.black45)),
          child: isPicked
              ? Image.file(
                  myImage!,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/shopcar.png'))),
                ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.blueGrey, shape: BoxShape.circle),
            child: IconButton(
              onPressed: () async {
                var imagePicked =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (imagePicked != null) {
                  myImage = File(imagePicked.path);
                  setState(() {
                    isPicked = true;
                  });
                }
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget secondStepContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Select Your Auction Date : ',
          style: TextStyle(fontSize: 18, color: Colors.blueAccent),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            showAndSelectDate(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: Colors.white70,
            child: Text(
              auctionDate.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget firstStepContent() {
    return Form(
      key: infoForm,
      child: Column(
        children: [
          const SizedBox(height: 10),
          CustomTextField(
            controller: _titleController,
            label: 'Product Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Your item must have a name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _descriptionController,
            label: 'Description',
            maxLines: 2,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Description help you to get more buyers';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _priceController,
            label: 'Price',
            textInputType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter your product price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _weightController,
            label: 'Product Weight',
            textInputType: TextInputType.number,
            validator: (value) {
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Category',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width * .3,
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    value: dropDownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: Category.categories
                        .map((item) => DropdownMenuItem(
                            value: item.name,
                            child: Text(
                              item.name,
                              style: Theme.of(context).textTheme.subtitle1,
                            )))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value ?? dropDownValue;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<void> showAndSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: auctionDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if (picked != null && picked != auctionDate) {
      setState(() {
        auctionDate = picked;
      });
    }
  }

  @override
  AddItemViewModel initViewModel() {
    return AddItemViewModel();
  }

  void uploadProductToFireStore() {
    var userid = Provider.of<MainProvider>(context, listen: false).user!.id;

    viewModel.addProductToFireStore(
        title: _titleController.text,
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        weight: _weightController.text,
        category: dropDownValue.toLowerCase(),
        endDate: auctionDate.millisecondsSinceEpoch.toString(),
        sellerId: userid,
        imgFile: myImage);
  }

  @override
  void hideDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void showMessage(String message, String positiveBtnTxt) {
    utils.showMessage(context, message, positiveBtnTxt, (context) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeLayout.routeName, (route) => false);
    });
  }
}
