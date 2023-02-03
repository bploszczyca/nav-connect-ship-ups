table 70869754 "ESNItem ADR QuantityShip"
{
    Caption = 'Item ADR Quantity', Comment = 'Artikel ADR Menge';
    DataClassification = ToBeClassified;

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
        field(20; "Quantity per Base UoM (gr|ml)"; Decimal)
        {
            Caption = 'Quantity per Base Unit of Measure (gr|ml)', Comment = 'Menge per Basiseinheit (gr|ml)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Item No.", "Variant Code", "ADR No.") { Clustered = true; }
    }
}