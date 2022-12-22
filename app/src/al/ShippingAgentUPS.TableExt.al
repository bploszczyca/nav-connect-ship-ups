tableextension 70869780 "ESNShipping AgentUPS" extends "Shipping Agent"
{
    fields
    {
        field(70869780; ESNUPS; Boolean)
        {
            Caption = 'UPS';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ESNUPS then begin
                    TestField("ESNAccount NumberUPS");
                    TestField("ESNUser NameUPS");
                    TestField("ESNUser PasswordUPS");
                    TestField("ESNAccess KeyUPS");
                end;
            end;
        }
        field(70869781; "ESNAccount NumberUPS"; Code[20])
        {
            Caption = 'UPS Account Number';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate(ESNUPS);
            end;
        }
        field(70869782; "ESNUser NameUPS"; text[20])
        {
            Caption = 'UPS User Name';
            DataClassification = EndUserIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate(ESNUPS);
            end;
        }
        field(70869783; "ESNUser PasswordUPS"; text[20])
        {
            Caption = 'UPS User Password';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                Validate(ESNUPS);
            end;
        }
        field(70869784; "ESNAccess KeyUPS"; text[50])
        {
            Caption = 'UPS Access Key';
            DataClassification = EndUserIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate(ESNUPS);
            end;
        }
        field(70869785; "ESNDefault ServiceUPS"; Code[10])
        {
            Caption = 'Default Service';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field(Code));
        }
        field(70869786; "ESNDefault Ship-from TypeUPS"; Enum "ESNPackageShipFromTypeUPS")
        {
            Caption = 'Default Ship-from Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "ESNDefault Ship-from TypeUPS" <> xRec."ESNDefault Ship-from TypeUPS" then begin
                    Validate("ESNDef. Ship-from ContactUPS", '');
                end;
            end;
        }
        field(70869787; "ESNDef. Ship-from ContactUPS"; Code[20])
        {
            Caption = 'Default Ship-from Contact';
            DataClassification = CustomerContent;
            TableRelation = if ("ESNDefault Ship-from TypeUPS" = const(Contact)) Contact."No.";

            trigger OnValidate()
            begin
                if ("ESNDef. Ship-from ContactUPS" <> '') then begin
                    TestField("ESNDefault Ship-from TypeUPS", "ESNDefault Ship-from TypeUPS"::Contact);
                end;
            end;
        }
    }
}