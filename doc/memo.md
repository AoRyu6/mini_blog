## 疑問

1. ユーザー登録とログイン画面で一部コードが重複しているがまとめるべき？

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

2. DRYはどれぐらい?

3.stringとtextの使い分け

- 要件は200字以内
- 将来的に拡張したくなった時にstringだと困る?(stringは255まで,textは無制限)

```rb
# frozen_string_literal: true

class AddBiographyToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column(:users, :biography, :text, null: false, default: "")
  end
end


```

4.db側にも制限を設けるべき?

- 200字の場合dbも200字?

5. urlのバリデーション

- blog_urlをユーザーが持ってる際のurlはバリデーションするのか?
- 長さだけをバリデーションするのが確実?
