table 70869756 "ESNReg. Package ADR ContShip"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Package No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Package No.';
            Editable = false;
            TableRelation = "ETI-Package-NC";
        }
        field(2; "Line Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Type';
            Editable = false;
            OptionCaption = 'Template,,,,,Content,,,,,ADR';
            OptionMembers = Template,,,,,Content,,,,,ADR;
        }
        field(10; "Template Type"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Template Type';
            Editable = false;
        }
        field(11; "Template Subtype"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Template Subtype';
            Editable = false;
        }
        field(12; "Template No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Template No.';
            Editable = false;
        }
        field(13; "Template Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Template Line No.';
            Editable = false;
        }
        field(14; "Template Sub Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Template Sub Line No.';
            Editable = false;
        }
        field(20; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            Editable = false;
        }
        field(30; "ADR No."; Code[10])
        {
            Caption = 'ADR No.', Comment = 'ADR Nr.';
            DataClassification = CustomerContent;
            TableRelation = "ESNADRShip"."No.";
            NotBlank = true;
        }
        field(31; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("ESNADRShip".Description where("No." = field("ADR No.")));
        }
        field(32; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("ESNADRShip"."Description 2" where("No." = field("ADR No.")));
        }

        field(40; "Quantity per Base UoM (gr|ml)"; Decimal)
        {
            Caption = 'Quantity per Base Unit of Measure (gr|ml)', Comment = 'Menge per Basiseinheit (gr|ml)';
            DataClassification = CustomerContent;
            MinValue = 0;
            Editable = false;
            trigger OnValidate()
            begin
                Validate("Quantity (Base)");
            end;
        }
        field(41; "Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                "Quantity (gr|ml)" := "Quantity per Base UoM (gr|ml)" * "Quantity (Base)";
            end;
        }
        field(42; "Quantity (gr|ml)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity (gr|ml)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(50; "Content Quantity (gr|ml)"; Decimal)
        {
            Caption = 'Content Quantity (gr|ml)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("ESNPackage ADR ContentShip"."Quantity (gr|ml)" where("Package No." = field("Package No."), "Line Type" = const(Content), "ADR No." = field("ADR No.")));
        }
        field(51; "Manually Ent. Qty. (gr|ml)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Manually entered Quantity (gr|ml)', Comment = 'Manuell erfasste Menge (gr|ml)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            trigger OnValidate()
            begin
                CalcPackageQuantityGrMl();
            end;
        }
        field(60; "Package Quantity (gr|ml)"; Decimal)
        {
            Caption = 'Package Quantity (gr|ml)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Package No.", "Line Type", "Template Type", "Template Subtype", "Template No.", "Template Line No.", "Template Sub Line No.", "Line No.", "ADR No.") { Clustered = true; }
        key(PackageQuantity; "Package No.", "Line Type", "ADR No.") { IncludedFields = "Quantity (gr|ml)"; }
    }

    var
        ADRPackageMgt: Codeunit "ESNADR Package ManagementShip";

    procedure CalcPackageQuantityGrMl()
    begin
        CalcFields("Content Quantity (gr|ml)");
        "Package Quantity (gr|ml)" := "Content Quantity (gr|ml)" + "Manually Ent. Qty. (gr|ml)";
    end;
}