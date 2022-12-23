codeunit 70869784 "ESNShip. Agent REST Ver0UPS" implements "ESNShip. Agent REST VersionUPS"
{
    procedure GetVersionString(ShippingAgent: Record "Shipping Agent") VersionString: Text;
    var
        VersionStringLbl: Label 'v%1', Locked = true;
    begin
        case ShippingAgent."ESNREST VersionUPS" of
            ShippingAgent."ESNREST VersionUPS"::default:
                begin
                    VersionString := StrSubstNo(VersionStringLbl, 1);
                end;
            else begin
                VersionString := StrSubstNo(VersionStringLbl, Format(ShippingAgent."ESNREST VersionUPS".AsInteger()));
            end;
        end;
    end;
}