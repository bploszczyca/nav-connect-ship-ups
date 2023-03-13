permissionset 70869751 "ESNEditARDSetupShip"
{
    Caption = 'Edit ARD Setup';
    Assignable = true;
    Permissions =
        tabledata "ESNADR ClassificationShip" = RIMD,
        tabledata "ESNADR InstructionShip" = RIMD,
        tabledata "ESNADR TranslationShip" = RIMD,
        tabledata ESNADRShip = RIMD,
        tabledata "ESNItem ADR QuantityShip" = RIMD,
        tabledata "ESNPackage ADR ContentShip" = RIMD,
        tabledata "ESNReg. Package ADR ContShip" = RIMD,
        table "ESNADR ClassificationShip" = X,
        table "ESNADR InstructionShip" = X,
        table "ESNADR TranslationShip" = X,
        table ESNADRShip = X,
        table "ESNItem ADR QuantityShip" = X,
        table "ESNPackage ADR ContentShip" = X,
        table "ESNReg. Package ADR ContShip" = X,
        codeunit "ESNADR ManagementShip" = X,
        codeunit "ESNADR Package ManagementShip" = X;
}