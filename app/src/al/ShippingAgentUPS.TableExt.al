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
    }
}