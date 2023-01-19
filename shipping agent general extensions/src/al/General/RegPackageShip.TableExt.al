tableextension 70869751 "ESNReg. PackageShip" extends "ETI-Reg. Package-NC"
{
    fields
    {
        // Add changes to table fields here
        field(70869750; "ESNShipment No.Ship"; Code[20])
        {
            Caption = 'Shipment No.', Comment = 'Versandauftragsnr.';
            DataClassification = CustomerContent;
        }
        field(70869751; "ESNPackage CoutShip"; Integer)
        {
            Caption = 'Package Cout', Comment = 'Anzahl Pakete';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("ETI-Package-NC" where("ESNShipment No.Ship" = field("ESNShipment No.Ship")));
        }
        field(70869752; "ESNShipment DescriptionShip"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Description';
        }
        field(70869753; "ESNCost  IdentifierShip"; Code[20])
        {
            Caption = 'Cost  Identifier';
            DataClassification = CustomerContent;
        }
        field(70869754; "ESNSaturday Delivery Req.Ship"; Boolean)
        {
            Caption = 'Saturday Delivery Requested';
            DataClassification = CustomerContent;
        }
        field(70869755; "ESNSaturday Pickup Req.Ship"; Boolean)
        {
            Caption = 'Saturday Pickup Requested';
            DataClassification = CustomerContent;
        }
        field(70869756; "ESNDirect Delivery OnlyShip"; Boolean)
        {
            Caption = 'Direct Delivery Only (DDO)';
            DataClassification = CustomerContent;
        }
        field(70869757; "70869757"; Boolean) { }
        field(70869758; "70869758"; Boolean) { }
        field(70869759; "70869759"; Boolean) { }

        // field(70869800)


        field(70869760; "ESNShip-from TypeShip"; Enum "ESNPackageShipFromTypeShip")
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Type';
        }
        field(70869761; "ESNShip-from No.Ship"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from No.';
            TableRelation = IF ("ESNShip-from TypeShip" = CONST(Contact)) Contact
            ELSE
            IF ("ESNShip-from TypeShip" = CONST("Responsibility Center")) "Responsibility Center"
            ELSE
            IF ("ESNShip-from TypeShip" = CONST(Location)) Location;
        }
        field(70869762; "ESNShip-from CodeShip"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Code';
            TableRelation = IF ("ESNShip-from TypeShip" = CONST(Contact)) "Contact Alt. Address".Code WHERE("Contact No." = FIELD("ESNShip-from No.Ship"));
        }
        field(70869763; "ESNShip-from NameShip"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Name';
        }
        field(70869764; "ESNShip-from Name 2Ship"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Name 2';
        }
        field(70869765; "ESNShip-from AddressShip"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Address';
        }
        field(70869766; "ESNShip-from Address 2Ship"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Address 2';
        }
        field(70869767; "ESNShip-from CityShip"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from City';
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(70869768; "ESNShip-from ContactShip"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Contact';
        }
        field(70869769; "ESNShip-from Post CodeShip"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(70869770; "ESNShip-from CountyShip"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from County';
        }
        field(70869771; "ESNShip-from Coun/Reg CodeShip"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Country/Region Code';
            TableRelation = "Country/Region";
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