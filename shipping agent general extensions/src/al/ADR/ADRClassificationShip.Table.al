table 70869752 "ESNADR ClassificationShip"
{
    Caption = 'ADR Classification', Comment = 'ADR Klassifizierung';
    DataClassification = ToBeClassified;
    LookupPageId = "ESNADR ClassificationsShip";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code) { Clustered = true; }
    }

}