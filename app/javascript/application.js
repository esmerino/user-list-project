// Entry point for the build script in your package.json
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "./src/jquery"
import "./controllers"
import * as bootstrap from "bootstrap"
import "./src/vendor"
import "./src/layout"
import "./src/app"
