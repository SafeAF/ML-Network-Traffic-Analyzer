class HomeController < ApplicationController
  def index
    @globalIntelligence = {status: 'Operational', enemyHostsTracked: '13021', friendlyHosts: '25023', blockedAttacks: '219'   }

  end
end
