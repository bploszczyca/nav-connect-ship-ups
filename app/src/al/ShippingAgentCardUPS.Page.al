page 70869780 "ESNShipping Agent CardUPS"
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
                field("ESNDefault ServiceUPS"; rec."ESNDefault ServiceUPS")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
            group("UPS Account Information")
            {
                Caption = 'UPS Account Information', Comment = 'UPS Zugangsdaten';
                field("ESNUPS Account NumberUPS"; rec."ESNAccount NumberUPS") { ApplicationArea = All; }
                field("ESNUPS User NameUPS"; rec."ESNUser NameUPS") { ApplicationArea = All; }
                field("ESNUPS User PasswordUPS"; rec."ESNUser PasswordUPS") { ApplicationArea = All; }
                field("ESNAccess KeyUPS"; rec."ESNAccess KeyUPS") { ApplicationArea = All; }
                field(ESNUPS; rec.ESNUPS) { ApplicationArea = All; }
            }
        }
    }

}