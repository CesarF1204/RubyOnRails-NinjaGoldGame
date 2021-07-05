class RpgController < ApplicationController
    def index
        if session[:gold].nil? || session[:gold] < 0
            session[:gold] = 0
        end
        if session[:activity].nil?
            session[:activity] = ['']
        end
    end
    def process_gold
        if params[:location].include? 'farm'
            farm
        elsif params[:location].include? 'cave'
            cave
        elsif params[:location].include? 'house'
            house
        elsif params[:location].include? 'casino'
            casino
        end
        redirect_to('/')
    end
    def restart_game
        session.clear
        redirect_to('/')
    end

    private
    def farm
        gold = rand(10..20)
        session[:gold] += gold
        current_datetime = DateTime.now.strftime("%Y/%m/%d %I:%M %P")
        activity("Earned #{gold} golds from the farm! (#{current_datetime})")
    end
    def cave
        gold = rand(5..10)
        session[:gold] += gold
        current_datetime = DateTime.now.strftime("%Y/%m/%d %I:%M %P")
        activity("Earned #{gold} golds from the cave! (#{current_datetime})")
    end
    def house
        gold = rand(2..5)
        session[:gold] += gold
        current_datetime = DateTime.now.strftime("%Y/%m/%d %I:%M %P")
        activity("Earned #{gold} golds from the house! (#{current_datetime})")
    end
    def casino
        gold = rand(-50..50)
        session[:gold] += gold
        current_datetime = DateTime.now.strftime("%Y/%m/%d %I:%M %P")
        if gold >= 0
            activity("Earned #{gold} golds from the casino! (#{current_datetime})")
        elsif gold < 0
            activity("Entered a casino and lost #{gold}... Ouch... (#{current_datetime})")
        end
        
    end
    def activity(message)
        i = session[:activity].length
        while i > 0
            session[:activity][i] = session[:activity][i-1]
            i -= 1
        end
        session[:activity][0]=message
    end
end
