tableextension 70869782 "ESNPackageUPS" extends "ETI-Package-NC"
{
    fields
    {
        // Add changes to table fields here
        field(70869780; "ESNShipment No.UPS"; Code[20])
        {
            Caption = 'Shipment No.', Comment = 'Versandauftragsnr.';
            DataClassification = CustomerContent;
        }
        field(70869781; "ESNPackage CoutUPS"; Integer)
        {
            Caption = 'Package Cout', Comment = 'Anzahl Pakete';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("ETI-Package-NC" where("ESNShipment No.UPS" = field("ESNShipment No.UPS")));
        }
    }

    trigger OnAfterInsert()
    begin
        if "ESNShipment No.UPS" = '' then begin
            if GetFilter("ESNShipment No.UPS") = '' then begin
                "ESNShipment No.UPS" := "No.";
            end else begin
                "ESNShipment No.UPS" := GetRangeMax("ESNShipment No.UPS");
            end;
            Modify(true);
        end;
    end;
}