class Search {
    constructor({ inputId, hintId, loaderId, resultsId, modalId, apiUrl = '/api/search', debounceMs = 300, type = null, triggerSelector = null }) {
        this.type = type;
        this.triggerSelector = triggerSelector;
        this.input    = document.getElementById(inputId);
        this.hint     = document.getElementById(hintId);
        this.loader   = document.getElementById(loaderId);
        this.results  = document.getElementById(resultsId);
        this.modal    = document.getElementById(modalId);
        this.apiUrl   = apiUrl;
        this.debounceMs = debounceMs;

        this._handleInput = this._debounce(this._onInput.bind(this), debounceMs);
        this._init();
    }

    _init() {
        this.input.addEventListener('input', this._handleInput);

        if (this.triggerSelector) {
            document.querySelectorAll(this.triggerSelector).forEach(btn => {
                btn.addEventListener('click', () => {
                    this.type = btn.dataset.searchType ?? null;
                });
            });
        }

        this.modal.addEventListener('shown.bs.modal', () => {
            this.input.focus();
        });

        this.modal.addEventListener('hidden.bs.modal', () => {
            this.input.value = '';
            this.type = null;
            pbFetch.cancel('search');
            this._showHint();
        });
    }

    async _onInput() {
        const q = this.input.value.trim();

        if (q.length < 2) {
            this._showHint();
            return;
        }

        this._showLoader();

        try {
            const { tours, articles } = await this._fetch(q);
            const total = tours.length + articles.length;

            if (total === 0) {
                this._showResults(this._renderEmpty(q));
            } else {
                this._showResults(
                    this._renderSection('Туры', tours) +
                    this._renderSection('Статьи', articles)
                );
            }
        } catch {
            this._showResults(this._renderError());
        }
    }

    _fetch(query) {
        const q = query.toLowerCase();
        const typeParam = this.type ? `&type=${this.type}` : '';

        return new Promise((resolve, reject) => {
            pbFetch.ajax({
                url: `${this.apiUrl}?q=${encodeURIComponent(q)}${typeParam}`,
                expect: 'json',
                cancelKey: 'search',
                success: (response, data) => resolve(data),
                error:   (response, data) => reject(new Error(data?.message || 'Network error')),
            });
        });
    }

    _renderItem(item) {
        const thumb = item.image
            ? `<img loading="lazy" width="68" height="56" class="result-thumb" src="${item.image}" alt="${item.title}" loading="lazy">`
            : `<div class="result-thumb-placeholder">${item.type === 'tour' ? '✈️' : '📰'}</div>`;

        const badgeClass = item.type === 'tour' ? 'badge-tour' : 'badge-article';
        const badgeLabel = item.type === 'tour' ? 'Тур' : 'Статья';

        return `
        <a href="${item.url}" class="result-item" rel="noopener">
            ${thumb}
            <div class="result-info">
                <span class="result-badge ${badgeClass}">${badgeLabel}</span>
                <div class="result-title">${item.title}</div>
                <div class="result-date">
                    <i class="bi bi-calendar3"></i> ${item.date}
                </div>
            </div>
            <i class="bi bi-arrow-right result-arrow"></i>
        </a>`;
    }

    _renderSection(title, items) {
        if (!items.length) return '';
        return `
        <div class="results-section-title">
            ${title} <span class="fw-normal">(${items.length})</span>
        </div>
        ${items.map(item => this._renderItem(item)).join('')}`;
    }

    _renderEmpty(query) {
        return `
        <div class="no-results">
            <i class="bi bi-emoji-frown"></i>
            Ничего не найдено по запросу <strong>«${query}»</strong>
        </div>`;
    }

    _renderError() {
        return `
        <div class="search-hint text-danger">
            <i class="bi bi-exclamation-circle"></i> Ошибка запроса. Попробуйте позже.
        </div>`;
    }

    _showHint() {
        this.hint.style.display   = '';
        this.loader.style.display = 'none';
        this.results.innerHTML    = '';
    }

    _showLoader() {
        this.hint.style.display   = 'none';
        this.loader.style.display = '';
        this.results.innerHTML    = '';
    }

    _showResults(html) {
        this.hint.style.display   = 'none';
        this.loader.style.display = 'none';
        this.results.innerHTML    = html;
    }

    _debounce(fn, ms) {
        let t;
        return (...args) => { clearTimeout(t); t = setTimeout(() => fn(...args), ms); };
    }
}

class InlineSearch {
    constructor({ inputId, apiUrl = '/api/search', debounceMs = 300, type = null, minChars = 2 }) {
        this.input = document.getElementById(inputId);
        this.apiUrl = apiUrl;
        this.debounceMs = debounceMs;
        this.type = type;
        this.minChars = minChars;

        this._dropdown = null;
        this._handleInput = this._debounce(this._onInput.bind(this), debounceMs);
        if (this.input) {
            this._init();
        }
    }

