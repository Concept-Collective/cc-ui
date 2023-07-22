  // Function to create the menu dynamically
  function createMenu(data) {
    const menuContainer = document.getElementById('menuContainer');
  
    const menuTitle = data.title;
    const menuDescription = data.description;
    const menuColor = data.color;
    const menuItems = data.data;
  
    // Create menu title element
    const titleElement = document.createElement('h2');
    titleElement.textContent = menuTitle;
    menuContainer.appendChild(titleElement);
  
    // Create menu description element
    const descriptionElement = document.createElement('p');
    descriptionElement.textContent = menuDescription;
    menuContainer.appendChild(descriptionElement);
  
    // Create menu items list element
    const menuList = document.createElement('ul');
    menuContainer.appendChild(menuList);
  
    // Sort menu items based on priority before displaying
    const sortedMenuItems = Object.entries(menuItems).sort((a, b) => a[1].priority - b[1].priority);
  
    // Display sorted menu items
    sortedMenuItems.forEach(([key, menuItem]) => {
      const menuItemElement = document.createElement('li');
      menuItemElement.textContent = menuItem.name;
      menuList.appendChild(menuItemElement);
    });
  
    // Set menu color
    // titleElement.style.color = menuColor;
  }

window.addEventListener('message', (event) => {
    if (event.data.task === 'menu-open') {
        createMenu(event.data.data);
    }
});