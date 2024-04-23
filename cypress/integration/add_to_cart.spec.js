describe('Add to cart functionality', () => {
  it('increments the cart count by 1 when a product is added', () => {
    cy.visit('http://localhost:3000');  

    let initialCount;
   
    cy.get('.nav-link').invoke('text').then((text) => {
      const match = text.match(/My Cart \((\d+)\)/);
      if (match && match[1]) {
        initialCount = parseInt(match[1]);
      }
    });

    cy.get('form[action="/cart/add_item?product_id=2"] button').click({ force: true });

    
    cy.get('.nav-link').invoke('text').should((newText) => {
      const newMatch = newText.match(/My Cart \((\d+)\)/);
      if (newMatch && newMatch[1]) {
        const newCount = parseInt(newMatch[1]);
        expect(newCount).to.eq(initialCount + 1);
      }
    });
  });
});