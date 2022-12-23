pageextension 70869783 "ESNPackage CardshipShip" extends "ETI-Package Card-NC"
{
    layout
    {
        addafter(Lieferung)
        {
            group(ESNShipmentUPSshipShip)
            {
                Caption = 'Shipment';
                field("ESNShipment No.UPSshipShip"; rec."ESNShipment No.Ship") { ApplicationArea = All; }
                field("ESNPackage CoutUPSshipShip"; rec."ESNPackage CoutShip") { ApplicationArea = All; }
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
        addbefore("Etiscan Package Cont FactBox")
        {
            part("Packages on Ship"; "ESNPackages FactBoxShip")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "ESNShipment No.Ship" = field("ESNShipment No.Ship");
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            group(ESNShipmentshipShip)
            {
                Caption = 'Shipment';
                Image = Shipment;
                action("ESNAdd Package to ShipmentshipShip")
                {
                    Caption = 'Add Package to Shipment';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+Ins';
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        NewPackage: Record "ETI-Package-NC";
                        ShipUPSMgt: Codeunit "ESNShip UPS Mgt.Ship";
                    begin
                        ShipUPSMgt.AddPackageToShipmentNo(rec, NewPackage);
                        Page.Run(page::"ETI-Package Card-NC", NewPackage);
                    end;
                }
            }
        }
    }
}
