pageextension 70869764 "ESNDoc. Att. DetailsShip" extends "Document Attachment Details"
{
    layout
    {
        addafter("File Type")
        {
            field("ESNPackage Attachment TypeShip"; rec."ESNPackage Attachment TypeShip") { ApplicationArea = All; Visible = ShowPackageAttachmentType; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        if Rec.GetFilter("Table ID") <> '' then begin
            ShowPackageAttachmentType := rec.GetRangeMin("Table ID") IN [database::"ETI-Package-NC", database::"ETI-Reg. Package-NC"];
        end;
    end;

    var
        [InDataSet]
        ShowPackageAttachmentType: Boolean;

}