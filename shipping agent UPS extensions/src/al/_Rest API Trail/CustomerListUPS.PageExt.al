// pageextension 70869804 "ESNCustomer ListUPS" extends "Customer List"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addlast(processing)
//         {
//             action(ESNUPSTestUPS)
//             {
//                 trigger OnAction()
//                 var
//                 // UPSRestAPIMgt: Codeunit "ESNRest API Teach CU UPS";
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