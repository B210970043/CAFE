import 'dart:io';
import 'dart:math';

import 'package:find_and_contact/screens/auth/register_service.dart';
import 'package:find_and_contact/src/models/user_model.dart';
import 'package:find_and_contact/src/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AddZar extends StatefulWidget {
  const AddZar({super.key});
  @override
  State<AddZar> createState() => _AddZarState();
}

class _AddZarState extends State<AddZar> {
  Users? user;
  RegisterService service = RegisterService();
  final PageController _pageController = PageController();
  final _org_or_hum = TextEditingController();  // HUWI HUN BAIGUULLAGA
  List<TextEditingController> _image = List.generate(1, (index) => TextEditingController());
  final _name = TextEditingController(); 
  final _price = TextEditingController(); 
  final _type = TextEditingController(); // TOYOTA, HYUNDAI
  // final _main_location = TextEditingController(); // AIMAG,HOT
  // final _sub_location = TextEditingController(); // DUUREG, HOROO
  // final _num_of_door = TextEditingController();
  // final _hurd = TextEditingController(); // BURUU, ZOW
  final _mainImage = TextEditingController();  // HUWI HUN BAIGUULLAGA
  

  bool isLeasing = false;
  final _made_date = TextEditingController(); // UILDWERLEGDSEN ON
  final _arrived_date = TextEditingController(); // ORJ IRSEN
  final _leasing = TextEditingController();
  // final _color_of_car = TextEditingController();

  final _publish_condition = TextEditingController();  // VIP,SPECIAL,SIMILAR
  String? selectedCondition;
  int _currentStep = 0;
  int _selectedValue = 0;
  String? _dropDownValue;

  List<File> selectedImages = [];
  final picker = ImagePicker();
  String _zarId = '';

  
  @override
  void dispose() {
    _pageController.dispose();
    _org_or_hum.dispose();
    _name.dispose();
    _price.dispose();
    _type.dispose();
    _made_date.dispose();
    _arrived_date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        title: Center(child: Text("${user?.name} гуай сайн байна уу", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          _startPage(),
          _addCarInfoPage(),
        ],
      ),
    );
  }

  Widget _startPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/man.png'),
          const SizedBox(height: 150),
          ElevatedButton(
            child: const Text('Эхлэх', style: TextStyle(color: Colors.white),),
            onPressed: () {
              _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 125, 123, 123),
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addCarInfoPage() {
  return Expanded(
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stepper(
            currentStep: _currentStep,
            onStepTapped: (int step) {
              setState(() {
                _currentStep = step;
              });
            },
            onStepContinue: () {
              setState(() {
              _currentStep+=1;
              });
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            steps: _buildSteps(),
          ),
          ElevatedButton(
            onPressed: () {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text("Буцах"),
          ),
        ],
      ),
    ),
  );
}

