import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/widgets/widgets.dart';

class TranslatorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TranslatorView();
  }
}

class _TranslatorView extends State<TranslatorView> {
  TextEditingController _fromLanguageController;
  TextEditingController _toLanguageController;
  AvailableLanguage _toSelectedLanguage;
  AvailableLanguage _fromSelectedLanguage;
  TranslatorBloc _translatorBloc;
  final List<AvailableLanguage> availableLanguages = [
    AvailableLanguage(
        id: 1,
        languageShortName: 'en',
        displayName: 'English',
        isSelected: false),
    AvailableLanguage(
        id: 2,
        languageShortName: 'ta',
        displayName: 'Tamil',
        isSelected: false),
    AvailableLanguage(
        id: 3,
        languageShortName: 'si',
        displayName: 'Sinhala',
        isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    _fromLanguageController = TextEditingController();
    _toLanguageController = TextEditingController();
    _fromSelectedLanguage = availableLanguages.first;
    _toSelectedLanguage = availableLanguages.elementAt(1);
    _translatorBloc = BlocProvider.of<TranslatorBloc>(context);
  }

  @override
  void dispose() {
    _fromLanguageController.dispose();
    _toLanguageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 25),
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _fromLanguageController,
                decoration: InputDecoration(
                    hintText: 'Enter Text Here',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              )),
          Container(
            child: Wrap(
              alignment: WrapAlignment.start,
              children: <Widget>[
                IconButton(
                    tooltip: 'Select Image',
                    icon: Icon(Icons.image),
                    onPressed: () async {
                      final results = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TranslatorFromImage()));
                      _fromLanguageController.text = results;
                    }),
                SizedBox(
                  width: 25,
                ),
                DropdownButton<AvailableLanguage>(
                  value: _fromSelectedLanguage,
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (AvailableLanguage newValue) {
                    setState(() {
                      availableLanguages
                          .where((t) => t.isSelected == true)
                          .forEach((f) {
                        f.isSelected = false;
                      });
                      _fromSelectedLanguage = newValue;
                      _fromSelectedLanguage.isSelected = true;
                      if (newValue.id == _toSelectedLanguage.id) {
                        _toSelectedLanguage = availableLanguages
                            .firstWhere((a) => a.isSelected == false);
                        _toSelectedLanguage.isSelected = true;
                      }
                    });
                  },
                  items: availableLanguages
                      .map<DropdownMenuItem<AvailableLanguage>>(
                          (AvailableLanguage value) {
                    return DropdownMenuItem<AvailableLanguage>(
                      value: value,
                      child: IgnorePointer(
                        ignoring: value.isSelected,
                        child: Text(value.displayName),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          BlocConsumer<TranslatorBloc, TranslatorState>(
            builder: (c, s) {
              return Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    scrollPhysics: AlwaysScrollableScrollPhysics(),
                    readOnly: true,
                    maxLines: 5,
                    controller: _toLanguageController,
                    decoration: InputDecoration(
                        hintText: 'Translation',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ));
            },
            listener: (c, s) {
              if (s is TranslatorLoaded) {
                _toLanguageController.clear();
                s.translatedText.forEach((f) => {
                      _toLanguageController.text += f.translatedText + '\n',
                    });
              }
            },
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Wrap(alignment: WrapAlignment.start, children: <Widget>[
              DropdownButton<AvailableLanguage>(
                value: _toSelectedLanguage,
                iconSize: 24,
                elevation: 16,
                onChanged: (AvailableLanguage newValue) {
                  setState(() {
                    _toSelectedLanguage = newValue;
                    _toSelectedLanguage.isSelected = true;
                    if (newValue.isSelected) {
                      _fromSelectedLanguage = availableLanguages
                          .firstWhere((a) => a.isSelected == false);
                    }
                  });
                },
                items: availableLanguages
                    .map<DropdownMenuItem<AvailableLanguage>>(
                        (AvailableLanguage value) {
                  return DropdownMenuItem<AvailableLanguage>(
                    value: value,
                    child: IgnorePointer(
                      ignoring: value.isSelected,
                      child: Text(value.displayName),
                    ),
                  );
                }).toList(),
              )
            ]),
          ),
          Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              onPressed: () async {
                var typedText =
                    _fromLanguageController.text.toString().split('\n');

                _translatorBloc.add(GetTranslationText(
                    translateTexts: typedText,
                    target: _toSelectedLanguage.languageShortName));
              },
              child: Text('Translate'),
            ),
          )
        ],
      ),
    );
  }
}
