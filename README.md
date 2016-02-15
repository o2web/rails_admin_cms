# RailsAdminCMS

*Flexible Content Management Framework for RailsAdmin*

## Overview

RailsAdmin...

## Features

### View helpers example

There is an example of a common template using some of the cms view helpers:

```ruby
<!DOCTYPE html>
<html>
<head>
  <title><%= title = cms_title('AppRailsAdminCMS') %></title>
  <%= cms_meta_data_tags %>
  <%= cms_meta_og_tags(title) %>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body class="<%= cms_body_class('shop', 'cart') %>">

<%= cms_flash_messages %>
<div>
  <%= cms_locale_selector %>
</div>
<div>
  <%= cms_link_to_edit_mode if current_admin? %>
</div>

<%= yield %>

</body>
</html>
```

What's going on:

1. `cms_title` outputs a title tag defined by either a view element or a default one passed as argument
1. `cms_meta_data_tags` outputs the meta keywords + description tags defined by either a page/form object or a complete default one passed as argument
1. `cms_body_class` outputs 
1. `cms_flash_messages`
1. `cms_locale_selector`
1. `cms_link_to_edit_mode`
1. `current_admin?`


### Content management

#### Pages

Create your page templates by adding files in the `app/views/cms/pages/` folder. You can then add any other CMS element inside those templates. Don't forget to create the route to be able to access the page.

By adding `<% view = cms_page %>` at the top of your page, your page will now be clonable. You'll be able to use this page as a basis for your static pages. Just add the following elements in your page to create the links to create `<%= view.add_link %>` or edit `<%= view.edit_link %>` your page.

When creating a new page, you'll be able to assign an URL, a title, the meta-description and meta-keywords for the page.

If you need to have a reusable page template with different contents on each new page, you can create element using `cms_view_image` (or any other viewable) instead of `cms_image`. This way, you'll have a copy of element, without the contents.

#### Blocks

Blocks are the equivalent of a CMS partial that you can add to your page. You use them by creating a template in the `app/views/cms/blocks/` folder. You can then create any CMS element inside those blocks and insert them into your pages.

Here is an example of block insertion with a template named **_example.html.erb**

```
<% 
# you'll be able to insert between 1 and 4 instances of this block
blocks = cms_example('block_name', 1, 4) 
%>

<% blocks.each do |block| %>
  <%= block.render %>
  <%= block.edit_link %>
<% end %>
<%= blocks.add_link %>

```

#### Texts

Texts allow you to enter content on your page with a WYSIWYG editor. You'll be able to edit a title field and a text field so you can add basic texts blocks in your application.

Here's how you use texts blocks

```
<% 
# you'll be able to insert between 1 and 3 blocks of text
texts = cms_text('text_name', 1, 3) 
%>

<% texts do |text| %>
  <%= text.title %>
  <%= text.text %>
  <%= text.edit_link %>
<% end %>
<%= text.add_link %>
```

#### Strings

Strings works just like texts. The element contains a single string (255) editable field.

```
<% 
  # Declaration of the element
  my_string = cms_string('string_name') 
%>
  <%= my_string.string %>
  <%= my_string.edit_link %>
```

#### Links

Use this element to create links in your pages. They function like texts blocks, they however have some other options.

```
<%
  # First, create the link element
  menu = cms_link('link_name', 0, Float::INFINITY)
%>
```
```
# link_to: Create a simple link element
<% menu.each do |link| %>
  <%= link.li_link %>
<% end %>
```
```
# li_link_to: Create a link element wrapped with <li>
<ul>
<% menu.each do |link| %>
  <%= link.li_link_to %>
<% end %>
</ul>
```
```
# li_link_to_with_edit: Add link wrapped with <li> with edit link
<ul>
<% menu.each do |link| %>
  <%= link.li_link_to_with_edit %>
<% end %>
</ul>
```
```
# youtube_embed_url: Returns an iframe with embeded Youtube video
<% menu.each do |link| %>
  <%= link.youtube_embed_url %>
<% end %>
```
```
# url: Insert only the url of the link
<% menu.each do |link| %>
  <a href="<%= link.url %>">A nice link</a>
<% end %>
```

#### Class Selector

Using the Class Selector element, you'll be able to allow the administrator to add classes to element. It's main usage is to allow the selection between the classes that creates icons.

First, you'll need to provide an array containing the classes in the rails_admin_cms initializer using the `class_list` parameter. Then, you'll be able to edit the element and choose one of the provided classes and add some more if you need to.

How to use it:

```
<% 
  # Declaration of the element
  my_classes = cms_class_selector('cs_name') 
%>
  <%= my_classes.classes %>
  <%= my_classes.edit_link %>
```


## Mailchimp

First, `mailchimp_api_key` and `mailchimp_list_id_en` (and `mailchimp_list_id_xx` where `xx` is the locale) need to be defined within `config/secrets.yml`.
Then, use the partial `app/views/cms/shared/_mailchimp.html.erb` to output the mailchimp form:

```ruby
<%= render 'cms/shared/mailchimp' %>
```

1. Flash messages could be overriden by the keys `flash_messages.mailchimp.subscribe.(success|error)`.
1. Input placeholder could be overriden by the key `simple_form.placeholders.mailchimp.email`. 
1. Input and submit button are wrapper in a div tag with the class `cms-mailchimp`. 

## TODO

* Documentation
* Generators
* Setup CanCanCan
* Setup Globalize on Form::Field and Form::Email
* Improve breadcrumbs functionality
* Link to image edit in edit form (for cropping)
* Confirmation email for forms
* Published Pages/Forms
* Redirector
* Setting fetched from Yaml file
* Pretty Url for Viewable::LinkPresenter#url as file_url
* Fetch image size based on Screen size
* More Specs

## Notes

gem 'dalli-delete-matched' needed if Memcached is used


This project rocks and uses MIT-LICENSE.
