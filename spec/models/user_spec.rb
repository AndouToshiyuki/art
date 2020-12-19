require 'rails_helper'

RSpec.describe User, type: :model do
  # 名、メール、パスワードがあれば有効な状態であること
  it "is valid with a name, email, and password" do
  user = User.new(
    name: "abc",
    email: "tester@example.com",
    password: "dottle-nouveau-pavilion-tights-furze",
    password_confirmation: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end
  # 名がなければ無効な状態であること
  it "is invalid without a name" do
    user = User.new(name:nil)
    user.valid?
    expect(user.errors[:name]).to include("が入力されていません")
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email" do
    user = User.new(email:nil)
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません")
  end
  # パスワードがなければ無効な状態であること
  it "is invalid without an password" do
    user = User.new(password:nil)
    user.valid?
    expect(user.errors[:password]).to include("が入力されていません")
  end
  # 確認用パスワードがなければ無効な状態であること
  it "is invalid without a password_confirmation although with a password" do
    user = User.new(
      password: "dottle-nouveau-pavilion-tights-furze",
      password_confirmation: "",
      )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email" do
    User.create(
      name:  "Joe",
      email:  "tester@example.com",
      password:  "dottle-nouveau-pavilion-tights-furze",
      )
    user = User.new(
    name: "Jane",
    email: "tester@example.com",
    password:   "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end
