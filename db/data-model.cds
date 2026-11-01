namespace my.bookshop;

using from '@sap/cds-common-content';
using {
    cuid,
    Currency,
    Country,
} from '@sap/cds/common';

entity Books : cuid {
    title       : String;
    stock       : Integer;
    author      : String;
    genre       : Genre @assert.range: true;
    price       : Price;
    publCountry : Country;
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
