page 70869753 "ESNADR TranslationsShip"
{
    Caption = 'ADR Translations', Comment = 'ADR Übersetzungen';
    DataCaptionFields = "ADR No.";
    PageType = List;
    SourceTable = "ESNADR TranslationShip";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Language Code"; rec."Language Code") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Description 2"; rec."Description 2") { ApplicationArea = All; Visible = false; }
            }
        }
    }
}