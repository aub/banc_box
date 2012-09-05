# BancBox #
A Ruby wrapper for BancBox's REST API.

## <a name="installation"></a>Install
    gem install banc_box

## <a name="configuration"></a>Configure

    require 'banc_box'

    BancBox.configure do |config|
      config.api_key = API_KEY
      config.api_secret = API_SECRET
      config.base_url = BANCBOX_BASE_URL
      config.subscriber_id = SUBSCRIBER_ID
    end

## <a name="usage"></a>Use

Now you can do clever things like creating an account:

    BancBox.create_client{
      :first_name => 'Bozo',
      :last_name => 'Clown',
      :ssn => '555-55-5555',
      :dob => Date.today - 10000,
      :address => BancBox::Address.new(
        :line1 => '64 Elm St.',
        :city => 'Brooklyn',
        :state => 'NY',
        :zipcode => '11238'
      ),
      :home_phone => '5555555555',
      :email => 'aubreyholland@gmail.com'
    }

Or collect funds:

    BancBox.collect_funds(
      :method => 'creditcard',
      :destination_account_id => BancBox::Id.new(:banc_box_id => 'xxxx'),
      :debit_items => [
        BancBox::DebitItem.new(:amount => 0.54, :memo => 'test debit')
      ],
      :source => {
        :external_account => BancBox::CreditCardAccount.new(
          :number => '4111111111111111',
          :expiry_month => '01',
          :expiry_year => '17',
          :type => 'VISA',
          :name => 'Aubrey Holland',
          :cvv => '555',
          :address => BancBox::Address.new(
            :line1 => '64 Elm St.',
            :city => 'Brooklyn',
            :state => 'NY',
            :zipcode => '11238'
          )
        )
      }
    )

## <a name="todo"></a>Todo

The following endpoints have not yet been implemented:

+ linkFile
+ getSchedules
+ cancelSchedules
+ collectFees
+ linkPayee
+ searchBancBoxPayees
+ getClientLinkedPayees
+ updateLinkedPayee
+ sendFunds
+ linkExternalAccount
+ updateAccount
+ getClientAccounts
+ getClientLinkedExternalAccounts
+ getAccountActivity
+ updateLinkedExternalAccount
+ closeAccount
+ deleteLinkedExternalAccount

## <a name="documentation"></a>Learn
[http://rdoc.info/github/aub/banc_box][documentation]

[documentation]: http://rdoc.info/github/aub/banc_box

## <a name="copyright"></a>Copyright
Copyright (c) 2012 Aubrey Holland
See [LICENSE][] for details.

[license]: https://github.com/aub/banc_box/blob/master/LICENSE.md

