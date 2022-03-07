// Imports
const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
    const { Risks, BusinessPartners } = this.entities;

    this.after("READ", Risks, (data) => {
        const risks = Array.isArray(data) ? data : [data];

        risks.forEach((risk) => {
            if (risk.impact >= 8) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        });
    });
});