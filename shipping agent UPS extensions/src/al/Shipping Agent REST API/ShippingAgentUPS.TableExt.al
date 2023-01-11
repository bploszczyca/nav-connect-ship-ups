tableextension 70869801 "ESNShipping AgentUPS" extends "Shipping Agent"
{
    fields
    {
        field(70869801; "ESNAccount NumberUPS"; Code[20])
        {
            Caption = 'UPS Account Number';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate("ESNShipping Agent APIShip", "ESNShipping Agent APIShip"::"UPS REST");
            end;
        }
        field(70869802; "ESNUser NameUPS"; text[20])
        {
            Caption = 'UPS User Name';
            DataClassification = EndUserIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate("ESNShipping Agent APIShip", "ESNShipping Agent APIShip"::"UPS REST");
            end;
        }
        field(70869803; "ESNUser PasswordUPS"; text[20])
        {
            Caption = 'UPS User Password';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                Validate("ESNShipping Agent APIShip", "ESNShipping Agent APIShip"::"UPS REST");
            end;
        }
        field(70869804; "ESNAccess KeyUPS"; text[50])
        {
            Caption = 'UPS Access Key';
            DataClassification = EndUserIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate("ESNShipping Agent APIShip", "ESNShipping Agent APIShip"::"UPS REST");
            end;
        }

        field(70869808; "ESNREST API EndpointUPS"; Enum "ESNShipping Agent REST URLUPS")
        {
            Caption = 'REST API Endpoint', Comment = 'REST API Endpoint';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ConfirmQuestionLbl: Label 'Do you really want to put the interface into productive operation?', Comment = 'Wollen Sie wirklich die Schnittstelle in produktiven Betrieb nehmen?';
            begin
                if rec."ESNREST API EndpointUPS" <> xRec."ESNREST API EndpointUPS" then begin
                    if "ESNREST API EndpointUPS" = "ESNREST API EndpointUPS"::Production then begin
                        rec.TestField("ESNShipping Agent APIShip", "ESNShipping Agent APIShip"::"UPS REST");
                        if not Confirm(ConfirmQuestionLbl, false) then
                            "ESNREST API EndpointUPS" := "ESNREST API EndpointUPS"::Testing;
                    end;
                end;
            end;
        }
        field(70869809; "ESNREST VersionUPS"; Enum "ESNShip. Agent REST Ver.UPS")
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

    procedure IsShippingAgentUPS(): Boolean
    begin
        exit("ESNShipping Agent APIShip" = "ESNShipping Agent APIShip"::"UPS REST");
    end;

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

    procedure GetShippingURLQueryParameters() ShippingURLQueryParameters: Text;
    begin
        ShippingURLQueryParameters := GetShipAgentRESTInterface.GetShippingURLQueryParameters(Rec);
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