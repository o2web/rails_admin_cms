# RailsAdminCMS

*Flexible Content Management Framework for RailsAdmin*

## Overview

RailsAdmin...

## View helpers

Seamlessly adds some useful classes to the body tag within your layout in order to scope your css/js : `cms-template-name`, `controller-name`, `controller-name-action-name`, `locale` and `edit-mode`.

```ruby
# ...
</head>
<body class="<%= cms_body_class 'other-class', 'etc' %>">
# ...
</body>
</html>
```

## TODO

* Documentation
* Generators
* Setup CanCanCan
* Setup Globalize on Form::Field and Form::Email
* Improve breadcrumbs functionality
* Link to image edit in edit form (for cropping)
* Published Pages/Forms
* Mailchimp integration
* Redirector
* Setting fetched from Yaml file
* Pretty Url for Viewable::LinkPresenter#url as file_url
* Fetch image size based on Screen size
* More Specs

## Notes

gem 'dalli-delete-matched' needed if Memcached is used


This project rocks and uses MIT-LICENSE.