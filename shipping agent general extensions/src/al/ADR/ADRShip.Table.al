table 70869750 "ESNADRShip"
{
    Caption = 'ADR UN', Comment = 'ADR UN';
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
        field(41; "Limited Quantity Unit"; Enum "ESNADR Quantities UoMShip")
        {
            Caption = 'Limited Quantities UoM', Comment = 'Einheit (Begrenzte Mengen)';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Validate("Limited Quantities per UoM", ADRMgt.GetADRQtyPer_mlgr("Limited Quantity Unit"));
            end;
        }
        field(40; "Limited Quantities"; Decimal)
        {
            Caption = 'Limited Quantities', Comment = 'Begrenzte Mengen';
            DataClassification = CustomerContent;
            MinValue = 0;
            trigger OnValidate()
            begin
                "Limited Quantities (gr|ml)" := "Limited Quantities" * "Limited Quantities per UoM";
            end;
        }
        field(42; "Limited Quantities per UoM"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ADR Quantity per UoM';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            trigger OnValidate()
            begin
                TestField("Limited Quantities per UoM");
                Validate("Limited Quantities");
            end;
        }
        field(45; "Limited Quantities (gr|ml)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Limited Quantities (gr|ml)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(50; "Excepted Quantities"; Enum "ESNADR Excepted QuantitiesShip")
        {
            Caption = 'Excepted Quantities', Comment = 'Freigestellte Mengen';
            DataClassification = CustomerContent;
        }
        field(60; "Hazard identification No."; Code[20])
        {
            Caption = 'Hazard identification No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    var
        ADRMgt: Codeunit "ESNADR ManagementShip";

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

    procedure GetTranslatedDescription(LanguageCode: Code[10]) TranslatedDescription: Text
    var
        NADRTranslation: Record "ESNADR TranslationShip";
    begin
        NADRTranslation.SetRange("ADR No.", "No.");
        NADRTranslation.SetFilter("Language Code", '%1|%2', '', LanguageCode);
        if not NADRTranslation.IsEmpty then begin
            if NADRTranslation.FindLast() then
                TranslatedDescription := CombineDescriptions(NADRTranslation.Description, NADRTranslation."Description 2");
        end else begin
            TranslatedDescription := CombineDescriptions(Description, "Description 2");
        end;
    end;

    procedure CombineDescriptions(Description: Text; Description2: Text) ResultDescription: Text
    begin
        if Description2 <> '' then begin
            ResultDescription := Description + ', ' + Description2;
        end else begin
            ResultDescription := Description;
        end;
    end;
}