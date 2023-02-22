pageextension 70869758 "ESNReg.  Package ContentShip" extends "ETI-Reg. Package Content-NC"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Herkunftsbelegzeile")
        {
            action("ESNDangerous Good LinesShip")
            {
                Caption = 'Dangerous Good Lines';
                Image = Change;
                ApplicationArea = Basic, Suite;
                RunObject = page "ESNReg. Pack ADR Line ContShip";
                RunPageLink =
                    "Package No." = field("Package No."),
                    "Line Type" = field("Line Type"),
                    "Template Type" = field("Template Type"),
                    "Template Subtype" = field("Template Subtype"),
                    "Template No." = field("Template No."),
                    "Template Line No." = field("Template Line No."),
                    "Template Sub Line No." = field("Template Sub Line No."),
                    "Line No." = field("Line No.");
                Scope = Repeater;
            }
        }
    }
}