    _init() {
        const wrapper = document.createElement('div');
        wrapper.style.cssText = 'position:relative; display:inline-block; width:100%;';
        this.input.parentNode.insertBefore(wrapper, this.input);
        wrapper.appendChild(this.input);

        // Создаём dropdown
        this._dropdown = document.createElement('div');
        this._dropdown.className = 'inline-search-dropdown';
        this._dropdown.style.cssText = `
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            z-index: 1050;
            background: #fff;
            border: 1px solid #dee2e6;
            border-top: none;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 8px 24px rgba(0,0,0,.12);
            max-height: 250px;
            overflow-y: auto;
            color: #404040;
            text-align: left;
        `;
        wrapper.appendChild(this._dropdown);

        this.input.addEventListener('input', this._handleInput);
        this.input.addEventListener('focus', () => {
            if (this.input.value.trim().length >= this.minChars) {
                this._dropdown.style.display = '';
            }
        });

        // Закрыть при клике вне
        document.addEventListener('click', (e) => {
            if (!wrapper.contains(e.target)) this._hide();
        });

        // Клавиатурная навигация
        this.input.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') { this._hide(); this.input.blur(); }
        });
    }

    async _onInput() {
        const q = this.input.value.trim();
        if (q.length < this.minChars) { this._hide(); return; }

        this._showLoader();

        try {
            const data = await this._fetch(q);

            if (this.type) {
                // Если задан конкретный тип — старое поведение
                const items = data[this.type] ?? [];
                if (items.length === 0) {
                    this._render(this._renderEmpty(q));
                } else {
                    this._render(items.map(item => this._renderItem(item)).join(''));
                }
            } else {
                // Без типа — разделяем туры и статьи по секциям
                const tours    = data.tours    ?? [];
                const articles = data.articles ?? [];
                const total    = tours.length + articles.length;

                if (total === 0) {
                    this._render(this._renderEmpty(q));
                } else {
                    this._render(
                        this._renderSection('Туры', tours) +
                        this._renderSection('Статьи', articles)
                    );
                }
            }
        } catch {
            this._render(this._renderError());
        }
    }

    _renderSection(title, items) {
        if (!items.length) return '';
        return `
        <div style="padding:6px 14px 4px;font-size:11px;font-weight:700;color:#adb5bd;text-transform:uppercase;letter-spacing:.05em;background:#f8f9fa;border-bottom:1px solid #f1f3f5">
            ${title} (${items.length})
        </div>
        ${items.map(item => this._renderItem(item)).join('')}`;
    }

    _fetch(query) {
        const typeParam = this.type ? `&type=${this.type}` : '';
        return new Promise((resolve, reject) => {
            pbFetch.ajax({
                url: `${this.apiUrl}?q=${encodeURIComponent(query.toLowerCase())}${typeParam}`,
                expect: 'json',
                cancelKey: `inline-search-${this.input.id}`,
                success: (_, data) => resolve(data),
                error:   (_, data) => reject(new Error(data?.message || 'Network error')),
            });
        });
    }

    _renderItem(item) {
        const thumb = item.image
            ? `<img width="48" height="40" style="object-fit:cover;border-radius:4px;flex-shrink:0" src="${item.image}" alt="${item.title}" loading="lazy">`
            : `<div style="width:48px;height:40px;display:flex;align-items:center;justify-content:center;background:#f1f3f5;border-radius:4px;flex-shrink:0;font-size:18px">${item.type === 'tour' ? '✈️' : '📰'}</div>`;

        return `
        <a href="${item.url}" class="inline-search-item" rel="noopener" style="
            display:flex; align-items:center; gap:10px;
            padding:10px 14px; text-decoration:none; color:inherit;
            border-bottom:1px solid #f1f3f5; transition:background .15s;
        " onmouseover="this.style.background='#f8f9fa'" onmouseout="this.style.background=''">
            ${thumb}
            <div style="min-width:0; flex:1">
                <div style="font-size:13px;font-weight:600;white-space:nowrap;overflow:hidden;text-overflow:ellipsis">${item.title}</div>
                <div style="font-size:11px;color:#868e96;margin-top:2px"><i class="bi bi-calendar3"></i> ${item.date}</div>
            </div>
            <i class="bi bi-arrow-right" style="color:#adb5bd;flex-shrink:0"></i>
        </a>`;
    }

    _renderEmpty(q) {
        return `<div style="padding:16px;text-align:center;color:#868e96;font-size:13px">
            <i class="bi bi-emoji-frown"></i> Ничего не найдено по <strong>«${q}»</strong>
        </div>`;
    }

    _renderError() {
        return `<div style="padding:16px;text-align:center;color:#dc3545;font-size:13px">
            <i class="bi bi-exclamation-circle"></i> Ошибка. Попробуйте позже.
        </div>`;
    }

    _showLoader() {
        this._render(`<div style="padding:16px;text-align:center;color:#868e96;font-size:13px">
            <div class="spinner-border spinner-border-sm" role="status"></div> Поиск...
        </div>`);
    }

    _render(html) {
        this._dropdown.innerHTML = html;
        this._dropdown.style.display = '';
    }

    _hide() {
        this._dropdown.style.display = 'none';
    }

    _debounce(fn, ms) {
        let t;
        return (...args) => { clearTimeout(t); t = setTimeout(() => fn(...args), ms); };
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new Search({
        inputId:   'searchInput',
        hintId:    'searchHint',
        loaderId:  'searchLoader',
        resultsId: 'searchResults',
        modalId:   'searchModal',
        apiUrl:    '/api/search',
        triggerSelector: '[data-bs-target="#searchModal"]'
    });

    new InlineSearch({
        inputId: 'sliderSearchInput',
        apiUrl: '/api/search',
        debounceMs: 300,
    });

    new InlineSearch({
        inputId: 'blogSearchInput',
        apiUrl: '/api/search',
        type: 'articles',
        debounceMs: 300,
    });
});