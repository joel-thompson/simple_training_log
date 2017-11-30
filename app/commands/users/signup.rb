module Users
  class Signup < Mutations::Command

    # These inputs are required
    required do
      string :email
      string :name
      string :password
      string :password_confirmation
    end

    # These inputs are optional
    optional do
      boolean :activated, default: false
      boolean :admin, default: false
    end

    # The execute method is called only if the inputs validate. It does your business action.
    def execute
      user = User.create(
        email: email,
        name: name,
        password: password,
        password_confirmation: password_confirmation,
        admin: admin
      )

      if user.valid?
        activated ? user.activate : user.send_activation_email
      else
        add_validation_errors(user.errors)
      end
      user

    end
  end
end
