tableextension 70869752 "ESNShipping AgentShip" extends "Shipping Agent"
{
    fields
    {
        field(70869750; "ESNShipping Agent APIShip"; Enum "ESNShipping AgentShip")
        {
            Caption = 'Shipping Agent API';
            DataClassification = CustomerContent;
        }

        field(70869751; "ESNDefault ServiceShip"; Code[10])
        {
            Caption = 'Default Service';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field(Code));
        }
        field(70869753; "ESNMovement Ref. NumberShip"; text[18])
        {
            Caption = 'Movement Reference Number (MRN)';
            DataClassification = CustomerContent;
        }
        field(70869756; "ESNDefault Ship-from TypeShip"; Enum "ESNPackageShipFromTypeShip")
        {
            Caption = 'Default Ship-from Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "ESNDefault Ship-from TypeShip" <> xRec."ESNDefault Ship-from TypeShip" then begin
                    Validate("ESNDef. Ship-from ContactShip", '');
                end;
            end;
        }
        field(70869752; "ESNDef. Ship-from ContactShip"; Code[20])
        {
            Caption = 'Default Ship-from Contact';
            DataClassification = CustomerContent;
            TableRelation = if ("ESNDefault Ship-from TypeShip" = const(Contact)) Contact."No.";

            trigger OnValidate()
            begin
                if ("ESNDef. Ship-from ContactShip" <> '') then begin
                    TestField("ESNDefault Ship-from TypeShip", "ESNDefault Ship-from TypeShip"::Contact);
                end;
            end;
        }
    }

    #region "ESNShipping Agent APIShip"
    procedure GetShippingAgentAPI(): Interface "ESNShipping Agent APIShip"
    begin
        exit(rec."ESNShipping Agent APIShip");
    end;

    procedure GetShippingAgentAPIInterface() ShippingAgentAPIInterface: Interface "ESNShipping Agent APIShip"
    begin
        ShippingAgentAPIInterface := GetShippingAgentAPI().GetShippingAgentAPIInterface(Rec);
    end;
    #endregion
}