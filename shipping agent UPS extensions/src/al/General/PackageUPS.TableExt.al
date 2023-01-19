tableextension 70869802 "ESNPackageUPS" extends "ETI-Package-NC"
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