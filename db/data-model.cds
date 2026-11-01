namespace my.bookshop;

using from '@sap/cds-common-content';
using {
    cuid,
    Currency,
    Country,
} from '@sap/cds/common';

entity Books : cuid {
    title       : String @Core.Immutable;
    stock       : Integer @assert.range: [0, 2147483647];
    author      : String @Core.Immutable;
    genre       : Genre @assert.range: true;
    price       : Price;
    publCountry : Country;
     sales       : Composition of many Sales
                      on sales.book = $self;
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
    book      : Association to Books;
    quantity  : Integer @assert.range: [1, 2147483647];
    unitPrice : Price;
    paymentMode : String(20);
    saleDate  : Timestamp @cds.on.insert: $now;
    
}
