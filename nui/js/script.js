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
      menuItemElement.id = menuItem.priority;
      menuList.appendChild(menuItemElement);
    });
  
    // Set menu color
    // titleElement.style.color = menuColor;
    const activeItem = document.getElementById("1");
    activeItem.style.border = "2px solid #1CC5FA";
    activeItem.style.background = "#145A70";
  }

window.addEventListener('message', (event) => {
    if (event.data.task === 'menu-open') {     
      createMenu(event.data.data);
    } else if (event.data.task === 'menu-close') {
      const menu = document.getElementById('menuContainer');
      menu.innerHTML  = "";

    } else if (event.data.task === 'menu-update-selection') {
      const oldActiveItem =  document.getElementById(event.data.oldSelectedItem);
      oldActiveItem.style.border = "2px solid #1296BF";
      oldActiveItem.style.background = "#0F3F4E";
      const activeItem =  document.getElementById(event.data.selectedItem);
      activeItem.style.border = "2px solid #1CC5FA";
      activeItem.style.background = "#145A70";
    }
});