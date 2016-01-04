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
* Published Pages/Forms
* Keep the Locale within the DB after form submission
* Mailchimp integration
* More Specs

## Notes

gem 'dalli-delete-matched' needed if Memcached is used


This project rocks and uses MIT-LICENSE.