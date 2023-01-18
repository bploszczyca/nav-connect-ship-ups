tableextension 70869783 "ESNReg. PackageShip" extends "ETI-Reg. Package-NC"
{
    fields
    {
        // Add changes to table fields here
        field(70869780; "ESNShipment No.Ship"; Code[20])
        {
            Caption = 'Shipment No.', Comment = 'Versandauftragsnr.';
            DataClassification = CustomerContent;
        }
        field(70869781; "ESNPackage CoutShip"; Integer)
        {
            Caption = 'Package Cout', Comment = 'Anzahl Pakete';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("ETI-Package-NC" where("ESNShipment No.Ship" = field("ESNShipment No.Ship")));
        }
    }

    procedure GetShippingAgentAPI(): Interface "ESNShipping Agent APIShip"
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if ShippingAgent.get(Rec."Shipping Agent Code") then begin
            exit(ShippingAgent.GetShippingAgentAPI());
        end else begin
            exit(Enum::"ESNShipping AgentShip"::" ");
        end;
    end;

    procedure IsInternationalShipment() InternationalShipment: Boolean
    var
        ShipmentMgt: Codeunit "ESNShipment Mgt.Ship";
    begin
        InternationalShipment := ShipmentMgt.IsInternationalShipment(Rec);
    end;

    procedure IsEUShipment() EUShipment: Boolean
    var
        ShipmentMgt: Codeunit "ESNShipment Mgt.Ship";
    begin
        EUShipment := ShipmentMgt.IsEUShipment(Rec);
    end;
}