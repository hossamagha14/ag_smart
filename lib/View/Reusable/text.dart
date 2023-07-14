import 'package:ag_smart/View%20Model/database/cache_helpher.dart';

String chosenLanguage = CacheHelper.getData(key: 'language') ?? 'en';
String stationName = CacheHelper.getData(key: 'stationName') ?? '';
int numOfActiveLines = CacheHelper.getData(key: 'numOfActiveLines') ?? 0;
int stationId = CacheHelper.getData(key: 'stationId') ?? 0;
String token = CacheHelper.getData(key: 'token') ?? '';
String refreshToken = CacheHelper.getData(key: 'refreshToken') ?? "";
int userId = CacheHelper.getData(key: 'user_id') ?? 0;
String serialNumber = CacheHelper.getData(key: 'serialNumber') ?? "";
bool isLanguageChosen = CacheHelper.getData(key: 'languageChoosen') ?? false;
int binaryValves = CacheHelper.getData(key: 'binaryValves') ?? 0;

Map<String, Map<String, String>> text = {
  'en': {
    'sign in name': 'Username',
    'Edit settings': 'Edit settings',
    'Edit name': 'Edit name',
    'Factory reset': 'Factory reset',
    'Password': 'Password',
    'Sign in': 'Sign in',
    'confirm password': 'Confirm Password',
    'Create account': 'Create account',
    'Create a new account': 'Create a new account',
    'Change network name': 'Change network name',
    'Horse': 'Horse',
    'Nothing': 'Nothing',
    'Diameter': 'Diameter',
    'Number': 'Number',
    'Series Irrigation': 'Series Irrigation',
    'Manual Irrigation': 'Manual Irrigation',
    'Parallel Irrigation': 'Parallel Irrigation',
    'Custom Irrigation': 'Custom Irrigation',
    'Automatic Irrigation': 'Automatic Irrigation',
    'Irregular water pressure': 'Irregular\nwater\npressure',
    'According to cycle': 'According to cycle',
    'According to time': 'According to time',
    'Watering duration': 'Watering duration',
    'According to quantity': 'According to quantity',
    'Fertilizer': 'Fertilizer',
    'Fertilizer Settings': 'Fertilizer Settings',
    'Scarecrow': 'Scarecrow',
    'Scarecrow Settings': 'Scarecrow Settings',
    'Light': 'Light',
    'Light Settings': 'Light Settings',
    'Settings': 'Settings',
    'Set time': 'Set time',
    'Open valve time': 'Open valve time',
    'Add a period': 'Add a period',
    'Remove a period': 'Remove a period',
    'Device Features': 'Device Features',
    'Lines\' Settings': 'Lines\' Settings',
    'Lines Activation': 'Lines Activation',
    'Line Settings': 'Line Settings',
    'Pump Settings': 'Pump Settings',
    'Irrigation type': 'Irrigation type',
    'Duration settings': 'Duration settings',
    'Duration': 'Duration',
    'Each cycle': 'Each cycle',
    'Set day': 'Set day',
    'Set date': 'Set date',
    'From': 'From',
    'To': 'To',
    'Turn on': 'Turn on',
    'Turn off': 'Turn off',
    'Hours': 'Hours',
    'Minutes': 'Minutes',
    'ml': 'ml',
    'Amount of water': 'Amount of water',
    'Lighting time': 'Lighting time',
    'Fertillization amount': 'Fertillizer amount',
    'Back to home page': 'Back to home page',
    'Device Setup': 'Device Setup',
    'Station info': 'Station info',
    'Station name': 'Station name',
    'Contact us': 'Contact us',
    'About us': 'About us',
    'Change language': 'Change language',
    'Log out': 'Log out',
    'Sure': 'Are you sure?',
    'Yes': 'Yes',
    'No': 'No',
    'Auto duration': 'Auto duration',
    'Irrigation Settings': 'Irrigation Settings',
    'Fertilization Settings': 'Fertilization Settings',
    'Fertilizing by duration': 'Fertilizing by duration',
    'Fertilizing by quantity': 'Fertilizing by quantity',
    'Series Fertilization': 'Series Fertilization',
    'Parallel Fertilization': 'Parallel Fertilization',
    'line': 'line',
    'Next': 'Next',
    'You are not subscribed for this feature':
        'You are not subscribed for this feature',
    'Dashboard': 'Dashboard',
    '[ + ] Add device': '[ + ] Add device',
    'Water consumption (Liter)': 'Water consumption (Liter)',
    'Report': 'Report',
    'Date': 'Date',
    'Download': 'Download',
    'Save screen': 'Save screen',
    'Last 7 days': 'Last 7 days',
    'Last 15 days': 'Last 15 days',
    'Last 30 days': 'Last 30 days',
    'Language': 'Language',
    'Monthly': 'Monthly',
    'Yearly': 'Yearly',
    'By Quarter': 'By Quarter',
    'Custom Range': 'Custom Range',
    'Home': 'Home',
    'The cycle can\'t be more than 24 hours':
        'The cycle can\'t be more than 24 hours',
    'internet': 'internet',
    'linesNumber': 'linesNumber',
    'fertilizer': 'fertilizer',
    'light': 'light',
    'animal': 'animal',
    'pressure': 'pressure',
    'level': 'level',
    'auto': 'auto',
    'flow': 'flow',
    'leak': 'leak',
    'ph': 'ph',
    'tds': 'tds',
    'temp': 'temp',
    'humidity': 'humidity',
    'dinternet':
        'Settings and irrigation control are adjusted manually via the Internet',
    'dlinesNumber':
        'The system has $numOfActiveLines outlets for irrigation and an outlet for the pump. Irrigation line settings are set in sequence, parallel, or each line is separated from the other by duration or quantity',
    'dfertilizer':
        'The system has an outlet for fertilization. Fertilization settings are set sequentially, parallel, or each line is separated from the other by duration or quantity',
    'dlight':
        'The device contains an outlet for controlling lighting according to the duration',
    'danimal':
        'The device contains an outlet to control an animal repellent device that helps protect crops from animal trespassing',
    'dpressure':
        'The device contains a system for measuring water pressure, which determines the appropriate water pressure level for irrigation and helps adjust the type of irrigator according to the change in water pressure in case of choosing parallel irrigation',
    'dlevel': 'level',
    'dauto': 'auto',
    'dflow':
        'The device contains a system for measuring water consumption, through which reports are created',
    'Ok': 'Ok',
    'Cancel': 'Cancel',
    'settings pop up':
        'Any change in these features will lead to the change in all the station settings',
    'delete msg': 'Are you sure you want to delete this station?',
    'delete err': 'An error has occurred while deleting the station.',
    'delete suc': 'Station was deleted successfully',
    'fill name': 'Please put the station name',
    'edit suc': 'Station name has been edited successfully',
    'edit fail': 'This name has already been used for another station',
    'download suc': 'PDF downloaded Successfully',
    'download fail': 'An Error occured while downloading the PDF',
    'Change station name':'Change station name'
  },
  'ar': {
    'sign in name': 'اسم المستخدم',
    'Edit settings': 'تعديل الاعدادات',
    'Edit name': 'تعديل الاسم',
    'Factory reset': 'مسح المحطة',
    'Password': 'كلمة المرور',
    'Sign in': 'تسجيل الدخول',
    'Create account': 'انشاء الحساب',
    'confirm password': 'تأكيد كلمة المرور',
    'Create a new account': 'انشاء حساب جديد',
    'Change network name': 'تغيير اسم المستخدم',
    'Horse': 'حصان',
    'Nothing': 'لا يوجد',
    'Diameter': 'قطر',
    'Number': 'عدد',
    'Series Irrigation': 'الري بالتوالي',
    'Manual Irrigation': 'الري اليدوي',
    'Parallel Irrigation': 'الري بالتوازي',
    'Custom Irrigation': 'الري المخصص',
    'Automatic Irrigation': 'الري الأوتوماتيكي',
    'Irregular water pressure': 'ضغط ماء\n غير منتظم',
    'According to cycle': 'ري حسب الدورة',
    'According to time': 'حسب الساعة',
    'Watering duration': 'مدة الري',
    'According to quantity': 'حسب الكمية',
    'Fertilizer': 'تسميد',
    'Fertilizer Settings': 'إعدادات التسميد',
    'Scarecrow': 'الفزاعة',
    'Scarecrow Settings': 'إعدادات الفزاعة',
    'Light': 'الإضاءة',
    'Light Settings': 'إعدادات الضوء',
    'Settings': 'الإعدادات',
    'Set time': 'تحديد الساعة',
    'Open valve time': 'مدة فتح الصمام',
    'Language': 'اللغة',
    'Add a period': 'إضافة فترة',
    'Remove a period': 'ازالة فترة',
    'Device Features': 'ميزات الجهاز',
    'Lines\' Settings': 'إعدادات الخطوط',
    'Line Settings': 'إعدادات الخط',
    'Lines Activation': 'تفعيل الخطوط',
    'Pump Settings': 'إعدادات المضخة',
    'Irrigation type': 'نوع الري',
    'Duration settings': 'إعدادات المدة',
    'Duration': 'المدة',
    'Each cycle': 'كل دورة ري',
    'Set day': 'تحديد اليوم',
    'Set date': 'تحديد التاريخ',
    'From': 'من',
    'To': 'إلي',
    'Turn on': 'تشغيل',
    'Turn off': 'ايقاف',
    'Hours': 'ساعة',
    'Minutes': 'دقيقة',
    'ml': 'مل',
    'Amount of water': 'كمية الماء',
    'Lighting time': 'مدة الإضاءة',
    'Fertillization amount': 'كمية التسميد',
    'Back to home page': 'العودة للصفحة الرئيسية',
    'Device Setup': 'إعداد الجهاز',
    'Station info': 'معلومات المحطة',
    'Contact us': 'اتصل بنا',
    'About us': 'معلومات عنا',
    'Change language': 'تغيير اللغة',
    'Log out': 'تسجيل الخروج',
    'Sure': 'هل أنت واثق؟',
    'Yes': 'نعم',
    'No': 'لا',
    'Auto duration': 'مدة أوتوماتيكية',
    'Irrigation Settings': 'اعدادات الري',
    'Fertilization Settings': 'اعدادات التسميد',
    'Fertilization by duration': 'تسميد حسب الساعة',
    'Fertilization by quantity': 'تسميد حسب الكمية',
    'Series Fertilization': 'تسميد بالتوالي',
    'Parallel Fertilization': 'تسميد بالتوازي',
    'Fertilizing by duration': 'التسميد بالمدة',
    'Fertilizing by quantity': 'التسميد بالكمية',
    'Station name': 'اسم المحطة',
    'line': 'خط',
    'Next': 'التالي',
    'You are not subscribed for this feature': 'لست مشترك في هذه الخدمة',
    'Dashboard': 'الصفحة الرئيسية',
    '[ + ] Add device': 'إضافة جهاز [ + ]',
    'Water consumption (Liter)': 'إستهلاك الماء (لتر)',
    'Report': 'التقرير',
    'The cycle can\'t be more than 24 hours': 'الدورة لا يجب ان تتجاوز 24 ساعة',
    'Date': 'التاريخ',
    'Last 7 days': 'آخر 7 أيام',
    'Last 15 days': 'آخر 15 أيام',
    'Last 30 days': 'آخر 30 أيام',
    'Monthly': 'شهري',
    'Yearly': 'سنوي',
    'By Quarter': 'ربعي',
    'Custom Range': 'فترة مخصصة',
    'Download': ' تحميل',
    'Save screen': 'حفظ ',
    'Home': 'Home',
    'internet': 'التحكم عبر الانترنت',
    'linesNumber': 'خطوط الري و المضخة',
    'fertilizer': 'التسميد',
    'light': 'التحكم بالإضاءة',
    'animal': 'طارد الحيوانات',
    'pressure': 'قياس ضغط الماء',
    'level': 'قياس مستوى الماء',
    'auto': 'الري الأوتوماتيكي',
    'flow': 'قياس استهلاك الماء',
    'leak': 'استشعار تهريب الماء',
    'ph': 'قياس الحموضة',
    'tds': 'قياس الملوحة',
    'temp': 'قياس الحرارة',
    'humidity': 'قياس الرطوبة',
    'dinternet': 'يتم ضبط الاعدادات و التحكم بالري يدوياً عبر الإنترنت',
    'dlinesNumber': 'يحتوي النظام على $numOfActiveLines مخارج للري و مخرج للمضخة.'
        ' يتم ضبط إعدادات خطوط الري متتالية, متوازية او كل خط منفصل عن الآخر حسب المدة او الكمية',
    'dfertilizer': 'يحتوي النظام على مخرج للتسميد.'
        'يتم ضبط إعدادات التسميد متتالية, متوازية او كل خط منفصل عن الآخر حسب المدة او الكمية',
    'dlight': 'يحتوي الجهاز على مخرج للتحكم بالإضاءة حسب المدة',
    'danimal':
        'يحتوي الجهاز على مخرج للتحكم بجهاز طارد الحيوانات الذي يساعد على حماية المزروعات من تعدي الحيوانات',
    'dpressure':
        'يحتوي الجهاز على نظام لقياس ضغط الماء و الذي يقوم بتحديد مستوى ضغط الماء المناسب للري و و يساعد على ضبط نوع السقاية تبعا لتغير ضغط الماء في حالة اختيار الري المتوازي',
    'dlevel': 'level',
    'dauto': 'auto',
    'dflow':
        "يحتوي الجهاز على نظام لقياس استهلاك الماء و التي عن طريقها يتم انشاء تقارير",
    'dleak': 'leak',
    'dph': 'ph',
    'dtds': 'tds',
    'dtemp': 'temp',
    'dhumidity': 'humidity',
    'Ok': 'موافق',
    'Cancel': 'إلغاء',
    'settings pop up': 'اي تعديل في الإعدادات سيؤثر علي باقي اعدادات المحطة',
    'delete msg': 'هل تريد مسح المحطة؟',
    'delete err': 'ظهور خطأ اثناء مس المحطة',
    'delete suc': 'تم مسح المحطة بنجاح',
    'fill name': 'ضع اسم المحطة',
    'edit suc': 'تم تعديل إسم المحطة بنجاح',
    'edit fail': 'هذا الإسم مستخدم لمحطة اخري',
    'download suc': 'تم تحميل الملف بنجاح',
    'download fail': 'ظهر خطأ اثناء تحميل الملف',
    'Change station name':'تغيير إسم المحطة'
  },
};
