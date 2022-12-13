pageextension 70869783 "ESNPackage CardUPS" extends "ETI-Package Card-NC"
{
    layout
    {
        addafter(Lieferung)
        {
            group(ESNShipmentUPS)
            {
                Caption = 'Shipment';
                field("ESNShipment No.UPS"; rec."ESNShipment No.UPS") { ApplicationArea = All; }
                field("ESNPackage CoutUPS"; rec."ESNPackage CoutUPS") { ApplicationArea = All; }
                group(ESNShipFromAddresseUPS)
                {
                    Caption = 'Ship-from Address';
                    field("ESNShip-from TypeUPS"; rec."ESNShip-from TypeUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from No.UPS"; rec."ESNShip-from No.UPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from CodeUPS"; rec."ESNShip-from CodeUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from NameUPS"; rec."ESNShip-from NameUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from Name 2UPS"; rec."ESNShip-from Name 2UPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from AddressUPS"; rec."ESNShip-from AddressUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from Address 2UPS"; rec."ESNShip-from Address 2UPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                    field("ESNShip-from Coun/Reg CodeUPS"; rec."ESNShip-from Coun/Reg CodeUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from Post CodeUPS"; rec."ESNShip-from Post CodeUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from CityUPS"; rec."ESNShip-from CityUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                    }
                    field("ESNShip-from ContactUPS"; rec."ESNShip-from ContactUPS")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("ESNShip-from CountyUPS"; rec."ESNShip-from CountyUPS")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                    }
                }
            }
        }
        addbefore("Etiscan Package Cont FactBox")
        {
            part("Packages on Ship"; "ESNPackages on Ship FactBoxUPS")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "ESNShipment No.UPS" = field("ESNShipment No.UPS");
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            group(Shipment)
            {
                Caption = 'Shipment';
                Image = Shipment;
                action("Add Package to Shipment")
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
                        ShipUPSMgt: Codeunit "ESNShip UPS Mgt.UPS";
                    begin
                        ShipUPSMgt.AddPackageToShipmentNo(rec, NewPackage);
                        Page.Run(page::"ETI-Package Card-NC", NewPackage);
                    end;
                }
            }
        }
    }
}
