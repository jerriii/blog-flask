/*!
* Start Bootstrap - Clean Blog v6.0.9 (https://startbootstrap.com/theme/clean-blog)
* Copyright 2013-2023 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-clean-blog/blob/master/LICENSE)
*/
window.addEventListener('DOMContentLoaded', () => {
    let scrollPos = 0;
    const mainNav = document.getElementById('mainNav');
    const headerHeight = mainNav.clientHeight;
    window.addEventListener('scroll', function() {
        const currentTop = document.body.getBoundingClientRect().top * -1;
        if ( currentTop < scrollPos) {
            // Scrolling Up
            if (currentTop > 0 && mainNav.classList.contains('is-fixed')) {
                mainNav.classList.add('is-visible');
            } else {
                console.log(123);
                mainNav.classList.remove('is-visible', 'is-fixed');
            }
        } else {
            // Scrolling Down
            mainNav.classList.remove(['is-visible']);
            if (currentTop > headerHeight && !mainNav.classList.contains('is-fixed')) {
                mainNav.classList.add('is-fixed');
            }
        }
        scrollPos = currentTop;
    });
})
    // JavaScript code for handling search functionality and dropdown
    const searchForm = document.getElementById('search-form');
    const searchInput = searchForm.querySelector('input[name="query"]');
    const searchDropdown = document.getElementById('search-dropdown');

    searchInput.addEventListener('input', handleSearchInput);

    function handleSearchInput(event) {
        const query = event.target.value;
        if (query.trim() === '') {
            searchDropdown.innerHTML = ''; // Clear dropdown when the search query is empty
        } else {
            // Send AJAX request to the server to get search results
            fetch('/search', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ q: query })
            })
            .then(response => response.json())
            .then(results => {
                displaySearchResults(results);
            })
            .catch(error => {
                console.error('Error fetching search results:', error);
            });
        }
    }

    function displaySearchResults(results) {
        // Clear previous dropdown content
        searchDropdown.innerHTML = '';

        // Create and append the dropdown items for each search result
        results.forEach(result => {
            const link = document.createElement('a');
            link.href = '/post/' + result.slug; // Replace with the link to the specific blog post
            link.textContent = result.title;
            searchDropdown.appendChild(link);
        });
    }
