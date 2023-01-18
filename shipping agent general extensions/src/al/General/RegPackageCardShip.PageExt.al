pageextension 70869785 "ESNReg. Package CardShip" extends "ETI-Reg. Package Card-NC"
{
    layout
    {
        addafter("Ship-to Country/Region Code")
        {
            field("International Shipment"; rec.IsInternationalShipment())
            {
                Caption = 'International Shipment';
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }
            field("EU Shipment"; rec.IsEUShipment())
            {
                Caption = 'EU Shipments';
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }
        }
        addbefore(Lieferung)
        {
            group(ESNShipmentUPSShip)
            {
                field("ESNShipment No.Ship"; rec."ESNShipment No.Ship") { ApplicationArea = All; }
                field("ESNPackage CoutShip"; rec."ESNPackage CoutShip") { ApplicationArea = All; }
            }
        }
        addbefore(Links)
        {
            part("Packages on Ship"; "ESNRegPack. FactBoxShip")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "ESNShipment No.Ship" = field("ESNShipment No.Ship");
            }
        }
    }
}