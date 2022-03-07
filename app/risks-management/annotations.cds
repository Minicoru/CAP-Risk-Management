using RisksService as service from '../../srv/risk-service';

annotate service.Risks with @(
    UI.Identification  : [{Value : title}],
    UI.SelectionFields : [prio],
    UI.LineItem        : [
        {
            $Type : 'UI.DataField',
            Label : 'Title',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Owner',
            Value : owner,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Priority',
            Value : prio,
            Criticality : critically,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : descr,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Impact',
            Value : impact,
            Criticality : critically,
        },
    ]
);

annotate service.Risks with @(UI : {
    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Main',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {Data : [
        {Value : miti.descr, },
        {Value : owner, },
        {
            Value       : impact,
            Criticality : critically,
        },
        {
            Value       : prio,
            Criticality : critically,
        },
    ]},
});
