using CatalogService as service from '../../srv/cat-service';

annotate service.Books with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ID',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Title',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Stock',
                Value: stock,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Author',
                Value: author,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Genre',
                Value: genre,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price Amount',
                Value: price_amount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Currency',
                Value: price_currency_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Publication Country',
                Value: publCountry_code,
            },
        ],
    },

    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],

    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'ID',
            Value: ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Title',
            Value: title,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Stock',
            Value: stock,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Author',
            Value: author,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Genre',
            Value: genre,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price Amount',
            Value: price_amount,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Currency',
            Value: price_currency_code,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Publication Country',
            Value: publCountry_code,
        },
    ],
);
annotate service.Books with {
    genre @(Common: {
        ValueListWithFixedValues: true,
        ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'GenreValues',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: genre,
                    ValueListProperty: 'value'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'label'
                }
            ]
        }
    });
};