List<Step> _buildSteps() {
  return [
     Step(
      title: const Text('Алхам 1'),
      content: step1(),
      isActive: _currentStep >= 0,
    ),
    Step(
      title: const Text('Алхам 2'),
      content: step2(),
      isActive: _currentStep >= 1,
    ),
    Step(
      title: const Text('Алхам 3'),
      content: step3(),
      isActive: _currentStep >= 2,
    ),
    Step(
      title: const Text('Алхам 4'),
      content: step4(),
      isActive: _currentStep == 3,
    ),
  ];
}

  void dropDownCallBack(String? _selectedValue){
    if(_selectedValue is String){
      setState(() {
        _dropDownValue = _selectedValue;
        _type.text = _selectedValue;
      });
    }
  }

  Future<void> _selectedDate(String a) async {
    DateTime? _picked =  await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2025));

    if(_picked != null){
      setState(() {
        a=='a'? _made_date.text = _picked.toString().split(" ")[0] : _arrived_date.text = _picked.toString().split(" ")[0] ;
      });
    }
  }
  Widget step1 (){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Material(
            elevation: 3.0,
            child: Column(
              children: [
                ListTile(
                title: Text('Хувь хүн'),
                leading: Radio(
                  value: 1, 
                  groupValue: _selectedValue, 
                  onChanged: (int? value){
                    setState(() {
                      _selectedValue = value!;
                      _org_or_hum.text = 'huwi';
            
                    });
                  }
                ),),
                ListTile(
                  title: Text('Байгууллага'),
                  leading: Radio(
                    value: 2, 
                    groupValue: _selectedValue, 
                    onChanged: (int? value){
                      setState(() {
                        _selectedValue = value!;
                      _org_or_hum.text = 'or';

                      });
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Text(
          'Зургийг оруулна уу',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Center(
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(20),
            child: ElevatedButton(
              onPressed: () {
                getImages();
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.camera_alt_outlined, color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: selectedImages.isEmpty? const Center(
            child: Text('Сонгосон зураг байхгүй'),
          ): GridView.builder(
              itemCount: selectedImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: kIsWeb
                      ? Image.network(
                          selectedImages[index].path,
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        )
                      : GestureDetector(
                        onTap: () => showZoomedImage(context, selectedImages[index], index),
                        child: Image.file(
                            selectedImages[index],
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                      ),
                        
                );
              },
            ),
        )
      ],
    );
  }

  void showZoomedImage(BuildContext context, File image, int index){
    showDialog(
      context: context, 
      builder: (ctx) => Dialog(
        child: Stack(
          children: [
            Positioned(child: InteractiveViewer(
              child: Image.file(
                image,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              )
            )
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(onPressed: (){
                deleteImage(index);
              }, 
              icon: Icon(Icons.delete, color: Colors.red,)
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(onPressed: (){
                Navigator.of(ctx).pop();
              }, 
              icon: Icon(Icons.close, color: Colors.red,)
              ),
            ),
          ],
        ),
      ));
  }

  void deleteImage(int index){
    setState(() {
      selectedImages.removeAt(index);
      Navigator.of(context).pop();
    });
  }



  Widget step2 (){
    return Container(
      decoration: BoxDecoration( borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Машины нэр/үнэ',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Машины нэрийг оруулна уу',
              labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: Icon(Icons.car_repair_rounded, color: Colors.indigo,),
            ),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            controller: _name,
          ),
          SizedBox(height: 16), 
          
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Машины үнийг оруулна уу',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 16, ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffix: Text('₮ сая', style: TextStyle(color: Colors.indigo, fontSize: 20)),
            ),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            controller: _price,
          ),
          SizedBox(height: 16,),
          Text(
            'Машины брэндийг сонгоно уу',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: SizedBox(),
              items: const [
                DropdownMenuItem<String>(
                    value: "HYUNDAI", child: Text("HYUNDAI")),
                DropdownMenuItem<String>(
                    value: "HONDA", child: Text("HONDA")),
                DropdownMenuItem<String>(
                    value: "TOYOTA", child: Text("TOYOTA")),
              ],
              value: _dropDownValue,
              onChanged: dropDownCallBack,
            ),
          ),
          SizedBox(height: 8),
          // Add some spacing
        ],
      )
    );
  }
  Widget step3 (){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Огноо',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Column(
          children: [
            TextField(
              controller: _made_date,
              decoration: InputDecoration(
                labelText: 'Үйлдвэрлэгдсэн он',
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
                )
              ),
              readOnly: true,
              onTap: (){
                _selectedDate( 'a');
              },
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _arrived_date,
              decoration: InputDecoration(
                labelText: 'Орж ирсэн он',
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
                )
              ),
              readOnly: true,
              onTap: (){
                _selectedDate('b');
              },
            ),
          ],
        ),
        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Лизингтэй эсэх',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Switch(
                value: isLeasing, 
                onChanged: (value){
                setState(() {
                  _leasing.text = value==false?'байхгүй':'байгаа';
                  isLeasing = value;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget step4 () {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            color: selectedCondition == 'VIP' ? Colors.red : Colors.white,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCondition = 'VIP';
                  _publish_condition.text = selectedCondition!;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VIP зар',
                      style: TextStyle(color: selectedCondition == 'VIP'? Colors.white : Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text('-Энгийн заруудын дээр байрлана'),
                    SizedBox(height: 5),
                    Text('-Зарын үзэлт болон дугаар харалт ихтэй'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '5 хоног- 14020 ₮',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_right_alt_sharp)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15,),
        SizedBox(
          height: 150,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            color: selectedCondition=='Ordinary'? Colors.grey : Colors.white,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedCondition = 'Ordinary';
                  _publish_condition.text = selectedCondition!;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Энгийн зар',
                      style: TextStyle(color: selectedCondition=='Ordinary'? Colors.white : Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Үнэгүй', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_right_alt_sharp)
                      ],
                    )
                  ],    
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            sentZar();
          },
          child: Text(
            'Илгээх',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }



Future getImages() async {
  final pickedFiles = await picker.pickMultiImage(
    requestFullMetadata: true,
    imageQuality: 100,
    maxHeight: 1000,
    maxWidth: 1000,
  );

  if (pickedFiles == null || pickedFiles.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Зураг оруулна уу')),
    );
    return;
  }

  final appDir = await getApplicationDocumentsDirectory(); // Permanent directory

  setState(() {
    _image = List.generate(
      pickedFiles.length,
      (index) => TextEditingController(),
    );

    selectedImages.clear();

    for (var i = 0; i < pickedFiles.length; i++) {
      // Copy to the permanent directory
      String newPath = "${appDir.path}/${pickedFiles[i].name}";
      File newFile = File(pickedFiles[i].path).copySync(newPath);
      _mainImage.text = newFile.path;
      print(_mainImage.text);
      _image[i].text = newFile.path;
      print(_image[i].text); // Update TextEditingController with new path
      selectedImages.add(newFile);
    }
  });
}



  void sentZar() async {
    String userPhoneNum = "${user?.phone_number}";
    List<String> stringList = _image.map((controller) => controller.text).toList();
    setState(() {
      _zarId = Uuid().v4();
    });
    bool isSent = await service.sentZarIntoSys(
      _zarId,
      userPhoneNum,
      _org_or_hum.text,
      _name.text,
      _price.text,
      _type.text,
      _made_date.text,
      _arrived_date.text,
      _leasing.text,
      _publish_condition.text,
      _mainImage.text,
      stringList,
    );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isSent
            ? 'Зарыг амжилттай нэмлээ'
            : 'Зарыг нэмэхэд алдаа гарлаа. Дахин оролдоно уу',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: isSent ? Colors.green : Colors.red,
    ),
  );
}

}