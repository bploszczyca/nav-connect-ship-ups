table 70869752 "ESNADR ClassificationShip"
{
    Caption = 'ADR Classification', Comment = 'ADR Klassifizierung';
    DataClassification = CustomerContent;
    LookupPageId = "ESNADR ClassificationsShip";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
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