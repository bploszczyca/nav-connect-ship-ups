tableextension 70869804 "ESNItemUPS" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(70869800; "ESNUPS Packaging CodeUPS"; Enum "ESNPackaging TypeUPS")
        {
            Caption = 'UPS Packaging Code', Comment = 'UPS Verpackuntsart';
            DataClassification = CustomerContent;
        }
        field(70869801; "ESNUPS Simple RateUPS"; Enum "ESNUPS Simple RateUPS")
        {
            Caption = 'UPS Simple Rate';
            DataClassification = CustomerContent;
        }
    }
}