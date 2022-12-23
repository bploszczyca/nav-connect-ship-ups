tableextension 70869782 "ESNPackageUPS" extends "ETI-Package-NC"
{
    fields
    {
        // Add changes to table fields here
        field(70869780; "ESNShipment No.UPS"; Code[20])
        {
            Caption = 'Shipment No.', Comment = 'Versandauftragsnr.';
            DataClassification = CustomerContent;
        }
        field(70869781; "ESNPackage CoutUPS"; Integer)
        {
            Caption = 'Package Cout', Comment = 'Anzahl Pakete';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("ETI-Package-NC" where("ESNShipment No.UPS" = field("ESNShipment No.UPS")));
        }


        field(70869790; "ESNShip-from TypeUPS"; Enum "ESNPackageShipFromTypeUPS")
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Type';

            trigger OnValidate()
            begin
                IF "ESNShip-from TypeUPS" <> xRec."ESNShip-from TypeUPS" THEN BEGIN
                    VALIDATE("ESNShip-from No.UPS", '');
                    OnValidateShipFromNo;
                END;
            end;
        }
        field(70869791; "ESNShip-from No.UPS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from No.';
            TableRelation = IF ("ESNShip-from TypeUPS" = CONST(Contact)) Contact
            ELSE
            IF ("ESNShip-from TypeUPS" = CONST("Responsibility Center")) "Responsibility Center"
            ELSE
            IF ("ESNShip-from TypeUPS" = CONST(Location)) Location;

            trigger OnValidate()
            begin
                IF "ESNShip-from No.UPS" <> xRec."ESNShip-from No.UPS" THEN BEGIN
                    OnValidateShipFromNo;
                END;
            end;
        }
        field(70869792; "ESNShip-from CodeUPS"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Code';
            TableRelation = IF ("ESNShip-from TypeUPS" = CONST(Contact)) "Contact Alt. Address".Code WHERE("Contact No." = FIELD("ESNShip-from No.UPS"));

            trigger OnValidate()
            begin
                IF "ESNShip-from CodeUPS" <> xRec."ESNShip-from CodeUPS" THEN BEGIN
                    IF "ESNShip-from CodeUPS" <> '' THEN BEGIN
                        OnValidateShipFromCode;
                    END ELSE BEGIN
                        OnValidateShipFromNo;
                    END;
                END;
            end;
        }
        field(70869793; "ESNShip-from NameUPS"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Name';
        }
        field(70869794; "ESNShip-from Name 2UPS"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Name 2';
        }
        field(70869795; "ESNShip-from AddressUPS"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Address';
        }
        field(70869796; "ESNShip-from Address 2UPS"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Address 2';
        }
        field(70869797; "ESNShip-from CityUPS"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from City';
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(70869798; "ESNShip-from ContactUPS"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Contact';
        }
        field(70869799; "ESNShip-from Post CodeUPS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(7086980; "ESNShip-from CountyUPS"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from County';
        }
        field(7086981; "ESNShip-from Coun/Reg CodeUPS"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-from Country/Region Code';
            TableRelation = "Country/Region";
        }

    }
    keys
    {
        key(ShipmentNo; "ESNShipment No.UPS") { }
    }

    trigger OnAfterInsert()
    begin
        if "ESNShipment No.UPS" = '' then begin
            if GetFilter("ESNShipment No.UPS") = '' then begin
                "ESNShipment No.UPS" := "No.";
            end else begin
                "ESNShipment No.UPS" := GetRangeMax("ESNShipment No.UPS");
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
        SyncShipFromAddress();
    end;

    local procedure OnValidateShipFromNo()
    var
        Contact: Record "Contact";
        CompanyInformation: Record "Company Information";
        ResponsibilityCenter: Record "Responsibility Center";
        Location: Record "Location";
    begin
        validate("ESNShip-from CodeUPS", '');
        validate("ESNShip-from NameUPS", '');
        validate("ESNShip-from Name 2UPS", '');
        validate("ESNShip-from AddressUPS", '');
        validate("ESNShip-from Address 2UPS", '');
        validate("ESNShip-from CityUPS", '');
        validate("ESNShip-from ContactUPS", '');
        validate("ESNShip-from Post CodeUPS", '');
        validate("ESNShip-from CountyUPS", '');
        validate("ESNShip-from Coun/Reg CodeUPS", '');
        CASE "ESNShip-from TypeUPS" OF
            "ESNShip-from TypeUPS"::Contact:
                BEGIN
                    IF Contact.GET("ESNShip-from No.UPS") THEN BEGIN
                        validate("ESNShip-from NameUPS", Contact.Name);
                        validate("ESNShip-from Name 2UPS", Contact."Name 2");
                        validate("ESNShip-from AddressUPS", Contact.Address);
                        validate("ESNShip-from Address 2UPS", Contact."Address 2");
                        validate("ESNShip-from CityUPS", Contact.City);
                        validate("ESNShip-from Post CodeUPS", Contact."Post Code");
                        validate("ESNShip-from CountyUPS", Contact.County);
                        validate("ESNShip-from Coun/Reg CodeUPS", Contact."Country/Region Code");
                    END;
                END;
            "ESNShip-from TypeUPS"::"Company Information":
                BEGIN
                    IF CompanyInformation.GET() THEN BEGIN
                        validate("ESNShip-from NameUPS", CompanyInformation.Name);
                        validate("ESNShip-from Name 2UPS", CompanyInformation."Name 2");
                        validate("ESNShip-from AddressUPS", CompanyInformation.Address);
                        validate("ESNShip-from Address 2UPS", CompanyInformation."Address 2");
                        validate("ESNShip-from CityUPS", CompanyInformation.City);
                        validate("ESNShip-from ContactUPS", CompanyInformation."Contact Person");
                        validate("ESNShip-from Post CodeUPS", CompanyInformation."Post Code");
                        validate("ESNShip-from CountyUPS", CompanyInformation.County);
                        validate("ESNShip-from Coun/Reg CodeUPS", CompanyInformation."Country/Region Code");
                    END;
                END;
            "ESNShip-from TypeUPS"::"Responsibility Center":
                BEGIN
                    IF ResponsibilityCenter.GET("ESNShip-from No.UPS") THEN BEGIN
                        validate("ESNShip-from NameUPS", ResponsibilityCenter.Name);
                        validate("ESNShip-from Name 2UPS", ResponsibilityCenter."Name 2");
                        validate("ESNShip-from AddressUPS", ResponsibilityCenter.Address);
                        validate("ESNShip-from Address 2UPS", ResponsibilityCenter."Address 2");
                        validate("ESNShip-from CityUPS", ResponsibilityCenter.City);
                        validate("ESNShip-from ContactUPS", ResponsibilityCenter.Contact);
                        validate("ESNShip-from Post CodeUPS", ResponsibilityCenter."Post Code");
                        validate("ESNShip-from CountyUPS", ResponsibilityCenter.County);
                        validate("ESNShip-from Coun/Reg CodeUPS", ResponsibilityCenter."Country/Region Code");
                    END;
                END;
            "ESNShip-from TypeUPS"::Location:
                BEGIN
                    IF Location.GET("ESNShip-from No.UPS") THEN BEGIN
                        validate("ESNShip-from NameUPS", Location.Name);
                        validate("ESNShip-from Name 2UPS", Location."Name 2");
                        validate("ESNShip-from AddressUPS", Location.Address);
                        validate("ESNShip-from Address 2UPS", Location."Address 2");
                        validate("ESNShip-from CityUPS", Location.City);
                        validate("ESNShip-from ContactUPS", Location.Contact);
                        validate("ESNShip-from Post CodeUPS", Location."Post Code");
                        validate("ESNShip-from CountyUPS", Location.County);
                        validate("ESNShip-from Coun/Reg CodeUPS", Location."Country/Region Code");
                    END;
                END;
        END;
    end;


    local procedure OnValidateShipFromCode()
    var
        ContactAltAddress: Record "Contact Alt. Address";
    begin
        validate("ESNShip-from NameUPS", '');
        validate("ESNShip-from Name 2UPS", '');
        validate("ESNShip-from AddressUPS", '');
        validate("ESNShip-from Address 2UPS", '');
        validate("ESNShip-from CityUPS", '');
        validate("ESNShip-from ContactUPS", '');
        validate("ESNShip-from Post CodeUPS", '');
        validate("ESNShip-from CountyUPS", '');
        validate("ESNShip-from Coun/Reg CodeUPS", '');
        CASE "ESNShip-from TypeUPS" OF
            "ESNShip-from TypeUPS"::Contact:
                BEGIN
                    IF ContactAltAddress.GET("ESNShip-from No.UPS", "ESNShip-from CodeUPS") THEN BEGIN
                        validate("ESNShip-from NameUPS", ContactAltAddress."Company Name");
                        validate("ESNShip-from Name 2UPS", ContactAltAddress."Company Name 2");
                        validate("ESNShip-from AddressUPS", ContactAltAddress.Address);
                        validate("ESNShip-from Address 2UPS", ContactAltAddress."Address 2");
                        validate("ESNShip-from CityUPS", ContactAltAddress.City);
                        validate("ESNShip-from Post CodeUPS", ContactAltAddress."Post Code");
                        validate("ESNShip-from CountyUPS", ContactAltAddress.County);
                        validate("ESNShip-from Coun/Reg CodeUPS", ContactAltAddress."Country/Region Code");
                    END;
                END;
        END;
    end;

    local procedure SyncShipFromAddress()
    var
        Package: Record "ETI-Package-NC";
    begin
        Package.SetRange("ESNShipment No.UPS", rec."ESNShipment No.UPS");
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

    local procedure IsShipFromAddresDifferent(Package: Record "ETI-Package-NC"; Package2: Record "ETI-Package-NC") ShipFromAddresIsDifferent: Boolean
    begin
        ShipFromAddresIsDifferent := not (
            (Package."ESNShip-from TypeUPS" = Package2."ESNShip-from TypeUPS") AND
            (Package."ESNShip-from No.UPS" = Package2."ESNShip-from No.UPS") AND
            (Package."ESNShip-from CodeUPS" = Package2."ESNShip-from CodeUPS") AND
            (Package."ESNShip-from NameUPS" = Package2."ESNShip-from NameUPS") AND
            (Package."ESNShip-from Name 2UPS" = Package2."ESNShip-from Name 2UPS") AND
            (Package."ESNShip-from AddressUPS" = Package2."ESNShip-from AddressUPS") AND
            (Package."ESNShip-from Address 2UPS" = Package2."ESNShip-from Address 2UPS") AND
            (Package."ESNShip-from CityUPS" = Package2."ESNShip-from CityUPS") AND
            (Package."ESNShip-from ContactUPS" = Package2."ESNShip-from ContactUPS") AND
            (Package."ESNShip-from Post CodeUPS" = Package2."ESNShip-from Post CodeUPS") AND
            (Package."ESNShip-from CountyUPS" = Package2."ESNShip-from CountyUPS") AND
            (Package."ESNShip-from Coun/Reg CodeUPS" = Package2."ESNShip-from Coun/Reg CodeUPS")
        );
        exit(ShipFromAddresIsDifferent);
    end;

    local procedure TransferShipFromAddresFields(FromPackage: Record "ETI-Package-NC"; var ToPackage: Record "ETI-Package-NC")
    begin
        ToPackage."ESNShip-from TypeUPS" := FromPackage."ESNShip-from TypeUPS";
        ToPackage."ESNShip-from No.UPS" := FromPackage."ESNShip-from No.UPS";
        ToPackage."ESNShip-from CodeUPS" := FromPackage."ESNShip-from CodeUPS";
        ToPackage."ESNShip-from NameUPS" := FromPackage."ESNShip-from NameUPS";
        ToPackage."ESNShip-from Name 2UPS" := FromPackage."ESNShip-from Name 2UPS";
        ToPackage."ESNShip-from AddressUPS" := FromPackage."ESNShip-from AddressUPS";
        ToPackage."ESNShip-from Address 2UPS" := FromPackage."ESNShip-from Address 2UPS";
        ToPackage."ESNShip-from CityUPS" := FromPackage."ESNShip-from CityUPS";
        ToPackage."ESNShip-from ContactUPS" := FromPackage."ESNShip-from ContactUPS";
        ToPackage."ESNShip-from Post CodeUPS" := FromPackage."ESNShip-from Post CodeUPS";
        ToPackage."ESNShip-from CountyUPS" := FromPackage."ESNShip-from CountyUPS";
        ToPackage."ESNShip-from Coun/Reg CodeUPS" := FromPackage."ESNShip-from Coun/Reg CodeUPS";
    end;


    local procedure CheckAddressChagend()
    var
        Package: Record "ETI-Package-NC";
        PackageMgt: Codeunit "ETI-Package Mgt-NC";
        MustHaveSameAddressLbl: Label 'Packages of a shipping order %1 must have the same address.';
    begin
        Package.SetRange("ESNShipment No.UPS", rec."ESNShipment No.UPS");
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
                                Error(MustHaveSameAddressLbl, rec."ESNShipment No.UPS");
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
}