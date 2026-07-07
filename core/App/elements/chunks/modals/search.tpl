<div class="modal fade" id="searchModal" tabindex="-1" aria-label="Поиск" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="search-bar">
                <i class="bi bi-search"></i>
                <input
                        id="searchInput"
                        class="search-input"
                        type="search"
                        placeholder="Введите запрос (от 2 символов)…"
                        autocomplete="off"
                >
                <button class="search-close" data-bs-dismiss="modal" aria-label="Закрыть">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>

            <div class="search-body" id="searchBody">
                <div class="search-hint" id="searchHint">
                    <i class="bi bi-keyboard" style="font-size:2rem;display:block;margin-bottom:.5rem;opacity:.4"></i>
                    Начните вводить запрос…
                </div>
                <div class="search-loader" id="searchLoader">
                    <div class="spinner-border" role="status"></div>
                </div>
                <div id="searchResults"></div>
            </div>

        </div>
    </div>
</div>