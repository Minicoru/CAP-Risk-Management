using riskmanagement as rm from '../db/schema';

// Annotate Risk elements
annotate rm.Risks with {
    ID     @title : 'Risk';
    title  @title : 'Title';
    owner  @title : 'Owner';
    prio   @title : 'Priority';
    descr  @title : 'Description';
    miti   @title : 'Mitigation';
    impact @title : 'Impact';
};

// Annotate Miti elements
annotate rm.Mitigations with {
    ID    @(
        UI.Hidden,
        Common : {Text : descr}
    );
    owner @title : 'Owner';
    descr @title : 'Description';
};

annotate rm.Risks with {
    miti @(Commong : {
        Text            : miti.descr,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Mitigations',
            CollectionPath : 'Mitigations',
            Parameters     : [
                {
                    $Type             : 'Common,ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'descr'
                }
            ]
        }
    })
};

// Annotate BP elements
annotate rm.BusinessPartners with {
    ID    @(
        UI.Hidden,
        Common : {Text : LastName}
    );
    LastName @title : 'LastName';
    FirstName @title : 'FirstName';
};

annotate rm.Risks with {
    bp @(Commong : {
        Text            : bp.FirstName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Business Partner',
            CollectionPath : 'BusinessPartner',
            Parameters     : [
                {
                    $Type             : 'Common,ValueListParameterInOut',
                    LocalDataProperty : bp_BusinessPartner,
                    ValueListProperty : 'BusinessPartner'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FirstName'
                
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'LastName'
                }
            ]
        }
    })
};

using from './risks-management/annotations';
using from './common';

annotate RisksService.Risks with @(
    UI.DataPoint #critically : {
        Value         : critically,
        Visualization : #Progress,
        TargetValue   : 100,
    },
    UI.LineItem              : [
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
            $Type       : 'UI.DataField',
            Label       : 'Priority',
            Value       : prio,
            Criticality : critically,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : descr,
        },
        {
            $Type                     : 'UI.DataField',
            Label                     : 'Impact',
            Value                     : impact,
            CriticalityRepresentation : #WithIcon,
            Criticality               : critically,
        },
    ]
);
