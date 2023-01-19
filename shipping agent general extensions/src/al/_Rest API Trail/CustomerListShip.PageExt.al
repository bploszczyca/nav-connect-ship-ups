// pageextension 70869780 "ESNCustomer ListShip" extends "Customer List"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addlast(processing)
//         {
//             action(ESNUPSTestUPSShip)
//             {
//                 trigger OnAction()
//                 var
//                     UPSRestAPIMgt: Codeunit "ESNRest API Teach CU Ship";
//                 begin
//                     // UPSRestAPIMgt.HttpClientGetByURI();
//                     // UPSRestAPIMgt.HttpClientGetByRequestMessage();
//                     // UPSRestAPIMgt.GetUserInformation(1);
//                     UPSRestAPIMgt.CreatePostUserInformation();
//                 end;
//             }
//         }
//     }

// }