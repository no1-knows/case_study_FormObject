class Forms::Clap < Clap
  REGISTRABLE_ATTRIBUTES = %i(register user_id post_id)
  attr_accessor :register
end
