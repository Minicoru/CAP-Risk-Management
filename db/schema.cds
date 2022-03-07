namespace riskmanagement;


entity Risks {
    key ID         : UUID @(Core.Computed : true);
        title      : String(100);
        owner      : String;
        prio       : String(15);
        descr      : String;
        miti       : Association to Mitigations;
        impact     : Integer;
        //bp :Association to BusinessPartners;
        // You will need this definition in a later step
        critically : Integer;
}

entity Mitigations {
    key ID       : UUID @(Core.Computed : true);
        descr    : String;
        owner    : String;
        timeline : String;
        risks    : Association to many Risks
                       on risks.miti = $self;
}
