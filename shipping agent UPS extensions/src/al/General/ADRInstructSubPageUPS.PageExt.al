pageextension 70869808 "ESNADR Instruct. SubPageUPS" extends "ESNADR Instruct. SubPageShip"
{
    layout
    {
        addafter(Code)
        {
            field("ESNCode (UPS)UPS"; rec."ESNCode (UPS)UPS") { ApplicationArea = All; Visible = false; }
        }
    }

}