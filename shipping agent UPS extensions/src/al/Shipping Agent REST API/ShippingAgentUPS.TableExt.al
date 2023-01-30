tableextension 70869801 "ESNShipping AgentUPS" extends "Shipping Agent"
{
    fields
    {
        field(70869800; "ESNUPS Dimensions UoMUPS"; Enum "ESNUPS Dimensions UoMUPS")
        {
            Caption = 'Dimensions UoM';
            DataClassification = CustomerContent;
        }
        field(70869801; "ESNAccount NumberUPS"; Code[20])
        {
            Caption = 'UPS Account Number';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate("ESNShipping Agent APIShip", "ESNShipping Agent APIShip"::"UPS REST");
            end;
        }
        field(70869802; "ESNUser NameUPS"; text[80])
        {
            Caption = 'UPS User Name';
            DataClassification = EndUserIdentifiableInformation;
            trigger OnValidate()
            begin
                Validate("ESNShipping Agent APIShip", "ESNShipping Agent APIShip"::"UPS REST");
            end;
        }
        field(70869803; "ESNUser PasswordUPS"; text[30])
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
        field(70869805; "ESNUPS Weight DimensionsUPS"; Enum "ESNUPS Weight Dimensions UPS")
        {
            Caption = 'Weight Dimensions';
            DataClassification = CustomerContent;
        }
        field(70869806; "ESNLabel Image FormatUPS"; Enum "ESNLabel Image FormatUPS")
        {
            Caption = 'Label Image Format';
            DataClassification = CustomerContent;
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
        field(70869810; "ESNTransportation PaymentUPS"; Enum "ESNTransAndDuties PaymentUPS")
        {
            Caption = 'Transportation Payment';
            DataClassification = CustomerContent;
        }
        field(70869811; "ESNTransBillShip Pay TypeUPS"; Enum "ESNTrans. Payment TypeUPS")
        {
            Caption = 'Transportation Payment Type';
            DataClassification = CustomerContent;
        }
        field(70869820; "ESNTransBillShipCredit CardUPS"; enum "ESNCredit Card TypeUPS")
        {
            Caption = 'Credit Card';
            DataClassification = CustomerContent;
        }
        field(70869821; "ESNTransBillShipCard NumberUPS"; Text[50])
        {
            Caption = 'Credit Card Number';
            DataClassification = CustomerContent;
        }
        field(70869822; "ESNTransBillShipCard Exp. UPS"; Date)
        {
            Caption = 'Credit Card Expiration Date';
            DataClassification = CustomerContent;
        }
        field(70869823; "ESNTransBillShipCard Sec. UPS"; Text[4])
        {
            Caption = 'Credit Card Security Code';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }

        field(70869830; "ESNTransBillReceiver AccUPS"; Code[20])
        {
            Caption = 'Bill Receiver Account Number';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(70869831; "ESNTransBillThird AccUPS"; Code[20])
        {
            Caption = 'Bill Third Party Account Number';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(70869840; "ESNDuty PaymentUPS"; Enum "ESNTransAndDuties PaymentUPS")
        {
            Caption = 'Duties and Taxes Payment';
            DataClassification = CustomerContent;
        }
        field(70869841; "ESNDutyBillShip Pay. TypeUPS"; Enum "ESNTrans. Payment TypeUPS")
        {
            Caption = 'Duties and Taxes Payment Type';
            DataClassification = CustomerContent;
        }
        field(70869850; "ESNDutyBillShipCredit CardUPS"; enum "ESNCredit Card TypeUPS")
        {
            Caption = 'Credit Card';
            DataClassification = CustomerContent;
        }
        field(70869851; "ESNDutyBillShipCard NumberUPS"; Text[50])
        {
            Caption = 'Credit Card Number';
            DataClassification = CustomerContent;
        }
        field(70869852; "ESNDutyBillShipCard Exp. UPS"; Date)
        {
            Caption = 'Credit Card Expiration Date';
            DataClassification = CustomerContent;
        }
        field(70869853; "ESNDutyBillShipCard Sec. UPS"; Text[4])
        {
            Caption = 'Credit Card Security Code';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }

        field(70869860; "ESNDutyBillReceiver AccUPS"; Code[20])
        {
            Caption = 'Bill Receiver Account Number';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(70869861; "ESNDutyBillThird AccUPS"; Code[20])
        {
            Caption = 'Bill Third Party Account Number';
            DataClassification = OrganizationIdentifiableInformation;
        }

    }

    procedure IsShippingAgentUPS(): Boolean
    begin
        exit("ESNShipping Agent APIShip" = "ESNShipping Agent APIShip"::"UPS REST");
    end;

    #region "ESNShip. Agent REST VersionUPS" Interface Funtions
    procedure GetShipAgentRESTVerInterface() ShipAgentRESTVerInterface: Interface "ESNShip. Agent REST VersionUPS"
    begin
        ShipAgentRESTVerInterface := "ESNREST VersionUPS";
    end;

    procedure GetVersionString() VersionString: Text
    begin
        VersionString := GetShipAgentRESTVerInterface.GetVersionString(Rec);
    end;
    #endregion


    #region "ESNShipping Agent RESTUPS" Interface Funtions
    procedure GetShipAgentRESTInterface() ShipAgentRESTInterface: Interface "ESNShipping Agent RESTUPS"
    begin
        ShipAgentRESTInterface := "ESNREST VersionUPS";
    end;

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

    #region "ESNShipping Agent APIShip" Interface Functions
    procedure GetESNShippingAgentAPIShipUPS() ESNShippingAgentAPIShipUPS: Interface "ESNShipping Agent APIShip"
    begin
        ESNShippingAgentAPIShipUPS := "ESNREST VersionUPS";
    end;
    #endregion


}