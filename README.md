# RailsAdminCMS

## Body classes helper

Seamlessly adds some useful classes to the body tag within your layout in order to scope your css/js : `cms-template-name`, `controller-name`, `controller-name-action-name`, `locale` and `edit-mode`.

```ruby
# ...
</head>
<body class="<%= cms_body_class 'other-class', 'etc' %>">
# ...
</body>
</html>
```

This project rocks and uses MIT-LICENSE.