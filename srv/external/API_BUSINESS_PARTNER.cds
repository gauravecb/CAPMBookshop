/* Minimal external service definition for SAP Business Partner API (OData V2)
   Source: SAP API Business Hub — API_BUSINESS_PARTNER
   Sandbox: https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/API_BUSINESS_PARTNER */

@cds.external : true
@m.IsDefaultEntityContainer: true
service API_BUSINESS_PARTNER {

    @cds.external : true
    @cds.persistence.skip : true
    entity A_BusinessPartner {
        key BusinessPartner         : String(10);
            BusinessPartnerFullName : String(81);
            BusinessPartnerName     : String(81);
            FirstName               : String(40);
            LastName                : String(40);
            BusinessPartnerType     : String(4);
            IsNaturalPerson         : String(1);
    }

    @cds.external : true
    @cds.persistence.skip : true
    entity A_Customer {
        key Customer            : String(10);
            CustomerFullName    : String(220);
            CustomerName        : String(35);
    }
}
