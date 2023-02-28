tableextension 70869806 "ESNADR InstructionUPS" extends "ESNADR InstructionShip"
{
    fields
    {
        field(70869800; "ESNCode (UPS)UPS"; Code[4])
        {
            Caption = 'Code (UPS)', Comment = 'Code (UPS)';
            DataClassification = CustomerContent;
        }
    }
}