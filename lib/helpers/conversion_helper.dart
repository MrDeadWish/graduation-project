enum UnitSystem { si, us }

class ConversionHelper {
  // Площадь
  static double convertArea(double value, UnitSystem from, UnitSystem to) {
    if (from == to) return value;
    return from == UnitSystem.si
        ? value * 10.7639 // m² -> ft²
        : value / 10.7639; // ft² -> m²
  }
  static String suffixArea(UnitSystem system) => system == UnitSystem.si ? 'm²' : 'ft²';

  // Площадь (квадратные миллиметры <-> квадратные дюймы)
  static double convertAreaMm2(double value, UnitSystem from, UnitSystem to) {
    if (from == to) return value;
    return from == UnitSystem.si
        ? value * 0.00155 // mm² -> inch²
        : value / 0.00155; // inch² -> mm²
  }
  static String suffixAreaMm2(UnitSystem system) => system == UnitSystem.si ? 'mm²' : 'in²';


  // Давление (MPa <-> ksi)
  static double convertPressure(double value, UnitSystem from, UnitSystem to) {
    if (from == to) return value;
    return from == UnitSystem.si
        ? value * 0.1450377 // MPa -> ksi
        : value / 0.1450377; // ksi -> MPa
  }

  // Сила (kN <-> kip)
  static double convertForce(double value, UnitSystem from, UnitSystem to) {
    if (from == to) return value;
    return from == UnitSystem.si
        ? value * 0.2248 // kN -> kip
        : value / 0.2248; // kip -> kN
  }
  static String suffixForce(UnitSystem system) => system == UnitSystem.si ? 'kN' : 'kip';


  // Длина (mm <-> inch)
  static double convertLengthMmInch(double value, UnitSystem from, UnitSystem to) {
    if (from == to) return value;
    return from == UnitSystem.si
        ? value * 0.0393701 // mm -> inch
        : value / 0.0393701; // inch -> mm
  }
  static String suffixLength(UnitSystem system) => system == UnitSystem.si ? 'mm' : 'in';

  // Длина (m <-> ft)
  static double convertLengthMFeet(double value, UnitSystem from, UnitSystem to) {
    if (from == to) return value;
    return from == UnitSystem.si
        ? value * 3.28084 // m -> ft
        : value / 3.28084; // ft -> m
  }
static String suffixLengthM(UnitSystem system) => system == UnitSystem.si ? 'm' : 'ft';



  // Сопротивление в ksi <-> MPa
  static double convertKsiMpa(double value, UnitSystem from, UnitSystem to) {
    if (from == to) return value;
    return from == UnitSystem.si
        ? value * 0.1450377 // MPa -> ksi
        : value / 0.1450377; // ksi -> MPa
  }
  static String suffixPressure(UnitSystem system) => system == UnitSystem.si ? 'MPa' : 'ksi';

}
