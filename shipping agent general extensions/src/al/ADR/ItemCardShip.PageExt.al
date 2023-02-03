pageextension 70869756 "ESNItem CardShip" extends "Item Card"
{
    actions
    {
        addafter("&Units of Measure")
        {
            action(ESNItemADRQuantitiesShip)
            {
                ApplicationArea = all;
                Caption = 'Item ADR Quantities', Comment = 'Artikel ADR Mengen';
                Image = Change;
                RunObject = page "ESNItem ADR QuantitiesShip";
                RunPageLink = "Item No." = FIELD("No.");
                Scope = Repeater;
            }
        }
    }
}