class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
      
    elsif user.role? :manager
      can :read, :all 
      can :create, User do |i|  
        i if i.role == :manager || i.role == :shipper
      end
      can :edit, User do |i|  
        i if i.role == :manager || i.role == :shipper
      end
      can :read, User do |i|  
        i if i.role == :manager || i.role == :shipper || i.role == :customer
      end
      can :create, :item
      can :create, :school
      can :edit, :item
      can :update, :item
      can :destroy, :item

    elsif user.role? :shipper
      can :read, User
      can :edit, User
      can :read, :order
      can :read, :item


    elsif user.role? :customer
      # can see a list of all users
      can :read, User
      can :edit, User
      can :create, :order
      can :destroy, :order
      can :read, :item
      can :read, :order
      can :create, :school
    else
        can :create, User
        can :create, :school
        can :read, :all
    end


#==============================================================

  #     # they can update their own profile
  #     can :update, User do |u|  
  #       u.id == user.id
  #     end
      
  #     # they can read their own projects' data
  #     can :read, Project do |this_project|  
  #       my_projects = user.projects.map(&:id)
  #       my_projects.include? this_project.id 
  #     end
  #     # they can create new projects for themselves
  #     can :create, Project
      
  #     # they can update the project only if they are the manager (creator)
  #     can :update, Project do |this_project|
  #       managed_projects = user.projects.map{|p| p.id if p.manager_id == user.id}
  #       managed_projects.include? this_project.id
  #     end
            
  #     # they can read tasks in these projects
  #     can :read, Task do |this_task|  
  #       project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
  #       project_tasks.include? this_task.id 
  #     end
      
  #     # they can update tasks in these projects
  #     can :update, Task do |this_task|  
  #       project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
  #       project_tasks.include? this_task.id 
  #     end
      
  #     # they can create new tasks for these projects
  #     can :create, Task do |this_task|  
  #       my_projects = user.projects.map(&:id)
  #       my_projects.include? this_task.project_id  
  #     end

  #   else
  #     # guests can only read domains covered (plus home pages)
  #     can :read, Domain
     end
   end
