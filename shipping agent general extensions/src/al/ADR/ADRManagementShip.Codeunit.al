codeunit 70869752 "ESNADR ManagementShip"
{

    [EventSubscriber(ObjectType::Table, database::"Item", 'OnBeforeDeleteEvent', '', true, false)]
    local procedure Item_OnBeforeDeleteEvent(var Rec: Record Item)
    var
        ItemADRQuantityShip: Record "ESNItem ADR QuantityShip";
    begin
        ItemADRQuantityShip.SetRange("Item No.", Rec."No.");
        if not ItemADRQuantityShip.IsEmpty then
            ItemADRQuantityShip.DeleteAll(true);
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Variant", 'OnBeforeDeleteEvent', '', true, false)]
    local procedure ItemVariant_OnBeforeDeleteEvent(var Rec: Record "Item Variant")
    var
        ItemADRQuantityShip: Record "ESNItem ADR QuantityShip";
    begin
        ItemADRQuantityShip.SetRange("Item No.", Rec."Item No.");
        if not ItemADRQuantityShip.IsEmpty then
            ItemADRQuantityShip.DeleteAll(true);
    end;

    procedure GetADRQtyPer_mlgr(ADRUoM: Enum "ESNADR Quantities UoMShip") ADRQtyPer_mlgr: Decimal
    begin
        case ADRUoM of
            // Fluids
            // value(0; "ml") { Caption = 'Milliliter (ml)', Comment = 'Milliliter (ml)'; }
            // value(10; "pt") { Caption = 'Pint (pt)', Comment = 'Pint (pt)'; }             // 1 pt  --> 473,176 ml
            // value(20; "qt") { Caption = 'Quart (qt)', Comment = 'Quarte (qt)'; }         // 1 qt  --> 946,353 ml
            // value(30; "L") { Caption = 'Liter (L)', Comment = 'Liter (L)'; }                // 1 L   --> 1000 ml
            // value(40; "gal") { Caption = 'Gallon (gal)', Comment = 'Gallone (gal)'; }    // 1 gal --> 3,78541 L --> 3785,41 ml
            ADRUoM::ml:
                begin
                    ADRQtyPer_mlgr := 1;
                end;
            ADRUoM::pt:
                begin
                    ADRQtyPer_mlgr := 473.176;
                end;
            ADRUoM::qt:
                begin
                    ADRQtyPer_mlgr := 946.353;
                end;
            ADRUoM::L:
                begin
                    ADRQtyPer_mlgr := 1000;
                end;
            ADRUoM::gal:
                begin
                    ADRQtyPer_mlgr := 3785.41;
                end;

            //solids
            // value(100; "mg") { Caption = 'Milligram (mg)', Comment = 'Milligramm (mg)'; }
            // value(110; "g") { Caption = 'Gram (g)', Comment = 'Gramm (g)'; }              // 1 g    -->    1000 mg
            // value(120; "oz") { Caption = 'Ounce (oz)', Comment = 'Unze (oz)'; }          // 1 oz   -->  28.349,5 mg
            // value(130; "lb") { Caption = 'Pound (lb)', Comment = 'Pfund (lb)'; }         // 1 lb   -->  453.592 mg
            // value(140; "kg") { Caption = 'Kilogram (kg)', Comment = 'Kilogramm (kg)'; }     // 1 kg   --> 1000.000 mg
            ADRUoM::mg:
                begin
                    ADRQtyPer_mlgr := 1;
                end;
            ADRUoM::g:
                begin
                    ADRQtyPer_mlgr := 1000;
                end;
            ADRUoM::oz:
                begin
                    ADRQtyPer_mlgr := 28349.5;
                end;
            ADRUoM::lb:
                begin
                    ADRQtyPer_mlgr := 453592;
                end;
            ADRUoM::kg:
                begin
                    ADRQtyPer_mlgr := 1000000;
                end;
            else begin
                OnUnknownADRQuantitiesUoM(ADRUoM, ADRQtyPer_mlgr);
            end;
        end;
    end;

    local procedure OnUnknownADRQuantitiesUoM(ADRUoM: Enum "ESNADR Quantities UoMShip"; ADRQtyPer_mlgr: Decimal);
    begin
    end;
}
