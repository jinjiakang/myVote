class CandidatesController < ApplicationController
  
  before_action :find_candidate,
    only: [:show, :edit, :update, :destory, :vote]
  
  def index
    @candidates = Candidate.all
  end
  
  def show
    
    @candidate = Candidate.find_by(id: params[:id])
  
  end
  
  def vote
    log = Log.new(candidate: @candidate, ip_address:request.remote_ip)
    @candidate.logs << log
    @candidate.save
#     @candidate.vote
    redirect_to candidates_path, notice: "done!"
  
  end
#    before_caction <-- :vote

  def new
   
    @candidate = Candidate.new
    
  end
  
  def create
    @candidate = Candidate.new(candidate_params)
    
   if @candidate.save
      redirect_to candidates_path, notice: "Creat new data !!"
   else
     render 'new' 
#        redirect_to new_candidate_path
   end
    
  end
    
  def edit

  end

  def update
    
   if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: " updated !!"
   else
     render 'edit' 
   end
 
  end
    
  
  
  def destroy
     @candidate = Candidate.find_by(id: params[:id])
     @candidate.destroy
     # flash[:notice]="Delete one data !!"
     redirect_to candidates_path, notice:" Delete one data !! (simple method)"
  end
  
  private
  def candidate_params
    params.require("candidate").permit(:name,:party,:age,:politics)
  end
  
  def find_candidate
     @candidate = Candidate.find_by(id: params[:id])
     redirect_to candidate_path,notice: "no data !!" if @candidate.nil?
  end
 
 end
