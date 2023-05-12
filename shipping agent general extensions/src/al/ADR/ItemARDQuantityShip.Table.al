table 70869754 "ESNItem ADR QuantityShip"
{
    Caption = 'Item ADR Quantity', Comment = 'Artikel ADR Menge';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Item."No.";
        }
        field(2; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(3; "ADR No."; Code[10])
        {
            Caption = 'ADR No.', Comment = 'ADR Nr.';
            DataClassification = CustomerContent;
            TableRelation = "ESNADRShip"."No.";
            NotBlank = true;
            trigger OnValidate()
            begin
                CalcFields(Description, "Description 2");
            end;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("ESNADRShip".Description where("No." = field("ADR No.")));
        }
        field(11; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("ESNADRShip"."Description 2" where("No." = field("ADR No.")));
        }
        field(20; "Quantity per Item Base UoM"; Decimal)
        {
            Caption = 'Quantity per Item Base UoM', Comment = 'Menge per Artikel Basiseinheit';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(21; "ADR Unit of Measure"; Enum "ESNADR Quantities UoMShip")
        {
            Caption = 'ADR Unit of Measure', Comment = 'ADR Einheit';
            DataClassification = CustomerContent;
        }

        field(30; "Item Description"; Text[100])
        {
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
        field(31; "Item Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
        }
        field(40; "Packaging Type"; Enum "ESNPackaging TypeShip")
        {
            Caption = 'Packaging Type', Comment = 'Verpackungsart';
            DataClassification = CustomerContent;
        }
        field(41; "Pack. Count per Item Base UoM"; Decimal)
        {
            Caption = 'Packaging Type Count per Item Base UoM', Comment = 'Anzahl Verpackunggen per Artikel Basiseinheit';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            InitValue = 1;
        }
    }

    keys
    {
        key(PK; "Item No.", "Variant Code", "ADR No.", "Packaging Type") { Clustered = true; }
    }
}