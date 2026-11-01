
using CatalogService as service from '../../srv/cat-service';

annotate service.Books with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data: [
            { $Type: 'UI.DataField', Label: 'ID', Value: ID },
            { $Type: 'UI.DataField', Label: 'Title', Value: title },
            { $Type: 'UI.DataField', Label: 'Stock', Value: stock },
            { $Type: 'UI.DataField', Label: 'Author', Value: author },
            { $Type: 'UI.DataField', Label: 'Genre', Value: genre },
            { $Type: 'UI.DataField', Label: 'Price Amount', Value: price_amount },
            { $Type: 'UI.DataField', Label: 'Currency', Value: price_currency_code },
            { $Type: 'UI.DataField', Label: 'Publication Country', Value: publCountry_code }
        ]
    },

    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'GeneratedFacet1',
            Label: 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup'
        },
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'SalesFacet',
            Label: 'Sales',
            Target: 'sales/@UI.LineItem'
        },
          {
        $Type: 'UI.ReferenceFacet',
        ID: 'AttachmentsFacet',
        Label: 'Attachments',
        Target: 'attachments/@UI.LineItem'
    }
    ],

    UI.LineItem: [
        { $Type: 'UI.DataField', Label: 'ID', Value: ID },
        { $Type: 'UI.DataField', Label: 'Title', Value: title },
        { $Type: 'UI.DataField', Label: 'Stock', Value: stock },
        { $Type: 'UI.DataField', Label: 'Author', Value: author },
        { $Type: 'UI.DataField', Label: 'Genre', Value: genre },
        { $Type: 'UI.DataField', Label: 'Price Amount', Value: price_amount },
        { $Type: 'UI.DataField', Label: 'Currency', Value: price_currency_code },
        { $Type: 'UI.DataField', Label: 'Publication Country', Value: publCountry_code }
    ]
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

annotate service.Sales with @UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: quantity,
        Label: 'Quantity Sold'
    },
    {
        $Type: 'UI.DataField',
        Value: paymentMode,
        Label: 'Payment Mode'
    },
    {
        $Type: 'UI.DataField',
        Value: saleDate,
        Label: 'Sale Date'
    }
];
annotate service.Attachments with @UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: content,
        Label: 'Attachment'
    },
    {
        $Type: 'UI.DataField',
        Value: fileName,
        Label: 'File Name'
    },
    {
        $Type: 'UI.DataField',
        Value: uploadedAt,
        Label: 'Uploaded At'
    }
];
annotate service.Attachments with @(
    UI.MediaResource: {
        Stream: content
    }
);