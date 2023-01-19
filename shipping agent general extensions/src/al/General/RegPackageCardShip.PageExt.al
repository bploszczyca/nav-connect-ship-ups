pageextension 70869752 "ESNReg. Package CardShip" extends "ETI-Reg. Package Card-NC"
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
        addlast(Addresse)
        {
            field("ESNDirect Delivery OnlyShip"; rec."ESNDirect Delivery OnlyShip") { ApplicationArea = All; Importance = Additional; }
        }
        addbefore(Lieferung)
        {
            group(ESNShipmentUPSShip)
            {
                Caption = 'Shipment';
                field("ESNShipment No.UPSshipShip"; rec."ESNShipment No.Ship") { ApplicationArea = All; }
                field("ESNShipment DescriptionShip"; rec."ESNShipment DescriptionShip") { ApplicationArea = All; }
                field("ESNPackage CoutUPSshipShip"; rec."ESNPackage CoutShip") { ApplicationArea = All; }
                field("ESNCost  IdentifierShip"; rec."ESNCost  IdentifierShip") { ApplicationArea = All; }
                field("ESNSaturday Delivery Req.Ship"; rec."ESNSaturday Delivery Req.Ship") { ApplicationArea = All; Importance = Additional; }
                field("ESNSaturday Pickup Req.Ship"; rec."ESNSaturday Pickup Req.Ship") { ApplicationArea = All; Importance = Additional; }
                group(ESNShipFromAddresseUPSshipShip)
                {
                    Caption = 'Ship-from Address';
                    field("ESNShip-from TypeUPSshipShip"; rec."ESNShip-from TypeShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from No.UPSshipShip"; rec."ESNShip-from No.Ship")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from CodeUPSshipShip"; rec."ESNShip-from CodeShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from NameUPSshipShip"; rec."ESNShip-from NameShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from Name 2UPSshipShip"; rec."ESNShip-from Name 2Ship")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from AddressUPSshipShip"; rec."ESNShip-from AddressShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from Address 2UPSshipShip"; rec."ESNShip-from Address 2Ship")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from Coun/Reg CodeUPSshipShip"; rec."ESNShip-from Coun/Reg CodeShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from Post CodeUPSshipShip"; rec."ESNShip-from Post CodeShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from CityUPSshipShip"; rec."ESNShip-from CityShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from ContactUPSshipShip"; rec."ESNShip-from ContactShip")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("ESNShip-from CountyUPSshipShip"; rec."ESNShip-from CountyShip")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                }
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