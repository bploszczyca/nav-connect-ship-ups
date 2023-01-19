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
    }
}