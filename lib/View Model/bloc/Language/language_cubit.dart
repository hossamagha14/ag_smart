import 'package:ag_smart/View%20Model/bloc/Language/language_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<LanguageStates> {
  LanguageCubit() : super(LanguageIntialState());

  static LanguageCubit get(context) => BlocProvider.of(context);
  bool? isArabic;
  bool isVisible = false;

  chooseArabic() {
    isArabic = true;
    isVisible = true;
    CacheHelper.saveData(key: 'language', value: 'ar');
    chosenLanguage = CacheHelper.getData(key: 'language');
    emit(ChooseLanguageState());
  }

  chooseEnglish() {
    isArabic = false;
    isVisible = true;
    CacheHelper.saveData(key: 'language', value: 'en');
    chosenLanguage = CacheHelper.getData(key: 'language');
    emit(ChooseLanguageState());
  }
}
