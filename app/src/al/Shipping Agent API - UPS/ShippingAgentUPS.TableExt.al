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
        field(70869788; "ESNREST API EndpointUPS"; Enum "ESNShipping Agent REST URLUPS")
        {
            Caption = 'REST API Endpoint', Comment = 'REST API Endpoint';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ConfirmQuestionLbl: Label 'Do you really want to put the interface into productive operation?', Comment = 'Wollen Sie wirklich die Schnittstelle in produktiven Betrieb nehmen?';
            begin
                if rec."ESNREST API EndpointUPS" <> xRec."ESNREST API EndpointUPS" then begin
                    if "ESNREST API EndpointUPS" = "ESNREST API EndpointUPS"::Production then begin
                        rec.TestField(ESNUPS, true);
                        if not Confirm(ConfirmQuestionLbl, false) then
                            "ESNREST API EndpointUPS" := "ESNREST API EndpointUPS"::Testing;
                    end;
                end;
            end;
        }
        field(70869789; "ESNREST VersionUPS"; Enum "ESNShip. Agent REST Ver.UPS")
        {
            Caption = 'REST Version', Comment = 'REST Version';
            DataClassification = CustomerContent;
            InitValue = "v1";
            trigger OnValidate()
            begin
                GetShippingURL();  // 'Not yet implemented.' check
            end;
        }
    }

    procedure GetShipAgentRESTVerInterface() ShipAgentRESTVerInterface: Interface "ESNShip. Agent REST VersionUPS"
    begin
        ShipAgentRESTVerInterface := "ESNREST VersionUPS";
    end;

    procedure GetShipAgentRESTInterface() ShipAgentRESTInterface: Interface "ESNShipping Agent RESTUPS"
    begin
        ShipAgentRESTInterface := "ESNREST VersionUPS";
    end;

    #region "ESNShip. Agent REST VersionUPS" Interface Funtions
    procedure GetVersionString() VersionString: Text
    begin
        VersionString := GetShipAgentRESTVerInterface.GetVersionString(Rec);
    end;
    #endregion


    #region "ESNShipping Agent RESTUPS" Interface Funtions
    procedure GetShippingURL() ShippingURL: Text
    begin
        ShippingURL := GetShipAgentRESTInterface.GetShippingURL(Rec);
    end;

    procedure GetShippingCancelURL() ShippingCancelURL: Text
    begin
        ShippingCancelURL := GetShipAgentRESTInterface.GetShippingCancelURL(Rec);
    end;

    procedure GetShippingLabelRecoveryURL() ShippingLabelRecoveryURL: Text
    begin
        ShippingLabelRecoveryURL := GetShipAgentRESTInterface.GetShippingLabelRecoveryURL(rec);
    end;
    #endregion
}