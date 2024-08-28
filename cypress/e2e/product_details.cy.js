describe("Product_details", () => {
  it("should visit the home page", () => {
    cy.visit("/");

    // Add an assertion to verify the page has loaded. For example:
    cy.title().should("include", "Jungle");
  });

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("should click on the first product on the page", () => {
    cy.visit("/");

    cy.get("article").first().click();

    cy.url().should("include", "/products");

    cy.get("h1").should("contain", "Scented Blade");
    cy.get("span").contains("$24.99");
  });
});
