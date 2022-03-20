## Building a New Application with SAAS Project
If you're building a new application with SAAS Project, you don't want to "Fork" the template repository on GitHub. Instead, you should:

1. Clone the template repository:

    ```
    $ git clone git@github.com:bullet-train-co/bullet_train.git your_new_project_name
    $ cd your_new_project_name
    ```

2. Run the configuration script:

    ```
    $ bin/configure
    ```
    
## Provisioning a Production Environment on Heroku
You can use this public repository to provision a new application on Heroku and then push your private application code there later.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=http://github.com/bullet-train-co/bullet_train)
