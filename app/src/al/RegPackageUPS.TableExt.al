tableextension 70869783 "ESNReg. PackageUPS" extends "ETI-Reg. Package-NC"
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
}