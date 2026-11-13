using my.bookshop as my from '../db/data-model';

service CatalogService {

  @odata.draft.enabled
   @restrict: [
    { grant: 'READ',  to: 'authenticated-user' },
    { grant: 'WRITE', to: 'Admin' }
  ]
  entity Books as projection on my.Books;
  entity Sales as projection on my.Sales;
  entity GenreValues as projection on my.GenreValues;
  entity Attachments as projection on my.Attachments;
   // NEW: ISBN lookup function
    function findBookByISBN(isbn: String(13)) returns Books;
}
