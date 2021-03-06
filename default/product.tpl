{#
Description: Product Page
#}

{% extends 'base.tpl' %}

{% block content %}

	<article>

		<ul class="breadcrumb">
			<li><a href="{{ site_url() }}">Home</a><span class="divider">›</span></li>
			<li class="active">{{ product.title }}</li>
		</ul>

		<div class="row">

			<div class="span4">

				<a href="{{ product.image.full }}" class="box-medium fancy" rel="{{ product.id }}"><img src="{{ product.image.full }}" alt="{{ product.title|e_attr }}" class="product-image"></a>

				{% if product.images %}

					<div class="row thumbs hidden-phone">
						<div class="span1"><a href="{{ product.image.full }}" class="fancy" rel="{{ product.id }}"><img src="{{ product.image.square }}" alt="{{ product.title|e_attr }}"></a></div>
						{% for thumb in product.images %}
							<div class="span1"><a href="{{ thumb.full }}" class="fancy" rel="{{ product.id }}"><img src="{{ thumb.square }}" alt="{{ product.title|e_attr }}"></a></div>
						{% endfor %}
					</div>

				{% endif %}

				{% if product.video_embed_url %}

					<hr>
					<div class="row hidden-phone">
						<div class="span4 video-wrapper">
							<div class="video-iframe" data-src="{{ product.video_embed_url }}">Video</div>
						</div>
					</div>

				{% endif %}

			</div>

			<div class="span5">

				<h1 class="product-title">{{ product.title }}</h1>

				<div>
					<h4 class="price">

						{% if product.price_on_request == true %}
							<span class="data-product-price">Preço sob consulta</span> &nbsp;
							<del></del>
						{% else %}
							{% if product.promo == true %}
								<span class="data-product-price">{{ product.price_promo | money_with_sign }}</span> &nbsp;
								<del>{{ product.price | money_with_sign }}</del>
							{% else %}
								<span class="data-product-price">{{ product.price | money_with_sign }}</span> &nbsp;
								<del></del>
							{% endif %}
						{% endif %}

					</h4>

					<p><small class="muted data-promo-percentage">
						{% if product.price_promo_percentage == true %}
							Desconto de {{ product.price_promo_percentage }}%
						{% endif %}
					</small></p>
				</div>

				<br>

				{{ form_open_cart(product.id, { 'class' : 'well form-inline form-cart add-cart' }) }}

					<h4>Adicionar ao carrinho</h4>

					{% if product.reference %}
						<h6><small>Referência: <span class="sku">{{ product.reference }}</span></small></h6>
					{% endif %}

					<br>

					{% if product.status == 1 or (product.status == 3 and product.stock.stock_backorder) %}

						{% if product.option_groups %}
							{% for option_groups in product.option_groups %}

								<h6>{{ option_groups.title }}</h6>

								<select class="span3 select-product-options" name="option[]">
									{% for option in option_groups.options %}

										<option value="{{ option.id }}" data-title="{{ option.title }}">
											{{ option.title }}

											{% if option.price_on_request == true %}
												- Preço sob consulta
											{% else %}
												{% if option.price is not null %}
													{% set option_display_price = option.promo ? option.price_promo : option.price %}
													- {{ option_display_price | money_with_sign }}
												{% endif %}
											{% endif %}
										</option>

									{% endfor %}
								</select>

							{% endfor %}

							<hr>

						{% endif %}

						<div class="data-product-info">
							Quantidade &nbsp;
							<input type="number" class="span1" name="qtd" value="1" {% if product.stock.stock_sold_single %} data-toggle="tooltip" data-placement="bottom" data-original-title="Só é possível comprar 1 unidade deste produto." title="Só é possível comprar 1 unidade deste produto." readonly {% endif %}>
							<button class="btn btn-inverse" type="submit">
								<i class="fa fa-shopping-cart fa-lg fa-fw"></i> Comprar
							</button>

							{% if product.tax > 0 %}
								<hr>
								{% if store.taxes_included == false %}
									<span class="muted">Ao preço acresce IVA a {{ product.tax }}%</span>
								{% else %}
									<span class="muted">IVA incluído</span>
								{% endif %}
							{% endif %}

							{% if product.stock.stock_show %}
								<hr>
								<h6>Stock</h6>
								<em class="muted"><span class="data-product-stock_qty">{{ product.stock.stock_qty }}</span> unidades em stock</em>
							{% endif %}
						</div>

						<div class="data-product-on-request">
							<a class="btn btn-inverse price-on-request" href="{{ site_url("contact?p=") ~ "Produto #{product.title}"|url_encode }}">
								<i class="fa fa-envelope-o fa-lg fa-fw"></i> Contactar
							</a>
						</div>

					{% elseif product.status == 3 %}
						<div class="alert alert-info">O produto encontra-se sem stock.</div>

					{% elseif product.status == 4 %}
						<div class="alert alert-info">O produto estará disponível brevemente.</div>

					{% endif %}

					{% if user.is_logged_in %}
						<div class="wishlist margin-top-sm">
							{% if not product.wishlist.status %}
								<a href="{{ product.wishlist.add_url }}" class="text-muted"><i class="fa fa-heart fa-fw"></i> Adicionar à wishlist</a>
							{% else %}
								<a href="{{ product.wishlist.remove_url }}" class="text-muted"><i class="fa fa-heart-o fa-fw"></i> Remover da wishlist</a>
							{% endif %}
						</div>
					{% endif %}

				{{ form_close() }}

				<div class="description">{{ product.description }}</div>

				{% if product.file %}
					<div class="well well-small">
						<h6 style="margin-top:0">Ficheiro Anexo</h6>
						<a class="btn file-download" href="{{ product.file }}" target="_blank"><i class="fa fa-download"></i> <strong>Download</strong></a>
					</div>
				{% endif %}

				<hr>

				<div class="share">
					<a target="_blank" href="http://www.facebook.com/sharer.php?u={{ product.url }}" class="text-muted"><i class="fa fa-lg fa-facebook fa-fw"></i></a> &nbsp;
					<a target="_blank" href="https://wa.me/?text={{ "#{product.title}: #{product.url}"|url_encode }}" class="text-muted"><i class="fa fa-lg fa-whatsapp fa-fw"></i></a> &nbsp;
					<a target="_blank" href="https://twitter.com/share?url={{ product.url }}&text={{ character_limiter(description, 100)|url_encode }}" class="text-muted"><i class="fa fa-lg fa-twitter fa-fw"></i></a> &nbsp;
					<a target="_blank" href="https://pinterest.com/pin/create/bookmarklet/?media={{ product.image.full }}&url={{ product.url }}&description={{ product.title|url_encode }}" class="text-muted"><i class="fa fa-lg fa-pinterest fa-fw"></i></a>
				</div>

			</div>

		</div>

	</article>

	{% if apps.facebook_comments.comments_products %}
		<div class="hidden-phone">
			<hr>
			<div class="fb-comments" data-href="{{ product.permalink }}" data-num-posts="5" data-colorscheme="light" data-width="100%"></div>
		</div>
	{% endif %}

{% endblock %}