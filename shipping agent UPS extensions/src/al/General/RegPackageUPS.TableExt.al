tableextension 70869803 "ESNReg. PackageUPS" extends "ETI-Reg. Package-NC"
{
    fields
    {
        field(70869800; "ESNReturn ServiceUPS"; Enum "ESNReturn ServiceUPS")
        {
            Caption = 'Return Service';
        }
        field(70869801; ESNNotificationUPS; Enum "ESNShip. NotificationUPS")
        {
            Caption = 'UPS Notification Type';
        }
    }
}