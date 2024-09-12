## 疑問

1. ユーザー登録とログイン画面で一部コードが重複しているがまとめるべき？
2. DRYはどれぐらい?

```haml
# app/views/devise/registrations
= f.label :email,"メールアドレス", class: "form-label"
= f.email_field :email, autofocus: true, autocomplete: "email", placeholder: "miniblog@example.com", class: "form-control"

```

```haml
# app/views/devise/sessions
 = f.label :email,"メールアドレス", class: "form-label"
 = f.email_field :email, autofocus: true, autocomplete: "email",placeholder: "miniblog@example.com", class: "form-control"
```
