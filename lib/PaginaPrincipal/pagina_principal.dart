import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  File _logoImagem = null;
  File _fundoImagem = null;
  final picker = ImagePicker();
  Color currentColor = Colors.black;
  double dimensao = 85.0;
  Offset position = Offset(0.0, 79.0);
  double _opacidadeLogo = 0.6;

  GlobalKey _keyContainerLogo = GlobalKey();

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logo sobre imagem"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImagemElogo(),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Cor fundo"),
                        SizedBox(height: 6),
                        InkWell(
                          onTap: () {
                            paletaDeCores(context);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: currentColor,
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("Direcionar logo"),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              position = Offset(
                                                  position.dx - 1, position.dy);
                                            });
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Icon(
                                                Icons.keyboard_arrow_left,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(position.dx.floor().toString()),
                                        SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              position = Offset(
                                                  position.dx + 1, position.dy);
                                            });
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              position = Offset(
                                                  position.dx, position.dy - 1);
                                            });
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Icon(Icons.keyboard_arrow_up,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text((position.dy - 79.0)
                                            .floor()
                                            .toString()),
                                        SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              position = Offset(
                                                  position.dx, position.dy + 1);
                                            });
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              TamanhoLogo(),
              OpacidadeLogo(),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: logoImagem,
            child: Icon(Icons.account_box),
          ),
          SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            onPressed: fundoImagem,
            child: Icon(Icons.account_box),
          )
        ],
      ),
    );
  }

  Future fundoImagem() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _fundoImagem = File(pickedFile.path);
    });
  }

  Future logoImagem() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _logoImagem = File(pickedFile.path);
    });
  }

  OpacidadeLogo() {
    return Slider(
      value: _opacidadeLogo,
      divisions: 6,
      onChanged: (newRating) {
        setState(() => _opacidadeLogo = newRating);
      },
      min: 0.2,
      max: 1.0,
    );
  }

  TamanhoLogo() {
    return Column(
      children: <Widget>[
        Text(dimensao.toString()),
        Slider(
          value: dimensao,
          divisions: 130,
          onChanged: (newRating) {
            setState(() => dimensao = newRating);
          },
          min: 20,
          max: 150,
        )
      ],
    );
  }

  ImagemElogo() {
    return Stack(
      children: <Widget>[
        _fundoImagem == null
            ? Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 350,
                color: currentColor,
                child: Text(
                  "Imagem de fundo",
                  style: TextStyle(
                      color: useWhiteForeground(currentColor)
                          ? const Color(0xffffffff)
                          : const Color(0xff000000)),
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 350,
                color: currentColor,
                child: ExtendedImage.file(
                  _fundoImagem,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                        minScale: 0.9,
                        animationMinScale: 0.7,
                        maxScale: 3.0,
                        animationMaxScale: 3.5,
                        speed: 1.0,
                        inertialSpeed: 100.0,
                        initialScale: 1.0,
                        inPageView: false);
                  },
                ),
              ),
        _logoImagem == null
            ? Container()
            : Positioned(
                left: position.dx,
                top: position.dy - 100 + 20,
                child: Draggable(
                  child: Opacity(
                    opacity: _opacidadeLogo,
                    child: Container(
                      height: dimensao,
                      width: dimensao,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_logoImagem),
                          fit: BoxFit.contain
                        ),
                      ),
                    ),
                  ),
                  feedback: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: FileImage(_logoImagem),
                      colorFilter: new ColorFilter.mode(
                          Colors.white.withOpacity(0.5), BlendMode.dstATop),
                    )),
                    width: dimensao,
                    height: dimensao,
                  ),
                  onDraggableCanceled: (Velocity velocity, Offset offset) {
                    print(offset);
                    setState(() => position = offset);
                  },
                ),
              ),
      ],
    );
  }

  void paletaDeCores(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: changeColor,
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
