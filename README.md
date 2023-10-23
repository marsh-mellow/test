# Salesforce DX Project: testsfbug

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## What you need to know
####README.md

    This is a general README.md file and this project directory is a scaffold of a standard project structure.
    You can modify this README.md file as you please.

####Before you start

    Once you've cloned this repository the first thing you should do is run the 'getscripts.sh' script.
    This will initialize the 'buildscripts/' directory and populate it with a bunch of helper scripts
    to make developing easier.  These scripts are described below.  You can and should run the 'getscripts.sh'
    script file every so often as it will pull any changes/enhancements that have been made to the scripts.

####Source structure

    All code will be in the force-app directory.  The standard structure is defined below.  You should not
    change this structure.  Exceptions would be if you are gonna have more than one application within
    your project, example given below.  It would also be possible to move the scratch-only/ directory up 
    one level.  Or perhaps you might have a prod-only/ directory, it should live along side the scratch-only/
    directory.

    force-app/
        from-server/        <-  This is the directory that new source is pulled from the scratch org.
                                To include the source in your project you must move it to a folder below.
        application/        <-  The application folder
            package/        <-  Main package folder.
                main/       <-  All source that can be in the package goes here.
                dependency/ <-  This folder is here to hold standardValueSets pulled from org-common package.
            post-deploy/    <-  Any source that is not 'packageable' goes here to be deployed.
            scratch-only/   <-  Any source that might only be for your scratch org goes here.

    NOTE: When pushing to the scratch org all files in the above directories get pushed.  So be
    mindful if you have files in the from-server/ directory, these will not be part of your package.

    Multiple Applications structure is below.  Note that if changing the structure you will need to
    modify the sfdx-project.json file as well.

    force-app/
        from-server/
        application1/
             package/        
                main/       
                dependency/ 
            post-deploy/
            scratch-only/
        application2/
             package/        
                main/       
                dependency/ 
            post-deploy/
            scratch-only/

    If you use SFDX commands directly, then another helpful file is the '.sfdx/sfdx-config.json' file.  If you don't have one you can create
    it, or you can modify it.

        {
            "defaultdevhubusername": "DEVHUB-ALIAS",
            "defaultusername": "ORG-ALIAS"
        }

    If these are set and you are using straight SFDX commands you don't have to provide these parameters 
    to the commands, they are read from this file.

####Scripts defined
    
    Before defining the scripts you first should be aware of 2 properties files.  There is one in
    in your project now called 'build_properties.sh'.  This file contains global variables that the
    scripts use.

        COMMON_PACKAGE_ID     - This is the Global Common Package that all orgs will have.
        ORG_COMMON_PACKAGE_ID - This is the Org Common Package, each org will have it's own.
        COE_CORE_PACKAGE_ID   - This is the COE-CORE library package, which will probably be installed in 
                                your production org.
        PKG_NAME_ID           - The ID of your application package to be built.

    You can also create a 'build_my_properties.sh' file in your root project folder.  In this file
    you can provide some variables that are used by the scripts but which are particular to you.
    Defining these here means the scripts won't ask you to enter them.
    
        HUB_ALIAS   - Your local alias for the DevHub your application is part of.
        ORG_ALIAS   - Your local alias for your scratch org.
      
    The most important script, besides 'getscripts.sh' is the 'buildscripts/install-scratch.sh' script.
    This script will create a scratch org, install your dependencies and push your source.
    There are many other supporting scripts that the 'buildscripts/install-scratch.sh' uses.

    Another script is 'buildscripts/get-changeset.sh' it will allow you to retrieve a changeset
    from a sandbox and convert it to source structure.  The files are placed under the 'zcs_retrieved/'
    folder, you will need to move the retrieved files under the appropriate source structure as defined
    above.

    If you are developing a community, then you can run the 'buildscripts/publish-community.sh' passing
    the org alias as the first parameter and community name as the second parameter.  You could also 
    set the variable COMMUNITY_NAME to your community name and put it in your 'build_properties.sh' file, 
    then you don't have to pass it to the script.

## Our Development & Release Process?
                        
    For our development/release process we use the 'Git Flow' branching model.  A link below is provided
    to help you get started with Git Flow.

    Basically there are really only 2 long lived branches in your repository.
        master - The application source that is in production.
        develop - The next version of your application.

    You develop features for your application and when the feature is consider complete and ready for
    production you 'finish' the feature which will push it to your 'develop' branch.  Remember to push
    to the remote so your changes are captured.  Feature branches are named as 'feature/XXXX'.

    When you are ready to release, we use Git Flow to start the release process.  This will create a
    branch 'release/VERSION'.  You then verify and fix anything in this branch for the release.  Once
    released you 'finish' the release and that will push your changes to the master and develop branches.
    Again don't forget to push to the remote.

    When 'finishing' a feature or release, then that branch will be deleted from your local and the 
    remote repository.  This keeps the repository clean and maintainable.

## How Do You Get Your Application Released?

    All applications will be installed via an 'unlocked' package.  Note, somethings within Salesforce
    can not be installed via 'unlocked' packages and thus they must be 'deployed' to the org during the
    release process.
                       
    First you will need to register a package within your DevHub.
        sfdx force:package:create -n YourPackageName -t Unlocked -r force-app

    NOTE: This project already has a sfdx-project.json file, when you run this command it will
    modify this file.  You don't need anything it puts in the "packageDirectories" section.  
    You only need what's under the "packageAliases" section.  You should see something
    like this:

        "packageAliases": {
            "YourPackageName": "0HoXXXXXXXXXXXXXXX",  <- This is your PKG_NAME_ID
   
    So just revert the other stuff in the file.

## Helpful Information

You can read [here](https://astro-ised-isde.force.com/coe/s/toparticles) all about our development 
processes, include our Release Process, Development Principles and Naming Convention to name a few.
You will also find documentation about many helpful utility classes and frameworks developed within
our COE-CORE library.

Salesforce CLI Command Reference is found [here](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference_top.htm)

Git Flow Cheatsheat is found [here](https://danielkummer.github.io/git-flow-cheatsheet/)

## Questions?

You can contact the COE Team [here](https://astro-ised-isde.force.com/coe/s/contact-us).


