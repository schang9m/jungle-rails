describe("Home Page", () => {
  it("should visit the home page", () => {
    cy.visit("/");

    // Add an assertion to verify the page has loaded. For example:
    cy.title().should("include", "Jungle");
  });

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });
});
