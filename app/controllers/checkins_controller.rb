class CheckinsController < ApplicationController
  before_filter :check_client_ip_address
  load_and_authorize_resource
  before_filter :get_user_if_nil
  helper_method :get_basket
  cache_sweeper :page_sweeper, :only => [:create, :update, :destroy]
  
  # GET /checkins
  # GET /checkins.xml
  def index
    # かごがない場合、自動的に作成する
    unless get_basket
      @basket = Basket.create!(:user => current_user)
      redirect_to user_basket_checkins_url(@basket.user, @basket)
      return
    end
    @checkins = @basket.checkins.all(:order => ['checkins.created_at DESC'])

    @checkin = @basket.checkins.new

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @checkins.to_xml }
      format.js
    end
  end

  # GET /checkins/1
  # GET /checkins/1.xml
  def show
    #@checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @checkin.to_xml }
    end
  end

  # GET /checkins/new
  def new
    #@checkin = @basket.checkins.new
    redirect_to checkins_url
  end

  # GET /checkins/1;edit
  def edit
    #@checkin = Checkin.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.xml
  def create
    @second = Benchmark.realtime do
    @checkin = get_basket.checkins.new(params[:checkin])

    flash[:message] = []
    if @checkin.item_identifier.blank?
      flash[:message] << t('checkin.enter_item_identifier') if @checkin.item_identifier.blank?
    else
      item = Item.where(:item_identifier => @checkin.item_identifier.to_s.strip).first
    end

    unless item.blank?
      if @basket.checkins.collect(&:item).include?(item)
        redirect_to user_basket_checkins_url(@basket.user, @basket, :mode => 'list')
        flash[:message] << t('checkin.already_checked_in')
        return
      end
      @checkin.item = item

      respond_to do |format|
        # 速度を上げるためvalidationを省略している
        if @checkin.save(:validate => false)
          #flash[:message] << t('controller.successfully_created', :model => t('activerecord.models.checkin'))
          flash[:message] << t('checkin.successfully_checked_in', :model => t('activerecord.models.checkin'))
          Checkin.transaction do
            checkout = Checkout.not_returned.where(:item_id => @checkin.item.id).first
            # TODO: 貸出されていない本の処理
            # TODO: ILL時の処理
            @checkin.item.checkin!
            if checkout
              checkout.checkin = @checkin
              checkout.save(:validate => false)
              unless checkout.item.shelf.library == current_user.library
                flash[:message] << t('checkin.other_library_item')
              end
            end

            #unless checkout.user.save_checkout_history
            #  checkout.user = nil
            #end
            if @checkin.item.reserved?
              # TODO: もっと目立たせるために別画面を表示するべき？
              flash[:message] << t('item.this_item_is_reserved')
              @checkin.item.retain(current_user)
            end

            if @checkin.item.include_supplements?
              flash[:message] << t('item.this_item_include_supplement')
            end

            # メールとメッセージの送信
            #ReservationNotifier.deliver_reserved(@checkin.item.manifestation.reserves.first.user, @checkin.item.manifestation)
            #Message.create(:sender => current_user, :receiver => @checkin.item.manifestation.next_reservation.user, :subject => message_template.title, :body => message_template.body, :recipient => @checkin.item.manifestation.next_reservation.user)
          end
        
          if params[:mode] == 'list'
            redirect_to(user_basket_checkins_url(@checkin.basket.user, @checkin.basket, :mode => 'list'))
            return
          else
            format.html { redirect_to user_basket_checkins_url(@checkin.basket.user, @checkin.basket) }
            format.xml  { render :xml => @checkin, :status => :created, :location => user_basket_checkin_url(@checkin.basket.user, @checkin.basket, @checkin) }
          end
        else
          if params[:mode] == 'list'
            redirect_to user_basket_checkins_url(@basket.user, @basket, :mode => 'list')
            return
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @checkin.errors.to_xml }
          end
        end
      end
    else
      flash[:message] << t('checkin.item_not_found')
      if params[:mode] == 'list'
        redirect_to user_basket_checkins_url(@basket.user, @basket, :mode => 'list')
      else
        redirect_to user_basket_checkins_url(@basket.user, @basket)
      end
    end
    end
  end

  # PUT /checkins/1
  # PUT /checkins/1.xml
  def update
    #@checkin = Checkin.find(params[:id])
    @checkin.item_identifier = params[:checkin][:item_identifier] rescue nil
    unless @checkin.item_identifier.blank?
      item = Item.where(:item_identifier => @checkin.item_identifier.to_s.strip).first
    end
    @checkin.item = item

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        flash[:notice] = t('controller.successfully_updated', :model => t('activerecord.models.checkin'))
        format.html { redirect_to checkin_url(@checkin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkin.errors.to_xml }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.xml
  def destroy
    #@checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.xml  { head :ok }
    end
  end
end
