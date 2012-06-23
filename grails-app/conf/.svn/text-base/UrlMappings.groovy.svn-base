/**
 * Maps http urls to controller actions, the only Spotsy customization is the forwarding of http 500 errors to the error controller.
 */

class UrlMappings {
    static mappings = {
          "/$controller/$action?/$id?"{
                  constraints {
                             // apply constraints here
                      }
              }
          "/"(view:"/index")
       	 //"500"(view:'/error')  // original
	 "500"(controller:'error',action:'error')

	}
}
