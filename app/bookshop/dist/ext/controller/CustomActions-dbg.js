
sap.ui.define([
    "sap/m/Dialog",
    "sap/m/Input",
    "sap/m/Button",
    "sap/m/Label",
    "sap/m/MessageToast",
    "sap/m/HBox",
    "sap/ndc/BarcodeScanner"
], function (
    Dialog,
    Input,
    Button,
    Label,
    MessageToast,
    HBox,
    BarcodeScanner
) {
    "use strict";

    return {
        onFindBookByISBN: function (oEvent) {
            var oView = this.editFlow.getView();
            var oModel = oView.getModel();
            var oInput = new Input({
                placeholder: "Enter or scan ISBN",
                width: "100%",
                maxLength: 13,
                submit: function () {
                    searchBook();
                }
            });

            var oScanButton = new Button({
                icon: "sap-icon://bar-code",
                tooltip: "Scan ISBN using camera",
                press: function () {
                    BarcodeScanner.scan(
                        function (oResult) {
                            if (!oResult.cancelled && oResult.text) {
                                oInput.setValue(oResult.text);
                                MessageToast.show(
                                    "Barcode scanned successfully"
                                );
                            }
                        },
                        function (oError) {
                            MessageToast.show(
                                "Barcode scanning failed"
                            );
                            console.error(oError);
                        }
                    );
                }
            });

            var oDialog = new Dialog({
                title: "Find Book by ISBN",
                contentWidth: "400px",
                content: [
                    new Label({
                        text: "ISBN",
                        labelFor: oInput
                    }),
                    new HBox({
                        width: "100%",
                        alignItems: "Center",
                        items: [
                            oInput,
                            oScanButton
                        ]
                    })
                ],
                beginButton: new Button({
                    text: "Search",
                    type: "Emphasized",
                    press: searchBook
                }),
                endButton: new Button({
                    text: "Cancel",
                    press: function () {
                        oDialog.close();
                    }
                })
            });

            function searchBook() {
                var sISBN = oInput.getValue().trim();

                if (!sISBN) {
                    MessageToast.show("Please enter an ISBN");
                    return;
                }

                var oOperation = oModel.bindContext(
                    "/findBookByISBN(...)"
                );

                oOperation.setParameter("isbn", sISBN);

                oOperation.execute().then(function () {
                    var oBookContext = oOperation.getBoundContext();

                    if (!oBookContext) {
                        MessageBox.error("Book not found.");
                        return;
                    }

                    oDialog.close();

                    oBookContext.requestCanonicalPath().then(function (sCanonicalPath) {

                        // Example: /Books(ID=...,IsActiveEntity=true)
                        var sNavigationKey = sCanonicalPath.substring(
                            "/Books(".length,
                            sCanonicalPath.lastIndexOf(")")
                        );

                        var oRouting = sap.ui.core.UIComponent.getRouterFor(oView);

                        oRouting.navTo("BooksObjectPage", {
                            key: sNavigationKey
                        });

                    }).catch(function (oError) {
                        MessageBox.error(
                            oError.message || "Unable to navigate to the book."
                        );
                    });

                }).catch(function (oError) {
                    MessageBox.error(
                        oError.message || "Unable to find the book."
                    );
                });
            }

            oDialog.open();
            oInput.focus();
        }
    };
});



// sap.ui.define([
//     "sap/m/Dialog",
//     "sap/m/Input",
//     "sap/m/Button",
//     "sap/m/Label",
//     "sap/m/MessageToast",
//     "sap/m/MessageBox",
//     "sap/m/HBox",
//     "sap/ndc/BarcodeScanner"
// ], function (
//     Dialog,
//     Input,
//     Button,
//     Label,
//     MessageToast,
//     MessageBox,
//     HBox,
//     BarcodeScanner
// ) {
//     "use strict";

//     return {
//         onFindBookByISBN: function (oContext, aSelectedContexts, oEvent) {

//             var oView = oEvent.getSource().getParent();
//             var oModel = oView.getModel();

//             var oInput = new Input({
//                 placeholder: "Enter or scan ISBN",
//                 width: "100%",
//                 maxLength: 13,
//                 submit: searchBook
//             });

//             var oDialog = new Dialog({
//                 title: "Find Book by ISBN",
//                 contentWidth: "400px",
//                 content: [
//                     new Label({
//                         text: "ISBN",
//                         labelFor: oInput
//                     }),
//                     new HBox({
//                         width: "100%",
//                         alignItems: "Center",
//                         items: [
//                             oInput,
//                             new Button({
//                                 icon: "sap-icon://bar-code",
//                                 tooltip: "Scan ISBN",
//                                 press: function () {
//                                     BarcodeScanner.scan(function (result) {
//                                         if (!result.cancelled && result.text) {
//                                             oInput.setValue(result.text);
//                                         }
//                                     });
//                                 }
//                             })
//                         ]
//                     })
//                 ],
//                 beginButton: new Button({
//                     text: "Search",
//                     type: "Emphasized",
//                     press: searchBook
//                 }),
//                 endButton: new Button({
//                     text: "Cancel",
//                     press: function () {
//                         oDialog.close();
//                     }
//                 })
//             });

//             function searchBook() {
//                 var sISBN = oInput.getValue().trim();

//                 if (!sISBN) {
//                     MessageToast.show("Please enter an ISBN");
//                     return;
//                 }

//                 var oOperation = oModel.bindContext(
//                     "/findBookByISBN(...)"
//                 );

//                 oOperation.setParameter("isbn", sISBN);

//                 oOperation.execute().then(function () {
//                     var oBookContext = oOperation.getBoundContext();

//                     if (!oBookContext) {
//                         MessageBox.error("Book not found.");
//                         return;
//                     }

//                     oDialog.close();

//                     var sBookID = oBookContext.getProperty("ID");
//                     var sNavigationPath = oModel.createKey("/Books", {
//                         ID: sBookID,
//                         IsActiveEntity: true
//                     });

//                     var oRouting = sap.ui.core.UIComponent
//                         .getRouterFor(oView);

//                     oRouting.navTo("BooksObjectPage", {
//                         key: sNavigationPath
//                     });

//                 }).catch(function (oError) {
//                     MessageBox.error(
//                         oError.message || "Unable to find the book."
//                     );
//                 });
//             }

//             oDialog.open();
//         }
//     };
// });
