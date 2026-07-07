<div class="d-block d-lg-none mobile-menu position-fixed z-100 bottom-0 start-0 w-100">
    {set $hash = [
    ['title' => 'Описание', 'link' => 'about'],
    ['title' => 'Программа', 'link' => 'plan'],
    ['title' => 'Гиды', 'link' => 'team'],
    ['title' => 'Стоимость', 'link' => 'price'],
    ['title' => 'Отзывы', 'link' => 'reviews'],
    ['title' => 'Снаряга', 'link' => 'equipment'],
    ['title' => 'FAQ', 'link' => 'faq'],
    ['title' => 'Заявка', 'link' => 'booking'],
    ]}

    <ul class="list-unstyled position-relative d-flex gap-4 text-white">
        {foreach $hash as $item}
            <li class="nav-item">
                <a class="nav-link fw-bold" href="{$modx->resource->uri}#{$item.link}">{$item.title}</a>
            </li>
        {/foreach}
        <li class="nav-item">
            <a class="nav-link fw-bold{$modx->resource->alias == 'go' ? " active": ""}" href="{$modx->resource->uri}/go">Страховка</a>
        </li>
    </ul>
</div>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const mobileMenu = document.querySelector('.mobile-menu ul');
        if (!mobileMenu) return;

        document.addEventListener('activate.bs.scrollspy', (e) => {
            const activeHref = e.relatedTarget.href.replace(location.origin + '/', '');
            // console.log(activeHref);

            mobileMenu.querySelectorAll('.nav-link').forEach(link => {
                link.classList.remove('active');
            });

            // Ставим active на соответствующую мобильную ссылку
            const mobileActive = mobileMenu.querySelector(`.nav-link[href$="${ activeHref }"]`);
            if (!mobileActive) return;

            mobileActive.classList.add('active');

            const li = mobileActive.closest('li');
            mobileMenu.scrollTo({
                left: li.offsetLeft - 12,
                behavior: 'smooth'
            });
        });

        let isDown = false, startX, scrollLeft;

        mobileMenu.addEventListener('mousedown', e => {
            isDown = true;
            mobileMenu.style.cursor = 'grabbing';
            startX = e.pageX - mobileMenu.offsetLeft;
            scrollLeft = mobileMenu.scrollLeft;
        });
        mobileMenu.addEventListener('mouseleave', () => { isDown = false; mobileMenu.style.cursor = ''; });
        mobileMenu.addEventListener('mouseup', () => { isDown = false; mobileMenu.style.cursor = ''; });
        mobileMenu.addEventListener('mousemove', e => {
            if (!isDown) return;
            e.preventDefault();
            mobileMenu.scrollLeft = scrollLeft - (e.pageX - mobileMenu.offsetLeft - startX);
        });
    });
</script>