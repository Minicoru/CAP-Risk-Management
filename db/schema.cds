namespace riskmanagement;


entity Risks {
    key ID         : UUID @(Core.Computed : true);
        title      : String(100);
        owner      : String;
        prio       : String(15);
        descr      : String;
        miti       : Association to Mitigations;
        impact     : Integer;
        // You will need this definition in a later step
        critically : Integer;
        bp         : Association to BusinessPartners;
}

entity Mitigations {
    key ID       : UUID @(Core.Computed : true);
        descr    : String;
        owner    : String;
        timeline : String;
        risks    : Association to many Risks
                       on risks.miti = $self;
}

using {API_BUSINESS_PARTNER as external} from '../srv/external/API_BUSINESS_PARTNER.csn';

entity BusinessPartners as projection on external.A_BusinessPartner {
    key BusinessPartner, LastName, FirstName,
};
