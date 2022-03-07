using {riskmanagement as rm
                           // Risks as MRisks,
                           // Mitigations as MMitigations
                         } from '../db/schema';

@path : 'service/risk'
service RisksService {
    entity Risks       as projection on rm.Risks;
    annotate risks with @odata.draft.enabled;
    entity Mitigations as projection on rm.Mitigations;
    annotate mitigations with @odata.draft.enabled;
//@readonly entity BusinessPartners as Projection on BusinessPartners;
}
