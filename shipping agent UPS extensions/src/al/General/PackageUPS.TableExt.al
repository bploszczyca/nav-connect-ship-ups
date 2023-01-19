tableextension 70869802 "ESNPackageUPS" extends "ETI-Package-NC"
{
    fields
    {
        field(70869800; "ESNReturn ServiceUPS"; Enum "ESNReturn ServiceUPS")
        {
            Caption = 'Return Service';
            DataClassification = CustomerContent;
        }
        field(70869801; ESNNotificationUPS; Enum "ESNShip. NotificationUPS")
        {
            Caption = 'UPS Notification Type';
            DataClassification = CustomerContent;
        }
        field(70869802; "ESNUPS Packaging CodeUPS"; Enum "ESNPackaging TypeUPS")
        {
            Caption = 'UPS Packaging Code', Comment = 'UPS Verpackuntsart';
            DataClassification = CustomerContent;
            InitValue = "02";
        }
        modify("Packing Material Item No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if item.get("Packing Material Item No.") then begin
                    if item."ESNUPS Packaging CodeUPS" <> item."ESNUPS Packaging CodeUPS"::" " then begin
                        Validate("ESNUPS Packaging CodeUPS", item."ESNUPS Packaging CodeUPS");
                    end else begin
                        Validate("ESNUPS Packaging CodeUPS", "ESNUPS Packaging CodeUPS"::"02");
                    end;
                end else begin
                    Validate("ESNUPS Packaging CodeUPS", "ESNUPS Packaging CodeUPS"::"02");
                end;
            end;
        }
    }
}