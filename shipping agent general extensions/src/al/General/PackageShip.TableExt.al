tableextension 70869750 "ESNPackageShip" extends "ETI-Package-NC"
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
        field(70869757; ESN70869757Ship; Boolean) { }
        field(70869758; ESN70869758Ship; Boolean) { }
        field(70869759; ESN70869759Ship; Boolean) { }
        field(70869760; "ESNShip-from TypeShip"; Enum "ESNPackageShipFromTypeShip")
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Type';

            trigger OnValidate()
            begin
                IF "ESNShip-from TypeShip" <> xRec."ESNShip-from TypeShip" THEN BEGIN
                    VALIDATE("ESNShip-from No.Ship", '');
                    OnValidateShipFromNo;
                END;
            end;
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

            trigger OnValidate()
            begin
                IF "ESNShip-from No.Ship" <> xRec."ESNShip-from No.Ship" THEN BEGIN
                    OnValidateShipFromNo;
                END;
            end;
        }
        field(70869762; "ESNShip-from CodeShip"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Code';
            TableRelation = IF ("ESNShip-from TypeShip" = CONST(Contact)) "Contact Alt. Address".Code WHERE("Contact No." = FIELD("ESNShip-from No.Ship"));

            trigger OnValidate()
            begin
                IF "ESNShip-from CodeShip" <> xRec."ESNShip-from CodeShip" THEN BEGIN
                    IF "ESNShip-from CodeShip" <> '' THEN BEGIN
                        OnValidateShipFromCode;
                    END ELSE BEGIN
                        OnValidateShipFromNo;
                    END;
                END;
            end;
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
        field(70869772; "ESNNotification To EmailShip"; Text[80])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "ESNNotification To EmailShip" <> '' then
                    MailManagement.CheckValidEmailAddresses("ESNNotification To EmailShip")
            end;
        }
        field(70869773; "ESNUndeli. Not. EmailShip"; Text[80])
        {
            Caption = 'Undeliverable Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "ESNUndeli. Not. EmailShip" <> '' then
                    MailManagement.CheckValidEmailAddresses("ESNUndeli. Not. EmailShip")
            end;
        }
        field(70869774; "ESNNotification From EmailShip"; Text[80])
        {
            Caption = 'From Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "ESNNotification From EmailShip" <> '' then
                    MailManagement.CheckValidEmailAddresses("ESNNotification From EmailShip")
            end;
        }
        field(70869775; "ESNNotification From NameShip"; Text[80])
        {
            Caption = 'From Name';
            DataClassification = CustomerContent;
        }
        field(70869776; "ESNNotification Email-TextShip"; Text[150])
        {
            Caption = 'Email-Text';
            DataClassification = CustomerContent;
        }
        field(70869777; "ESNVoice Noti. Phone No.Ship"; Text[30])
        {
            Caption = 'Voice Noti. Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(70869778; "ESNText Noti. Phone No.Ship"; Text[30])
        {
            Caption = 'Text Noti. Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(70869779; "ESNDCIS TypeShip"; Enum "ESNDCIS TypeShip")
        {
            Caption = 'Delivery Confirm. Signature Required';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(ShipmentNo; "ESNShipment No.Ship") { }
    }

    trigger OnAfterInsert()
    begin
        if "ESNShipment No.Ship" = '' then begin
            if GetFilter("ESNShipment No.Ship") = '' then begin
                "ESNShipment No.Ship" := "No.";
            end else begin
                "ESNShipment No.Ship" := GetRangeMax("ESNShipment No.Ship");
            end;
            Modify(true);
        end;
    end;

    trigger OnBeforeModify()
    begin
        CheckAddressChagend();
    end;

    trigger OnAfterModify()
    begin
        SyncShipmentDescription();
        SyncShipFromAddress();
        SyncShipNotification();
    end;

    local procedure OnValidateShipFromNo()
    var
        Contact: Record "Contact";
        CompanyInformation: Record "Company Information";
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record "Location";
    begin
        validate("ESNShip-from CodeShip", '');
        validate("ESNShip-from NameShip", '');
        validate("ESNShip-from Name 2Ship", '');
        validate("ESNShip-from AddressShip", '');
        validate("ESNShip-from Address 2Ship", '');
        validate("ESNShip-from CityShip", '');
        validate("ESNShip-from ContactShip", '');
        validate("ESNShip-from Post CodeShip", '');
        validate("ESNShip-from CountyShip", '');
        validate("ESNShip-from Coun/Reg CodeShip", '');
        CASE "ESNShip-from TypeShip" OF
            "ESNShip-from TypeShip"::Contact:
                BEGIN
                    IF Contact.GET("ESNShip-from No.Ship") THEN BEGIN
                        validate("ESNShip-from NameShip", Contact.Name);
                        validate("ESNShip-from Name 2Ship", Contact."Name 2");
                        validate("ESNShip-from AddressShip", Contact.Address);
                        validate("ESNShip-from Address 2Ship", Contact."Address 2");
                        validate("ESNShip-from CityShip", Contact.City);
                        validate("ESNShip-from Post CodeShip", Contact."Post Code");
                        validate("ESNShip-from CountyShip", Contact.County);
                        validate("ESNShip-from Coun/Reg CodeShip", Contact."Country/Region Code");
                    END;
                END;
            "ESNShip-from TypeShip"::"Company Information":
                BEGIN
                    IF CompanyInformation.GET() THEN BEGIN
                        validate("ESNShip-from NameShip", CompanyInformation.Name);
                        validate("ESNShip-from Name 2Ship", CompanyInformation."Name 2");
                        validate("ESNShip-from AddressShip", CompanyInformation.Address);
                        validate("ESNShip-from Address 2Ship", CompanyInformation."Address 2");
                        validate("ESNShip-from CityShip", CompanyInformation.City);
                        validate("ESNShip-from ContactShip", CompanyInformation."Contact Person");
                        validate("ESNShip-from Post CodeShip", CompanyInformation."Post Code");
                        validate("ESNShip-from CountyShip", CompanyInformation.County);
                        validate("ESNShip-from Coun/Reg CodeShip", CompanyInformation."Country/Region Code");
                    END;
                END;
            "ESNShip-from TypeShip"::"Responsibility Center":
                BEGIN
                    IF ResponsibilityCenter.GET("ESNShip-from No.Ship") THEN BEGIN
                        validate("ESNShip-from NameShip", ResponsibilityCenter.Name);
                        validate("ESNShip-from Name 2Ship", ResponsibilityCenter."Name 2");
                        validate("ESNShip-from AddressShip", ResponsibilityCenter.Address);
                        validate("ESNShip-from Address 2Ship", ResponsibilityCenter."Address 2");
                        validate("ESNShip-from CityShip", ResponsibilityCenter.City);
                        validate("ESNShip-from ContactShip", ResponsibilityCenter.Contact);
                        validate("ESNShip-from Post CodeShip", ResponsibilityCenter."Post Code");
                        validate("ESNShip-from CountyShip", ResponsibilityCenter.County);
                        validate("ESNShip-from Coun/Reg CodeShip", ResponsibilityCenter."Country/Region Code");
                    END;
                END;
            "ESNShip-from TypeShip"::Location:
                BEGIN
                    IF Location.GET("ESNShip-from No.Ship") THEN BEGIN
                        validate("ESNShip-from NameShip", Location.Name);
                        validate("ESNShip-from Name 2Ship", Location."Name 2");
                        validate("ESNShip-from AddressShip", Location.Address);
                        validate("ESNShip-from Address 2Ship", Location."Address 2");
                        validate("ESNShip-from CityShip", Location.City);
                        validate("ESNShip-from ContactShip", Location.Contact);
                        validate("ESNShip-from Post CodeShip", Location."Post Code");
                        validate("ESNShip-from CountyShip", Location.County);
                        validate("ESNShip-from Coun/Reg CodeShip", Location."Country/Region Code");
                    END;
                END;
        END;
    end;


    local procedure OnValidateShipFromCode()
    var
        ContactAltAddress: Record "Contact Alt. Address";
    begin
        validate("ESNShip-from NameShip", '');
        validate("ESNShip-from Name 2Ship", '');
        validate("ESNShip-from AddressShip", '');
        validate("ESNShip-from Address 2Ship", '');
        validate("ESNShip-from CityShip", '');
        validate("ESNShip-from ContactShip", '');
        validate("ESNShip-from Post CodeShip", '');
        validate("ESNShip-from CountyShip", '');
        validate("ESNShip-from Coun/Reg CodeShip", '');
        CASE "ESNShip-from TypeShip" OF
            "ESNShip-from TypeShip"::Contact:
                BEGIN
                    IF ContactAltAddress.GET("ESNShip-from No.Ship", "ESNShip-from CodeShip") THEN BEGIN
                        validate("ESNShip-from NameShip", ContactAltAddress."Company Name");
                        validate("ESNShip-from Name 2Ship", ContactAltAddress."Company Name 2");
                        validate("ESNShip-from AddressShip", ContactAltAddress.Address);
                        validate("ESNShip-from Address 2Ship", ContactAltAddress."Address 2");
                        validate("ESNShip-from CityShip", ContactAltAddress.City);
                        validate("ESNShip-from Post CodeShip", ContactAltAddress."Post Code");
                        validate("ESNShip-from CountyShip", ContactAltAddress.County);
                        validate("ESNShip-from Coun/Reg CodeShip", ContactAltAddress."Country/Region Code");
                    END;
                END;
        END;
    end;

    local procedure SyncShipmentDescription()
    var
        Package: Record "ETI-Package-NC";
    begin
        Package.SetRange("ESNShipment No.Ship", rec."ESNShipment No.Ship");
        Package.SetFilter("No.", '<>%1', rec."No.");
        if not Package.IsEmpty then
            if Package.Find('-') then
                repeat
                    if Package."ESNShipment DescriptionShip" <> rec."ESNShipment DescriptionShip" then begin
                        Package.Validate("ESNShipment DescriptionShip", rec."ESNShipment DescriptionShip");
                        Package.Modify();
                    end;
                until Package.Next() = 0;
    end;

    local procedure SyncShipFromAddress()
    var
        Package: Record "ETI-Package-NC";
    begin
        Package.SetRange("ESNShipment No.Ship", rec."ESNShipment No.Ship");
        Package.SetFilter("No.", '<>%1', rec."No.");
        if not Package.IsEmpty then
            if Package.Find('-') then
                repeat
                    if IsShipFromAddresDifferent(rec, Package) then begin
                        TransferShipFromAddresFields(rec, Package);
                        Package.Modify;
                    end;
                until Package.Next() = 0;
    end;

    local procedure SyncShipNotification()
    var
        Package: Record "ETI-Package-NC";
        ModifyPackage: Boolean;
    begin
        Package.SetRange("ESNShipment No.Ship", rec."ESNShipment No.Ship");
        Package.SetFilter("No.", '<>%1', rec."No.");
        if not Package.IsEmpty then
            if Package.Find('-') then
                repeat
                    ModifyPackage := false;
                    if Package."ESNNotification To EmailShip" <> rec."ESNNotification To EmailShip" then begin
                        Package.Validate("ESNNotification To EmailShip", rec."ESNNotification To EmailShip");
                        ModifyPackage := true;
                    end;
                    if Package."ESNUndeli. Not. EmailShip" <> rec."ESNUndeli. Not. EmailShip" then begin
                        Package.Validate("ESNUndeli. Not. EmailShip", rec."ESNUndeli. Not. EmailShip");
                        ModifyPackage := true;
                    end;
                    if Package."ESNNotification From EmailShip" <> rec."ESNNotification From EmailShip" then begin
                        Package.Validate("ESNNotification From EmailShip", rec."ESNNotification From EmailShip");
                        ModifyPackage := true;
                    end;
                    if Package."ESNNotification From NameShip" <> rec."ESNNotification From NameShip" then begin
                        Package.Validate("ESNNotification From NameShip", rec."ESNNotification From NameShip");
                        ModifyPackage := true;
                    end;
                    if Package."ESNNotification Email-TextShip" <> rec."ESNNotification Email-TextShip" then begin
                        Package.Validate("ESNNotification Email-TextShip", rec."ESNNotification Email-TextShip");
                        ModifyPackage := true;
                    end;
                    if Package."ESNVoice Noti. Phone No.Ship" <> rec."ESNVoice Noti. Phone No.Ship" then begin
                        Package.Validate("ESNVoice Noti. Phone No.Ship", rec."ESNVoice Noti. Phone No.Ship");
                        ModifyPackage := true;
                    end;
                    if Package."ESNText Noti. Phone No.Ship" <> rec."ESNText Noti. Phone No.Ship" then begin
                        Package.Validate("ESNText Noti. Phone No.Ship", rec."ESNText Noti. Phone No.Ship");
                        ModifyPackage := true;
                    end;
                    if ModifyPackage then
                        Package.Modify();
                until Package.Next() = 0;
    end;

    local procedure IsShipFromAddresDifferent(Package: Record "ETI-Package-NC"; Package2: Record "ETI-Package-NC") ShipFromAddresIsDifferent: Boolean
    begin
        ShipFromAddresIsDifferent := not (
            (Package."ESNShip-from TypeShip" = Package2."ESNShip-from TypeShip") AND
            (Package."ESNShip-from No.Ship" = Package2."ESNShip-from No.Ship") AND
            (Package."ESNShip-from CodeShip" = Package2."ESNShip-from CodeShip") AND
            (Package."ESNShip-from NameShip" = Package2."ESNShip-from NameShip") AND
            (Package."ESNShip-from Name 2Ship" = Package2."ESNShip-from Name 2Ship") AND
            (Package."ESNShip-from AddressShip" = Package2."ESNShip-from AddressShip") AND
            (Package."ESNShip-from Address 2Ship" = Package2."ESNShip-from Address 2Ship") AND
            (Package."ESNShip-from CityShip" = Package2."ESNShip-from CityShip") AND
            (Package."ESNShip-from ContactShip" = Package2."ESNShip-from ContactShip") AND
            (Package."ESNShip-from Post CodeShip" = Package2."ESNShip-from Post CodeShip") AND
            (Package."ESNShip-from CountyShip" = Package2."ESNShip-from CountyShip") AND
            (Package."ESNShip-from Coun/Reg CodeShip" = Package2."ESNShip-from Coun/Reg CodeShip")
        );
        exit(ShipFromAddresIsDifferent);
    end;

    local procedure TransferShipFromAddresFields(FromPackage: Record "ETI-Package-NC"; var ToPackage: Record "ETI-Package-NC")
    begin
        ToPackage."ESNShip-from TypeShip" := FromPackage."ESNShip-from TypeShip";
        ToPackage."ESNShip-from No.Ship" := FromPackage."ESNShip-from No.Ship";
        ToPackage."ESNShip-from CodeShip" := FromPackage."ESNShip-from CodeShip";
        ToPackage."ESNShip-from NameShip" := FromPackage."ESNShip-from NameShip";
        ToPackage."ESNShip-from Name 2Ship" := FromPackage."ESNShip-from Name 2Ship";
        ToPackage."ESNShip-from AddressShip" := FromPackage."ESNShip-from AddressShip";
        ToPackage."ESNShip-from Address 2Ship" := FromPackage."ESNShip-from Address 2Ship";
        ToPackage."ESNShip-from CityShip" := FromPackage."ESNShip-from CityShip";
        ToPackage."ESNShip-from ContactShip" := FromPackage."ESNShip-from ContactShip";
        ToPackage."ESNShip-from Post CodeShip" := FromPackage."ESNShip-from Post CodeShip";
        ToPackage."ESNShip-from CountyShip" := FromPackage."ESNShip-from CountyShip";
        ToPackage."ESNShip-from Coun/Reg CodeShip" := FromPackage."ESNShip-from Coun/Reg CodeShip";
    end;


    local procedure CheckAddressChagend()
    var
        Package: Record "ETI-Package-NC";
        PackageMgt: Codeunit "ETI-Package Mgt-NC";
        MustHaveSameAddressLbl: Label 'Packages of a shipping order %1 must have the same address.';
    begin
        Package.SetRange("ESNShipment No.Ship", rec."ESNShipment No.Ship");
        Package.SetFilter("No.", '<>%1', rec."No.");
        if not Package.IsEmpty then
            if Package.Find('-') then
                repeat
                    case true of
                        PackageAddressNotSet(rec) and PackageAddressNotSet(Package):
                            begin
                                // Nothing to do
                            end;
                        not PackageAddressNotSet(rec) and PackageAddressNotSet(Package):
                            begin
                                TransferPackageAddressFields(Rec, Package);
                                Package.Modify;
                            end;
                        else begin
                            if PackageMgt.HasPackageAddressChanged(rec, Package) then begin
                                Error(MustHaveSameAddressLbl, rec."ESNShipment No.Ship");
                            end;
                        end;
                    end;
                until Package.Next() = 0;
    end;

    procedure PackageAddressNotSet(Package: Record "ETI-Package-NC") AddressNotSet: Boolean
    begin
        AddressNotSet :=
           (Package."Ship-to Type" = Package."Ship-to Type"::" ") and
           (Package."Ship-to No." = '') and
           (Package."Ship-to Code" = '') and
           (Package."Ship-to Name" = '') and
           (Package."Ship-to Name 2" = '') and
           (Package."Ship-to Address" = '') and
           (Package."Ship-to Address 2" = '') and
           (Package."Ship-to City" = '') and
           (Package."Ship-to Contact" = '') and
           (Package."Ship-to Post Code" = '') and
           (Package."Ship-to County" = '') and
           (Package."Ship-to Country/Region Code" = '');
        EXIT(AddressNotSet);
    end;

    local procedure TransferPackageAddressFields(FromPackage: Record "ETI-Package-NC"; var ToPackage: Record "ETI-Package-NC")
    begin
        ToPackage."Ship-to Type" := FromPackage."Ship-to Type";
        ToPackage."Ship-to No." := FromPackage."Ship-to No.";
        ToPackage."Ship-to Code" := FromPackage."Ship-to Code";
        ToPackage."Ship-to Name" := FromPackage."Ship-to Name";
        ToPackage."Ship-to Name 2" := FromPackage."Ship-to Name 2";
        ToPackage."Ship-to Address" := FromPackage."Ship-to Address";
        ToPackage."Ship-to Address 2" := FromPackage."Ship-to Address 2";
        ToPackage."Ship-to City" := FromPackage."Ship-to City";
        ToPackage."Ship-to Contact" := FromPackage."Ship-to Contact";
        ToPackage."Ship-to Post Code" := FromPackage."Ship-to Post Code";
        ToPackage."Ship-to County" := FromPackage."Ship-to County";
        ToPackage."Ship-to Country/Region Code" := FromPackage."Ship-to Country/Region Code";
    end;

    procedure GetShippingAgentAPI(): Interface "ESNShipping Agent APIShip"
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if GetShippingAgent(ShippingAgent) then begin
            exit(ShippingAgent.GetShippingAgentAPI());
        end else begin
            exit(Enum::"ESNShipping AgentShip"::" ");
        end;
    end;

    procedure GetShippingAgent(var ShippingAgent: Record "Shipping Agent"): Boolean
    begin
        exit(ShippingAgent.get(Rec."Shipping Agent Code"));
    end;

    procedure GetShippingAgent() ShippingAgent: Record "Shipping Agent"
    begin
        ShippingAgent.get(Rec."Shipping Agent Code");
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