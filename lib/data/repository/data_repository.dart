import 'package:binevir/data/models/sheet_size.dart';

class DataRepository {
  final List<SheetSize> sheetSizes = [
    SheetSize(id: 1, name: '2350х4800мм(7.7x15.7)', sort: 1),
    SheetSize(id: 2, name: '2000х3000мм(6.5x9.8)', sort: 2),
    SheetSize(id: 3, name: '2350х6000мм(7.7x19.7)', sort: 3),
  ];
  SheetSize? selectedSheetSize;
}
