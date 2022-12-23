interface "ESNShipping Agent APIShip"
{
    procedure RegisterShipping(Package: Record "ETI-Package-NC");

    procedure CancelRegisteredShipping(RegPackage: Record "ETI-Reg. Package-NC");

    procedure GetShippingLable(RegPackage: Record "ETI-Reg. Package-NC");

    procedure PrintShippingLable(RegPackage: Record "ETI-Reg. Package-NC");

    procedure GetTrackingStatus(RegPackage: Record "ETI-Reg. Package-NC");

    procedure GetShippingCosts(RegPackage: Record "ETI-Reg. Package-NC");

}