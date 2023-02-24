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
    }
}