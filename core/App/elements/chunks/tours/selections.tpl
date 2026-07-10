<section class="selections pb-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="font-cofo text-center text-uppercase mb-3 d-none d-md-block">{$title}</h2>
            </div>

            {foreach $items as $item}
                <div class="col-12">
                    <h3 class="font-cofo-m fw-bold mb-3">{$item.title}</h3>
                    {set $tours = model('Tour')->with(['dates', 'image', 'images', 'authors'])->published()}
                    {set $filter = []}

                    {if $item.country}
                        {set $tours = $tours->where('country_id', $item.country)}
                    {/if}

                    {if $item.data_from && $item.data_to}
                        {set $filter = [
                            'date_from' => $item.data_from|date:'Y-m-d',
                            'date_to' => $item.data_to|date:'Y-m-d',
                        ]}
                    {/if}

                    {if $item.people}
                        {set $tours = $tours->withMinPeople($item.people)}
                        {set $filter['people'] = $item.people}
                    {/if}

                    {if $item.tour_type}
                        {set $tours = $tours->withTypeTour($item.tour_type)}
                    {/if}

                    {if $item.tours}
                        {set $tourIds = []}
                        {foreach $item.tours as $tid}{if $tid}{set $tourIds[] = $tid}{/if}{/foreach}
                        {if $tourIds}
                            {set $tours = $tours->whereIn('tours.id', $tourIds)}
                            {set $limit = $tourIds|length}
                        {/if}
                    {/if}

                    {set $tours = $tours->open($filter)->limit($limit?:4)}

                    {set $tours = $tours->get()}
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-3 mb-5">
                        {foreach $tours as $tour}
                            {insert 'file:chunks/tours/card2.tpl'}
                        {/foreach}
                    </div>
                </div>
            {/foreach}

            <div class="col-12 text-center">
                <a href="/tours?view=list" class="d-inline-flex align-items-center gap-4">
                    <img loading="lazy" src="/assets/images/content/icons/tour-all.svg" width="118" height="111" alt="">
                    <h5 class="text-start fw-bold text-gray mb-0 text-decoration-underline">Календарь <br>всех путешествий</h5>
                </a>
            </div>
        </div>
    </div>
    
    <style>
    
    
    @media (max-width: 768px) {
        .font-cofo-m {
            font-size:1.2rem;
            text-align:center;
            font-family: CoFo, sans-serif;
            text-transform: uppercase !important;
        }
    }
    </style>
    {insert 'file:chunks/tours/card2-assets.tpl'}
</section>