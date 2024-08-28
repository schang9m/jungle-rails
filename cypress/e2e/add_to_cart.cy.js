describe("add_to_cart", () => {
  it("should visit the home page", () => {
    cy.visit("/");

    // Add an assertion to verify the page has loaded. For example:
    cy.title().should("include", "Jungle");
  });

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("should add a product to the cart and update the cart count", () => {
    cy.visit("/");

    // Capture the initial cart count
    cy.get("nav .nav-item")
      .contains("My Cart")
      .invoke("text")
      .then((text) => {
        const initialCount = parseInt(text.match(/\((\d+)\)/)[1], 10); // Extract the initial count

        // Click the 'Add to Cart' button of the first product
        cy.contains("article", "Scented Blade")
          .find("button")
          .click({ force: true }); // Force true to be able to click

        // Verify that the cart count has changed
        cy.get("nav .nav-item")
          .contains("My Cart")
          .invoke("text")
          .then((updatedText) => {
            const updatedCount = parseInt(
              updatedText.match(/\((\d+)\)/)[1],
              10
            ); // Extract the updated count
            expect(updatedCount).to.eq(initialCount + 1); // Verify the count increment
          });
      });
  });
});
