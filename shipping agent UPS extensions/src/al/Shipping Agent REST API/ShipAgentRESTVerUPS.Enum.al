enum 70869800 "ESNShip. Agent REST Ver.UPS" implements "ESNShipping Agent RESTUPS", "ESNShip. Agent REST VersionUPS", "ESNShipping Agent APIShip"
{
    Caption = 'Shipping Agent REST Version';
    Extensible = true;


    value(0; "default")
    {
        Caption = 'default (v1)', Comment = 'Standard (v1)';
        Implementation =
            "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST v1UPS",
            "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS",
            "ESNShipping Agent APIShip" = "ESNShipping Agent REST v1UPS";
    }
    value(1; "v1")
    {
        Caption = 'v1', Comment = 'v1';
        Implementation =
            "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST v1UPS",
            "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS",
            "ESNShipping Agent APIShip" = "ESNShipping Agent REST v1UPS";
    }
    value(1601; "v1601") { Caption = 'v1601', Comment = 'v1601'; Implementation = "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST vXXUPS", "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS", "ESNShipping Agent APIShip" = "ESNShipping Agent REST vXXUPS"; }
    value(1607; "v1607") { Caption = 'v1607', Comment = 'v1607'; Implementation = "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST vXXUPS", "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS", "ESNShipping Agent APIShip" = "ESNShipping Agent REST vXXUPS"; }
    value(1701; "v1701") { Caption = 'v1701', Comment = 'v1701'; Implementation = "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST vXXUPS", "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS", "ESNShipping Agent APIShip" = "ESNShipping Agent REST vXXUPS"; }
    value(1707; "v1707") { Caption = 'v1707', Comment = 'v1707'; Implementation = "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST vXXUPS", "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS", "ESNShipping Agent APIShip" = "ESNShipping Agent REST vXXUPS"; }
    value(1801; "v1801") { Caption = 'v1801', Comment = 'v1801'; Implementation = "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST vXXUPS", "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS", "ESNShipping Agent APIShip" = "ESNShipping Agent REST vXXUPS"; }
    value(1807; "v1807") { Caption = 'v1807', Comment = 'v1807'; Implementation = "ESNShipping Agent RESTUPS" = "ESNShipping Agent REST vXXUPS", "ESNShip. Agent REST VersionUPS" = "ESNShip. Agent REST Ver0UPS", "ESNShipping Agent APIShip" = "ESNShipping Agent REST vXXUPS"; }

}