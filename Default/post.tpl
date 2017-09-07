{# 
Description: Blog post Page
#}

{% extends 'base.tpl' %}

{% block content %}

	<ul class="breadcrumb">
		<li><a href="/">Home</a><span class="divider">›</span></li>
		<li><a href="{{ site_url('blog') }}">Blog</a><span class="divider">›</span></li>
		<li class="active">{{ blog_post.title }}</li>
	</ul>

	<h1>{{ blog_post.title }}</h1>
		
	<p><small class="muted"><em>Escrito em <strong>{{ blog_post.date|date("d \\d\\e M. \\d\\e Y") }}</strong></em></small></p>
		
	<div class="row">
			
		<div class="span6">
			{{ blog_post.text }}
		</div>
			
		{% if blog_post.image %}
			<p class="span3"><a href="{{ blog_post.image.full }}" class="box-medium fancy"><img src="{{ blog_post.image.thumb }}" alt="{{ blog_post.title }}"></a></p>
		{% endif %}
			
	</div>
	
	<br>
	<div class="row visible-desktop">
		<div class="span2">
			<div class="fb-like" data-send="true" data-width="" data-show-faces="false" data-font="tahoma" data-layout="button_count" data-action="like"></div>
		</div>

		<div class="span1">
			<g:plusone size="medium"></g:plusone>
		</div>

		<div class="span1">
			<a href="http://twitter.com/share" class="twitter-share-button" data-count="none" data-lang="pt">Tweet</a>
		</div>

		<div class="span1">
			<a href="http://pinterest.com/pin/create/button/?url={{ blog_post.url }}&media={{ blog_post.image.full }}&description={{ description }}" class="pin-it-button" count-layout="horizontal"><img border="0" src="//assets.pinterest.com/images/PinExt.png" title="Pin It" /></a>
		</div>
	</div>

	{% if apps.facebook_comments.comments_blog %}
		<div class="hidden-phone">
			<hr>
			<div class="fb-comments" data-href="{{ current_url() }}" data-num-posts="5" data-colorscheme="light" data-width="100%"></div>
		</div>
	{% endif %}

{% endblock %}