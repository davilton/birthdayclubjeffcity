class MailingList 
  def self.subscribe(user)
    self.delay.subscribe_delayed(user)
  end

  def self.subscribe_delayed(user)
    api = Mailchimp::API.new(MC_APIKEY)
    api.listSubscribe(:id => MC_LIST_ID, 
                      :email_address => user.email, 
                      :merge_vars => get_merge_vars(user), 
                      :email_type => 'html', 
                      :double_optin => false, 
                      :update_existing => true, 
                      :replace_interests => false, 
                      :send_welcome => false )
  end

  def self.get_merge_vars(user)
    return { 'FNAME' => user.first_name, 'LNAME' => user.last_name, 'BDAY' => user.short_birthdate } 
  end

end

