tableextension 70869800 "ESNShipping Agent ServicesUPS" extends "Shipping Agent Services"
{
    fields
    {
        field(70869800; "ESNShipment Service CodeUPS"; Code[2])
        {
            Caption = 'UPS Shipment Service Code';
            DataClassification = CustomerContent;
        }
        field(70869801; "ESNLabel Image FormatUPS"; Enum "ESNLabel Image FormatUPS")
        {
            Caption = 'Label Image Format';
            DataClassification = CustomerContent;
        }
    }

    trigger OnAfterInsert()
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if ShippingAgent.get(rec."Shipping Agent Code") and ShippingAgent.IsShippingAgentUPS then begin
            if ("ESNShipment Service CodeUPS" = '') and (StrLen(Code) = MaxStrLen("ESNShipment Service CodeUPS")) then begin
                Validate("ESNShipment Service CodeUPS", CopyStr(rec.Code, 1, MaxStrLen("ESNShipment Service CodeUPS")));
            end;
        end;
    end;
}