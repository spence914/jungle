it('can visit the home page', () => {
  
  cy.visit("http://localhost:3000/")
})

it("can navigate to a product page", () => {
  cy.get(".products article").first().click();
});

