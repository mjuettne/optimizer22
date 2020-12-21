Rails.application.routes.draw do


  #Home
  get("/", { :controller => "application", :action => "index" })

  # Routes for the Forecast input resource:

  # CREATE
  post("/insert_forecast_input", { :controller => "forecast_inputs", :action => "create" })
          
  # READ
  get("/forecast_inputs", { :controller => "forecast_inputs", :action => "index" })
  
  get("/forecast_inputs/:path_id", { :controller => "forecast_inputs", :action => "show" })
  
  # UPDATE
  
  post("/modify_forecast_input/:path_id", { :controller => "forecast_inputs", :action => "update" })
  
  # DELETE
  get("/delete_forecast_input/:path_id", { :controller => "forecast_inputs", :action => "destroy" })

  #------------------------------

  # Routes for the Correlation input resource:

  # CREATE
  post("/insert_correlation_input", { :controller => "correlation_inputs", :action => "create" })
          
  # READ
  get("/correlation_inputs", { :controller => "correlation_inputs", :action => "index" })
  
  get("/correlation_inputs/:path_id", { :controller => "correlation_inputs", :action => "show" })
  
  # UPDATE
  post("/modify_correlation_input/", { :controller => "correlation_inputs", :action => "update_all" })
  post("/modify_correlation_input/:path_id", { :controller => "correlation_inputs", :action => "update" })
  
  # DELETE
  get("/delete_correlation_input/:path_id", { :controller => "correlation_inputs", :action => "destroy" })

  #------------------------------

  # Routes for the Correlation resource:

  # CREATE
  post("/insert_correlation", { :controller => "correlations", :action => "create" })
  get("/insert_correlation_new", { :controller => "correlations", :action => "create_new" })        
  # READ
  get("/correlations", { :controller => "correlations", :action => "index" })

  get("/correlations/:path_id", { :controller => "correlations", :action => "show" })

  get("/correlations/download/:path_id", { :controller => "correlations", :action => "download" }) # download to excel
  post("/correlations/import/:path_id", { :controller => "correlations", :action => "import" }) # import from excel

  # UPDATE
  
  post("/modify_correlation/:path_id", { :controller => "correlations", :action => "update" })
  
  # DELETE
  get("/delete_correlation/:path_id", { :controller => "correlations", :action => "destroy" })

  #------------------------------
  # Routes for the Cma resource:

  # CREATE
  post("/insert_cma", { :controller => "cmas", :action => "create" })
  get("/insert_cma_new", { :controller => "cmas", :action => "create_new" })        
  # READ
  get("/cmas", { :controller => "cmas", :action => "index" })
  get("/cmas/download/:path_id", { :controller => "cmas", :action => "download" }) # download to excel
  post("/cmas/import/", { :controller => "cmas", :action => "import" }) # import from excel
  
  get("/cmas/:path_id", { :controller => "cmas", :action => "show" })
  
  # UPDATE
  
  post("/modify_cma/:path_id", { :controller => "cmas", :action => "update" })
  
  # DELETE
  get("/delete_cma/:path_id", { :controller => "cmas", :action => "destroy" })

  #------------------------------
  # Routes for the Cma input resource:

  # CREATE
  post("/insert_cma_input", { :controller => "cma_inputs", :action => "create" })
          
  # READ
  get("/cma_inputs", { :controller => "cma_inputs", :action => "index" })
  
  get("/cma_inputs/:path_id", { :controller => "cma_inputs", :action => "show" })
  
  # UPDATE
  
  post("/modify_cma_input", { :controller => "cma_inputs", :action => "update_all" })
  post("/modify_cma_input/:path_id", { :controller => "cma_inputs", :action => "update" })
  
  # DELETE
  get("/delete_cma_input/:path_id", { :controller => "cma_inputs", :action => "destroy" })

  #------------------------------

 

  # Routes for the Asset class resource:

  # CREATE
  post("/insert_asset_class", { :controller => "asset_classes", :action => "create" })
          
  # READ
  get("/asset_classes", { :controller => "asset_classes", :action => "index" })
  get("/asset_class_download", { :controller => "asset_classes", :action => "downloadtoexcel" }) #ADDED

  get("/asset_classes/:path_id", { :controller => "asset_classes", :action => "show" })
  
  # UPDATE
  
  post("/modify_asset_class/:path_id", { :controller => "asset_classes", :action => "update" })
  
  # DELETE
  get("/delete_asset_class/:path_id", { :controller => "asset_classes", :action => "destroy" })

  #------------------------------

  # Routes for the Frontier input resource:

  # CREATE
  post("/insert_frontier_input", { :controller => "frontier_inputs", :action => "create" })
          
  # READ
  get("/frontier_inputs", { :controller => "frontier_inputs", :action => "index" })
  
  get("/frontier_inputs/:path_id", { :controller => "frontier_inputs", :action => "show" })
  
  # UPDATE
  
  post("/modify_frontier_input/:path_id", { :controller => "frontier_inputs", :action => "update" })
  
  # DELETE
  get("/delete_frontier_input/:path_id", { :controller => "frontier_inputs", :action => "destroy" })

  #------------------------------

  # Routes for the Weight resource:

  # CREATE
  post("/insert_weight", { :controller => "weights", :action => "create" })
          
  # READ
  get("/weights", { :controller => "weights", :action => "index" })
  
  get("/weights/:path_id", { :controller => "weights", :action => "show" })
  
  # UPDATE
  
  post("/modify_weight/:path_id", { :controller => "weights", :action => "update" })
  
  # DELETE
  get("/delete_weight/:path_id", { :controller => "weights", :action => "destroy" })

  #------------------------------

  # Routes for the Forecast resource:

  # CREATE
  post("/insert_forecast", { :controller => "forecasts", :action => "create" })
          
  # READ
  get("/forecasts", { :controller => "forecasts", :action => "index" })
  
  get("/forecasts/:path_id", { :controller => "forecasts", :action => "show" })
  
  # UPDATE
  
  post("/modify_forecast/:path_id", { :controller => "forecasts", :action => "update" })
  
  # DELETE
  get("/delete_forecast/:path_id", { :controller => "forecasts", :action => "destroy" })

  #------------------------------

  # Routes for the Frontier resource:

  # CREATE
  post("/insert_frontier", { :controller => "frontiers", :action => "create" })
          
  # READ
  get("/frontiers", { :controller => "frontiers", :action => "index" })
  
  get("/frontiers/:path_id", { :controller => "frontiers", :action => "show" })
  
  post("/frontiers/:path_id/calculate", { :controller => "frontiers", :action => "calculate" })
  get("/edit_frontiers/:path_id", { :controller => "frontiers", :action => "edit" })

  # UPDATE
  
  post("/modify_frontier/:path_id", { :controller => "frontiers", :action => "update" })
  post("/modify_frontier_assets/:path_id", { :controller => "frontiers", :action => "update_all" })
  
  # DELETE
  get("/delete_frontier/:path_id", { :controller => "frontiers", :action => "destroy" })

  #------------------------------

  # Routes for the Portfolio resource:

  # CREATE
  post("/insert_portfolio", { :controller => "portfolios", :action => "create" })
          
  # READ
  get("/portfolios", { :controller => "portfolios", :action => "index" })
  
  get("/portfolios/:path_id", { :controller => "portfolios", :action => "show" })
  
  # UPDATE
  
  post("/modify_portfolio/:path_id", { :controller => "portfolios", :action => "update" })
  
  # DELETE
  get("/delete_portfolio/:path_id", { :controller => "portfolios", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
