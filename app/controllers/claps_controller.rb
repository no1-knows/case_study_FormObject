class ClapsController < ApplicationController
  def index
    @claps = Clap.all
  end
  def new
    @clap_registration_form = ClapRegistrationForm.new
  end

  def create
    @clap_registration_form = ClapRegistrationForm.new(clap_registration_form_params)
    if @clap_registration_form.save
      redirect_to :claps, notice: "#{@clap_registration_form.claps.size}件の商品を登録しました。"
    else
      render :new
    end
  end

  private

  def clap_registration_form_params
    params
        .require(:clap_registration_form)
        .permit(claps_attributes: Forms::Clap::REGISTRABLE_ATTRIBUTES)
  end
end
