module WelcomeHelper

  def weight_placeholder_text
    current_user.body_weight_records.any? ? 'Update Your Weight' : 'Add Your Weight'
  end
end
