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
            TableRelation = "ETI-Reg. Package-NC";
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

        field(40; "Quantity per Item Base UoM"; Decimal)
        {
            Caption = 'Quantity per Item Base UoM', Comment = 'Menge per Artikel Basiseinheit';
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
                Validate("ADR Quantity", "Quantity per Item Base UoM" * "Quantity (Base)");
            end;
        }
        field(42; "ADR Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ADR Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            trigger OnValidate()
            begin
                Validate("ADR Quantity (gr|ml)", "ADR Quantity" * "ADR Quantity per UoM");
            end;
        }
        field(43; "ADR Unit of Measure"; Enum "ESNADR Quantities UoMShip")
        {
            Caption = 'ADR Unit of Measure', Comment = 'ADR Einheit';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Validate("ADR Quantity");
            end;
        }
        field(44; "ADR Quantity per UoM"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ADR Quantity per UoM';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            trigger OnValidate()
            begin
                TestField("ADR Quantity per UoM");
                Validate("ADR Quantity");
            end;
        }
        field(45; "ADR Quantity (gr|ml)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ADR Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50; "ADR Content Quantity (gr|ml)"; Decimal)
        {
            Caption = 'ADR Content Quantity (gr|ml)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("ESNReg. Package ADR ContShip"."ADR Quantity (gr|ml)" where("Package No." = field("Package No."), "Line Type" = const(Content), "ADR No." = field("ADR No.")));
        }
        field(51; "ADR Content Unit of Measure"; Enum "ESNADR Quantities UoMShip")
        {
            Caption = 'Content ADR Unit of Measure', Comment = 'ADR Einheit';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Validate("ADR Content Quantity per UoM");
            end;
        }
        field(52; "ADR Content Quantity per UoM"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ADR Quantity per UoM';
            DecimalPlaces = 0 : 5;
            Editable = false;
            trigger OnValidate()
            begin
                TestField("ADR Content Quantity per UoM");
                Validate("Manually entered Quantity");
            end;
        }
        field(53; "Manually entered Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Manually entered Quantity', Comment = 'Manuell erfasste Menge';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            trigger OnValidate()
            begin
                CalcFields("ADR Content Quantity (gr|ml)");
                if "ADR Content Quantity per UoM" = 0 then
                    "ADR Content Quantity per UoM" := 1;
                Validate("ADR Content Quantity", "ADR Content Quantity (gr|ml)" / "ADR Content Quantity per UoM" + "Manually entered Quantity");
            end;
        }
        field(60; "ADR Content Quantity"; Decimal)
        {
            Caption = 'ADR Content Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Package No.", "Line Type", "Template Type", "Template Subtype", "Template No.", "Template Line No.", "Template Sub Line No.", "Line No.", "ADR No.") { Clustered = true; }
        key(PackageQuantity; "Package No.", "Line Type", "ADR No.") { IncludedFields = "ADR Quantity (gr|ml)"; }
    }

    var
        ADRPackageMgt: Codeunit "ESNADR Package ManagementShip";

    procedure CalcPackageQuantityGrMl()
    begin
        Validate("Manually entered Quantity");
        OnAfterCalcPackageQuantityGrMl(Rec)
    end;


    [IntegrationEvent(true, false)]
    local procedure OnAfterCalcPackageQuantityGrMl(var RegPackageADRContent: Record "ESNReg. Package ADR ContShip")
    begin
    end;
}