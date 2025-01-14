# Purpose

This demo app provides an introduction to using mrgsolve and Shiny to create pharmacokinetic (PK) simulations. It allows users to interactively modify parameters, adjust simulation settings, and visualize simulation results. By following these instructions and the comments in the app files, you will learn how to enhance the app’s interactivity by adding additional widgets and outputs.

# Set-up

1.  Clone this repo:

```         
gh repo clone A2-ai/shiny-workshop
```

or

```         
git clone https://github.com/A2-ai/shiny-workshop.git
```

2.  Run `renv::restore`

3.  Open one of the three app files depending on your skill level and follow the in-file comments to implement the enhancements:

-   app-easy.R: Beginner - Most of the code is pre-filled, including basic UI elements and server logic.
-   app-med.R: Intermediate - Some foundational code is pre-filled, but significant elements are left for you to complete.
-   app-hard.R: Advanced - The app structure is provided with minimal pre-filled code.

4.  Once you’ve completed or made edits to one of the app files, you can run it in two ways:

-   Using runApp() in the console (e.g., `shiny::runApp("app-easy.R")`)
-   Click the Run App button at the top right of the script editor if you are using RStudio.

# Resources

-   Widgets: <https://shiny.posit.co/r/gallery/widgets/widget-gallery/>
-   Mastering Shiny: <https://mastering-shiny.org/>
    -   Reactivity: <https://mastering-shiny.org/basic-reactivity.html>
    -   User Feedback/Validation: <https://mastering-shiny.org/action-feedback.html>
