pageextension 70869757 "ESNPackage ContentShip" extends "ETI-Package Content-NC"
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
            action("Dangerous Good Lines")
            {
                Caption = 'Dangerous Good Lines';
                Image = Change;
                ApplicationArea = Basic, Suite;
                RunObject = page "ESNPackage ADR Line ContShip";
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