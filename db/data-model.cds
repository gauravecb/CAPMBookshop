namespace my.bookshop;

using from '@sap/cds-common-content';
using {
    cuid,
    Currency,
    Country,
} from '@sap/cds/common';

entity Books : cuid {
    title       : String  ;
    stock       : Integer @assert.range: [
        0,
        2147483647
    ];
    author      : String  ;
    genre       : Genre   @assert.range: true;
    price       : Price;
    publCountry : Country;
    sales       : Composition of many Sales
                      on sales.book = $self;
    attachments : Composition of many Attachments
                      on attachments.book = $self;
}

entity GenreValues {
    key value : Integer;
        label : String;
}

type Genre : Integer enum {
    fiction = 1;
    non_fiction = 2;
}

type Price {
    amount   : Decimal;
    currency : Currency;
}

entity Sales : cuid {
    book        : Association to Books;
    quantity    : Integer   @assert.range : [
        1,
        2147483647
    ];
    unitPrice   : Price;
    paymentMode : String(20);
    saleDate    : Timestamp @cds.on.insert: $now;

}

entity Attachments : cuid {
    book         : Association to Books;
    fileName     : String(255);
    mediaType    : String(100);
    content      : LargeBinary @Core.MediaType: mediaType
    @Core.ContentDisposition.Filename: fileName;
    uploadedAt   : Timestamp @cds.on.insert: $now;
}
