require 'rails_helper'

RSpec.describe FunctionalThresholdPowerRecordsController, type: :controller do

  fixtures :users
  fixtures :functional_threshold_power_records

  let(:user) { users(:user_with_ftp_records) }
  let(:other_user) { users(:archer) }
  let(:record) { functional_threshold_power_records(:most_recent) }

  

end
