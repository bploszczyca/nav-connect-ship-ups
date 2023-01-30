tableextension 70869803 "ESNReg. PackageUPS" extends "ETI-Reg. Package-NC"
{
    fields
    {
        field(70869800; "ESNReturn ServiceUPS"; Enum "ESNReturn ServiceUPS")
        {
            Caption = 'Return Service';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869801; ESNNotificationUPS; Enum "ESNShip. NotificationUPS")
        {
            Caption = 'UPS Notification Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869802; "ESNUPS Packaging CodeUPS"; Enum "ESNPackaging TypeUPS")
        {
            Caption = 'UPS Packaging Code', Comment = 'UPS Verpackuntsart';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869803; "ESNUPS Premier CategoryUPS"; Enum "ESNUPS Premier CategoryUPS")
        {
            Caption = 'UPS Premier Category';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869804; "ESNUPS Premier SensorIDUPS"; Text[50])
        {
            Caption = 'UPS Premier SensorID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70869805; "ESNUPS Simple RateUPS"; Enum "ESNUPS Simple RateUPS")
        {
            Caption = 'UPS Simple Rate';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}