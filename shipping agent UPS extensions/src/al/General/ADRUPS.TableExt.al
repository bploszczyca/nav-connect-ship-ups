tableextension 70869805 "ESNADRUPS" extends "ESNADRShip"
{
    fields
    {
        // Add changes to table fields here
        field(70869800; "ESNLightly RegulatedUPS"; Boolean)
        {
            Caption = 'Lightly Regulated', Comment = 'Leicht reguliert';
            DataClassification = CustomerContent;
        }
        field(70869801; "ESNAdditional DescriptionUPS"; text[255])
        {
            Caption = 'Additional Description (UPS)', Comment = 'Zusätzlichen Beschreibung (UPS)';
            DataClassification = CustomerContent;
        }
    }
}