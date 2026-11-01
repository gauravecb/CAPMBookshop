using my.bookshop as my from '../db/data-model';

service CatalogService {

  @odata.draft.enabled
  entity Books as projection on my.Books;
  entity Sales as projection on my.Sales;
  entity GenreValues as projection on my.GenreValues;
  entity Attachments as projection on my.Attachments;
}
