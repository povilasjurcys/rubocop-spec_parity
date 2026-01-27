# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpecParity::NoLetBang do
  subject(:cop) { described_class.new }

  let(:msg) { "Do not use `let!`. Use `let` with explicit reference or `before` block instead." }

  describe "offenses" do
    it "registers an offense when using let!" do
      expect_offense(<<~RUBY)
        let!(:user) { create(:user) }
        ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
      RUBY
    end

    it "registers an offense when using let! with a symbol" do
      expect_offense(<<~RUBY)
        let!(:post) { Post.new }
        ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
      RUBY
    end

    it "registers an offense when using let! with a string" do
      expect_offense(<<~RUBY)
        let!("user") { User.new }
        ^^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
      RUBY
    end

    it "registers an offense for let! inside describe block" do
      expect_offense(<<~RUBY)
        describe User do
          let!(:user) { create(:user) }
          ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
        end
      RUBY
    end

    it "registers an offense for let! inside context block" do
      expect_offense(<<~RUBY)
        context "when logged in" do
          let!(:session) { create(:session) }
          ^^^^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
        end
      RUBY
    end

    it "registers an offense for nested let!" do
      expect_offense(<<~RUBY)
        describe User do
          context "with posts" do
            let!(:post) { create(:post) }
            ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
          end
        end
      RUBY
    end

    it "registers multiple offenses for multiple let! calls" do
      expect_offense(<<~RUBY)
        describe User do
          let!(:user) { create(:user) }
          ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
          let!(:post) { create(:post) }
          ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
        end
      RUBY
    end

    it "registers an offense for let! with complex block" do
      expect_offense(<<~RUBY)
        let!(:user) do
        ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
          User.create(
            name: "Test",
            email: "test@example.com"
          )
        end
      RUBY
    end

    it "registers an offense for let! inside shared_examples" do
      expect_offense(<<~RUBY)
        shared_examples "user examples" do
          let!(:user) { create(:user) }
          ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
        end
      RUBY
    end

    it "registers an offense for let! inside shared_context" do
      expect_offense(<<~RUBY)
        shared_context "with user" do
          let!(:user) { create(:user) }
          ^^^^^^^^^^^ RSpecParity/NoLetBang: #{msg}
        end
      RUBY
    end
  end

  describe "no offenses" do
    it "does not register an offense when using let" do
      expect_no_offenses(<<~RUBY)
        let(:user) { create(:user) }
      RUBY
    end

    it "does not register an offense when using before block" do
      expect_no_offenses(<<~RUBY)
        before { create(:user) }
      RUBY
    end

    it "does not register an offense when using before :each" do
      expect_no_offenses(<<~RUBY)
        before(:each) { create(:user) }
      RUBY
    end

    it "does not register an offense when using let inside describe" do
      expect_no_offenses(<<~RUBY)
        describe User do
          let(:user) { create(:user) }
        end
      RUBY
    end

    it "does not register an offense when using multiple let calls" do
      expect_no_offenses(<<~RUBY)
        describe User do
          let(:user) { create(:user) }
          let(:post) { create(:post) }
        end
      RUBY
    end

    it "does not register an offense for let with do-end block" do
      expect_no_offenses(<<~RUBY)
        let(:user) do
          User.create(name: "Test")
        end
      RUBY
    end

    it "does not register an offense for subject" do
      expect_no_offenses(<<~RUBY)
        subject(:user) { create(:user) }
      RUBY
    end

    it "does not register an offense for subject!" do
      expect_no_offenses(<<~RUBY)
        subject!(:user) { create(:user) }
      RUBY
    end

    it "does not register an offense for let_it_be (from test-prof)" do
      expect_no_offenses(<<~RUBY)
        let_it_be(:user) { create(:user) }
      RUBY
    end

    it "does not register an offense when let! is part of method name" do
      expect_no_offenses(<<~RUBY)
        def let!_something
          "test"
        end
      RUBY
    end
  end
end
