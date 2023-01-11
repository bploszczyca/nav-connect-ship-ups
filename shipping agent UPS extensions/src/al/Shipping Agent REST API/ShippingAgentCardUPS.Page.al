page 70869800 "ESNShipping Agent CardUPS"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Shipping Agent";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'Allgemein';
                field("Code"; rec.Code) { Editable = false; ApplicationArea = All; }
                field(Name; rec.Name) { ApplicationArea = All; }
                field("ESNDefault ServiceUPS"; rec."ESNDefault ServiceShip")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("ESNDefault Ship-from TypeUPS"; rec."ESNDefault Ship-from TypeShip") { ApplicationArea = All; }
                field("ESNDef. Ship-from ContactUPS"; rec."ESNDef. Ship-from ContactShip") { ApplicationArea = All; }
            }
            group("UPS Account Information")
            {
                Caption = 'UPS Account Information', Comment = 'UPS Zugangsdaten';
                field("ESNUPS Account NumberUPS"; rec."ESNAccount NumberUPS") { ApplicationArea = All; }
                field("ESNUPS User NameUPS"; rec."ESNUser NameUPS") { ApplicationArea = All; }
                field("ESNUPS User PasswordUPS"; rec."ESNUser PasswordUPS") { ApplicationArea = All; }
                field("ESNAccess KeyUPS"; rec."ESNAccess KeyUPS") { ApplicationArea = All; }
            }
            group("UPS REST API")
            {
                Caption = 'UPS REST API', Comment = 'UPS REST API';
                field("ESNREST API EndpointUPS"; rec."ESNREST API EndpointUPS") { ApplicationArea = All; }
                field("ESNREST VersionUPS"; rec."ESNREST VersionUPS") { ApplicationArea = All; }
                field("Shipping REST URL"; rec.GetShippingURL())
                {
                    Caption = 'Shipping REST URL', Comment = 'Shipping REST URL';
                    ApplicationArea = All;
                }
                field("Cancel Shipping REST URL"; rec.GetShippingCancelURL())
                {
                    Caption = 'Cancel Shipping REST URL', Comment = 'Cancel Shipping REST URL';
                    ApplicationArea = All;
                }
                field("Shipping Label Recovery REST URL"; rec.GetShippingLabelRecoveryURL())
                {
                    Caption = 'Shipping Label Recovery REST URL', Comment = 'Shipping Label Recovery REST URL';
                    ApplicationArea = All;
                }
            }
        }
    }
}