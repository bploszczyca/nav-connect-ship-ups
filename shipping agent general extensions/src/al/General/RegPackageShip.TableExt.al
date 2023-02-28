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
            Editable = false;
        }
        field(70869753; "ESNCost  IdentifierShip"; Code[20])
        {
            Caption = 'Cost  Identifier';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869754; "ESNSaturday Delivery Req.Ship"; Boolean)
        {
            Caption = 'Saturday Delivery Requested';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869755; "ESNSaturday Pickup Req.Ship"; Boolean)
        {
            Caption = 'Saturday Pickup Requested';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869756; "ESNDirect Delivery OnlyShip"; Boolean)
        {
            Caption = 'Direct Delivery Only (DDO)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869757; ESN70869757Ship; Boolean) { }
        field(70869758; ESN70869758Ship; Boolean) { }
        field(70869759; ESN70869759Ship; Boolean) { }
        field(70869760; "ESNShip-from TypeShip"; Enum "ESNPackageShipFromTypeShip")
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Type';
            Editable = false;
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
            Editable = false;
        }
        field(70869762; "ESNShip-from CodeShip"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Code';
            TableRelation = IF ("ESNShip-from TypeShip" = CONST(Contact)) "Contact Alt. Address".Code WHERE("Contact No." = FIELD("ESNShip-from No.Ship"));
            Editable = false;
        }
        field(70869763; "ESNShip-from NameShip"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Name';
            Editable = false;
        }
        field(70869764; "ESNShip-from Name 2Ship"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Name 2';
            Editable = false;
        }
        field(70869765; "ESNShip-from AddressShip"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Address';
            Editable = false;
        }
        field(70869766; "ESNShip-from Address 2Ship"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Address 2';
            Editable = false;
        }
        field(70869767; "ESNShip-from CityShip"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from City';
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
            Editable = false;
        }
        field(70869768; "ESNShip-from ContactShip"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Contact';
            Editable = false;
        }
        field(70869769; "ESNShip-from Post CodeShip"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            Editable = false;
        }
        field(70869770; "ESNShip-from CountyShip"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from County';
            Editable = false;
        }
        field(70869771; "ESNShip-from Coun/Reg CodeShip"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Country/Region Code';
            TableRelation = "Country/Region";
            Editable = false;
        }
        field(70869772; "ESNNotification To EmailShip"; Text[80])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            Editable = false;
        }
        field(70869773; "ESNUndeli. Not. EmailShip"; Text[80])
        {
            Caption = 'Undeliverable Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            Editable = false;
        }
        field(70869774; "ESNNotification From EmailShip"; Text[80])
        {
            Caption = 'From Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            Editable = false;
        }
        field(70869775; "ESNNotification From NameShip"; Text[80])
        {
            Caption = 'From Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869776; "ESNNotification Email-TextShip"; Text[150])
        {
            Caption = 'Email-Text';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869777; "ESNVoice Noti. Phone No.Ship"; Text[30])
        {
            Caption = 'Voice Noti. Phone No.';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869778; "ESNText Noti. Phone No.Ship"; Text[30])
        {
            Caption = 'Text Noti. Phone No.';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869779; "ESNDCIS TypeShip"; Enum "ESNDCIS TypeShip")
        {
            Caption = 'Delivery Confirm. Signature Required';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869780; "ESNADR Emerg. Phone No.Ship"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipper ADR Emergency Phone No.', Comment = 'Versender Gefahrgut Notfall Tel. Nr.';
            ExtendedDatatype = PhoneNo;
        }
        field(70869781; "ESNRegulation SetShip"; Enum "ESNRegulation SetShip")
        {
            Caption = 'Regulation Set';
            DataClassification = CustomerContent;
        }
        field(70869782; "ESNTransportation ModeShip"; Enum "ESNTransportation ModeShip")
        {
            Caption = 'Transportation Mode', Comment = 'Beförderungsverfahren';
            DataClassification = CustomerContent;
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