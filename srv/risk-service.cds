using { riskmanagement as rm } from '../db/schema';

@path : 'service/risk'
service RisksService
{
    entity Risks as
        projection on rm.Risks;

    entity Mitigations as
        projection on rm.Mitigations;

    entity BusinessPartners as projection on rm.BusinessPartners;
}
