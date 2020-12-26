require 'rails_helper'

RSpec.describe Post, type: :model do
  #contentが空白だと無効
  it "is invalid without content" do
    post = Post.new(content:nil)
    post.valid?
    expect(post.errors[:content]).to include("投稿できませんでした")
  end
  #contentは50字以内でなければ無効
  it "is invalid 51 words or more content" do
    post = Post.new(content: "aaaaaaaaaa,bbbbbbbbbb,cccccccccc,dddddddddd,eeeeeee")
    post.valid?
    expect(post.errors[:content]).to include("投稿できませんでした")
  end
  #save_tag
    describe '#save_tag' do
    subject { post.save_tag(['tag1', 'tag2']) }
    let(:post) { Post.create(content: "aaaaa,bbbbbbb,ccccc") }
    it do
      Tag.create(tag_name: 'tag1')
      Tag.create(tag_name: 'tag3')
      subject
      expect(Tag.all.count).to eq(3)
    end
  end
end
