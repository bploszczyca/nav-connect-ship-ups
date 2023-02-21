table 70869750 "ESNADRShip"
{
    Caption = 'ARD UN', Comment = 'ARD UN';
    DataClassification = CustomerContent;
    LookupPageId = "ESNADR ListShip";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'UN No.', Comment = 'UN Nr.';
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(20; Class; Enum "ESNADR ClassShip")
        {
            Caption = 'Class', Comment = 'Klasse';
            DataClassification = CustomerContent;
        }
        field(21; "Classification Code"; Code[20])
        {
            Caption = 'Classification Code', Comment = 'Klassifizierungscod';
            DataClassification = CustomerContent;
            TableRelation = "ESNADR ClassificationShip".Code;
        }
        field(30; "Packing Group"; Enum "ESNADR Packing GroupShip")
        {
            Caption = 'Packing Group', Comment = 'Verpackungsgrupp';
            DataClassification = CustomerContent;
        }
        field(31; Lable; Enum "ESNADR LableShip")
        {
            Caption = 'Lable', Comment = 'Gefahrzette';
            DataClassification = CustomerContent;
        }
        field(32; "Special Provisions"; Integer)
        {
            Caption = 'Special Provisions', Comment = 'Sondervorschrifte';
            DataClassification = CustomerContent;
            MinValue = 0;
            BlankZero = true;
        }
        field(40; "Limited Quantities"; Decimal)
        {
            Caption = 'Limited Quantities (gr|ml)', Comment = 'Begrenzte Mengen (gr|ml)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(41; "Excepted Quantities"; Enum "ESNADR Excepted QuantitiesShip")
        {
            Caption = 'Excepted Quantities', Comment = 'Freigestellte Mengen';
            DataClassification = CustomerContent;
        }
        field(50; "Hazard identification No."; Code[20])
        {
            Caption = 'Hazard identification No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    trigger OnDelete()
    var
        ADRUNTranslation: Record "ESNADR TranslationShip";
        ADRInstruction: Record "ESNADR InstructionShip";
        ItemADRQuantity: Record "ESNItem ADR QuantityShip";
        ItemsAssignedLbl: Label '%1 %2 must not be deleted, as long items are assigned.', Comment = '%1 %2 darf nicht gelöscht werden, solange Artikel zugerodnet sind.';
    begin
        ItemADRQuantity.SetRange("ADR No.");
        if not ItemADRQuantity.IsEmpty then
            Error(ItemsAssignedLbl, rec.TableCaption, "No.");

        ADRUNTranslation.SetRange("ADR No.", "No.");
        if not ADRUNTranslation.IsEmpty then
            ADRUNTranslation.DeleteAll(true);

        ADRInstruction.SetRange("ADR No.", "No.");
        if not ADRInstruction.IsEmpty then
            ADRInstruction.DeleteAll(true);
    end;

}