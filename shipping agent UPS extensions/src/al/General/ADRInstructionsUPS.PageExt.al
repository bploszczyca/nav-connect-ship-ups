pageextension 70869807 "ESNADR InstructionsUPS" extends "ESNADR InstructionsShip"
{
    layout
    {
        // Add changes to page layout here
        addafter(Code)
        {
            field("ESNCode (UPS)UPS"; rec."ESNCode (UPS)UPS") { ApplicationArea = All; }
        }
    }
}