  # Define a command that signs up a user.


  ### WIP THIS WILL NOT RUN


module Users
  class Signup < Mutations::Command

    # These inputs are required
    required do
      # string :email, matches: EMAIL_REGEX
      string :name
    end

    # These inputs are optional
    optional do
      # boolean :newsletter_subscribe
    end

    # The execute method is called only if the inputs validate. It does your business action.
    def execute
      puts "i like pizza and " + name
      # user = User.create!(inputs)
      # NewsletterSubscriptions.create(email: email, user_id: user.id) if newsletter_subscribe
      # UserMailer.async(:deliver_welcome, user.id)
      # user
    end
  end
end
