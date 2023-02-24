enum 70869758 "ESNADR Quantities UoMShip"
{
    Extensible = true;

    value(0; "ml") { Caption = 'Milliliter (ml)', Comment = 'Milliliter (ml)'; }
    value(10; "pt") { Caption = 'Pint (pt)', Comment = 'Pint (pt)'; }             // 1 pt  --> 473,176 ml
    value(20; "qt") { Caption = 'Quart (qt)', Comment = 'Quarte (qt)'; }         // 1 qt  --> 946,353 ml
    value(30; "L") { Caption = 'Liter (L)', Comment = 'Liter (L)'; }                // 1 L   --> 1000 ml
    value(40; "gal") { Caption = 'Gallon (gal)', Comment = 'Gallone (gal)'; }    // 1 gal --> 3,78541 L --> 3785,41 ml



    value(100; "mg") { Caption = 'Milligram (mg)', Comment = 'Milligramm (mg)'; }
    value(110; "g") { Caption = 'Gram (g)', Comment = 'Gramm (g)'; }              // 1 g    -->    1000 mg
    value(120; "oz") { Caption = 'Ounce (oz)', Comment = 'Unze (oz)'; }          // 1 oz   -->  28.349,5 mg
    value(130; "lb") { Caption = 'Pound (lb)', Comment = 'Pfund (lb)'; }         // 1 lb   -->  453.592 mg
    value(140; "kg") { Caption = 'Kilogram (kg)', Comment = 'Kilogramm (kg)'; }     // 1 kg   --> 1000.000 mg
}
