import 'package:flutter/material.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String _selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/pictures/logo.png',
                  width: 100,
                  // height: 32,
                ),
                Spacer(),
                Text(
                  'PASQUALE',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          // leading: Container(
          //   width: MediaQuery.of(context).size.width*0.8,
          //   margin: EdgeInsets.only(left: 16),
          //   child: Image.asset(
          //     'assets/pictures/logo.png',
          //     width:50,
          //     height: 32,
          //   ),
          // ),
        ),
        // AppBar(
        //   title: Text('Image Upload'),
        //   actions: [
        //     IconButton(
        //       icon: Icon(
        //         Icons.file_upload,
        //         color: Theme.of(context).primaryColorLight,
        //       ),
        //       onPressed: () {
        //         _showUploadOptions();
        //       },
        //     ),
        //     // Padding(
        //     //   padding: EdgeInsets.only(right: 16.0),
        //     //   child: Text(_selectedOption), // Display selected value in app bar
        //     // ),
        //   ],
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Immagini Anti Opera",
                      // style: Theme.of(context).textTheme.bodyMedium,
                      style: TextStyle(
                        fontSize: 15.0,
                        // fontFamily: "Poppins",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "Premi sui tre puniti (1) per scaricare o eliminare un'immagnini",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _showUploadOptions();
                      },
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "CARRICA IMMAGINE",
                            style: TextStyle(
                                fontSize: 7,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColorLight)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  child: TextField(
                    // textAlignVertical: TextAlignVertical.center,

                    style: TextStyle(fontSize: 8, color: Colors.grey),
                    decoration: InputDecoration(
                      hintText: 'Cerca Immagine',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Expanded(
                    child: GridView.count(
                      crossAxisSpacing: 5,
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      children:
                          List.generate(8, (index) => _buildImageWidget(index)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildImageWidget(int index) {
    return Image.asset(
      'assets/pictures/upload_image.png',
      height: 50,
    );
  }

  void _showUploadOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text('Option 1'),
                    value: 'Option 1',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Option 2'),
                    value: 'Option 2',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Option 3'),
                    value: 'Option 3',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
