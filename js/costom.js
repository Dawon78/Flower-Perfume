
    const bottleImages = document.querySelectorAll('.cus-bottle-img');

    bottleImages.forEach(img => {
        img.addEventListener('click', () => {
    
            const checkboxId = img.getAttribute('data-checkbox');
            const checkbox = document.getElementById(checkboxId);

    
            checkbox.checked = !checkbox.checked;
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        const cards = document.querySelectorAll('.card');
        cards.forEach(card => {
            card.addEventListener('click', () => {
                cards.forEach(c => c.classList.remove('selected'));
                card.classList.add('selected');
            });
        });
    });

    function toggleDescription(label) {
      const checkbox = label.querySelector('input[type="checkbox"]');
      const description = label.parentElement.querySelector('.cus-description');
      checkbox.checked = !checkbox.checked;
      if (checkbox.checked) {
        description.style.maxHeight = description.scrollHeight + 'px';
      } else {
        description.style.maxHeight = '0';
      }
    }