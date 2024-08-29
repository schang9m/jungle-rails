describe("User Login", () => {
  const user = {
    firstName: "John",
    lastName: "Smith",
    email: "user@example.com",
    password: "password",
    passwordConfirmation: "password",
  };
  it("should log in successfully and redirect to the home page", () => {
    cy.visit("/signup");

    cy.get('input[name="user[first_name]"]').type(user.firstName);
    cy.get('input[name="user[last_name]"]').type(user.lastName);
    cy.get('input[name="user[email]"]').type(user.email);
    cy.get('input[name="user[password]"]').type(user.password);
    cy.get('input[name="user[password_confirmation]"]').type(
      user.passwordConfirmation
    );
    cy.get('input[type="submit"]').click();

    cy.visit("/login");

    // Fill in the login form
    cy.get('input[name="email"]').type(user.email);
    cy.get('input[name="password"]').type(user.password);

    // Submit the login form
    cy.get('input[type="submit"]').click(); // Adjust selector as needed

    // Assert the URL is the home page after login
    cy.url().should("eq", `${Cypress.config().baseUrl}`);
    //check nav for notification
    cy.contains(`Signed in as ${user.firstName}`);

    // Ensure products are visible after login
    cy.get(".products article").should("be.visible");
  });
});
