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
}
