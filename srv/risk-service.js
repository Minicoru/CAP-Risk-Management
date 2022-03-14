// Imports
const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  const { Risks, BusinessPartners } = this.entities;
  const headersExternalBP = {
    apikey: process.env.apikey,
  };
  this.after("READ", Risks, async (req) => {
    const risks = Array.isArray(req) ? req : [req];
    const BPsrv = await cds.connect.to("API_BUSINESS_PARTNER");

    risks.forEach((risk) => {
      if (risk.impact >= 8) {
        risk.critically = 1;
      } else {
        risk.critically = 2;
      }
    });

    try {
      console.log(req);
      risks.forEach(async (risk) => {
        // console.log(risk);
        const bp = await BPsrv.transaction(req).send({
          query: SELECT.one(this.entities.BusinessPartners)
            .where({ BusinessPartner: risk.bp_BusinessPartner })
            .columns(["BusinessPartner", "LastName", "FirstName"]),
          headers: headersExternalBP,
        });
        // console.log(bp);
      });
    } catch (error) {
    //   console.log(error);
    }
  });

  this.on("error", (err, req) => {
    switch (err.message) {
      case "UNIQUE_CONSTRAINT_VIOLATION":
        err.message = "The entry already exists.";
        break;

      default:
        err.message =
          "An error occured. Please retry. Technical error message: " +
          err.message;
        break;
    }
  });

  this.on("READ", BusinessPartners, async (req) => {
    req.query.where("LastName <> '' and FirstName <> '' ");
    const BPsrv = await cds.connect.to("API_BUSINESS_PARTNER");
    return await BPsrv.transaction(req).send({
      query: req.query,
      headers: headersExternalBP,
    });
  });
});
