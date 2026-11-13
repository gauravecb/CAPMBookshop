using my.bookshop as my from '../db/data-model';
using API_BUSINESS_PARTNER as bp from './external/API_BUSINESS_PARTNER';

service CatalogService {

  @odata.draft.enabled
  entity Books as projection on my.Books;
  entity Sales as projection on my.Sales;
  entity GenreValues as projection on my.GenreValues;
  entity Attachments as projection on my.Attachments;

  @readonly
  entity BusinessPartners as projection on bp.A_BusinessPartner {
    key BusinessPartner         as ID,
        BusinessPartnerFullName as fullName,
        FirstName               as firstName,
        LastName                as lastName,
        BusinessPartnerType     as type
  };
}
