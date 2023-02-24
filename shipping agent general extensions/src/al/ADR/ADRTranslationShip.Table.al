table 70869751 "ESNADR TranslationShip"
{
    Caption = 'ADR Translation', Comment = 'ADR Übersetzung';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ADR No."; Code[10])
        {
            Caption = 'ADR No.', Comment = 'ADR Nr.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "ESNADRShip"."No.";
        }
        field(2; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Language;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
        }
    }

    keys
    {
        key(PK; "ADR No.", "Language Code") { Clustered = true; }
    }
}