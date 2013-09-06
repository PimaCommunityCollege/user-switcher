User Switcher for Cascade Server
================================

The user switcher allows a person with the Administrator role in Cascade Server CMS to instantly log in as another user.  

Installation
------------

Copy index.jsp and doSwitch.jsp to a new folder in your Cascade Server.  If your CMS is installed at:
 
* [tomcat]/webapps/ROOT
 
you could put the files in:

* [tomcat]/webapps/ROOT/pccCustom/user/ 

You want to make a new folder so you don't accidentally overwrite any Cascade files, your files are not accidentally overwritten in a Cascade upgrade, and it is easy to install/remove the switcher from the system.

Accessing the user switcher
---------------------------

If you put the files in 

* [tomcat]/webapps/ROOT/pccCustom/user/

you can now access the user switcher at:

* https://[YOUR_CMS]/pccCustom/user/index.jsp

If you chose a different directory, change the URL accordingly.

Changing the user role
----------------------

This is probably a bad idea, unless you also add a check to prevent a switch from a non-admin to an administrative user.

If you want to make user switching accessible to some other role than Admistrator, look for this part:

```
getRoleService().userHasRoleByRolename(login.getUsername(), "Administrator")
```

..and change the role string to something else.  

You could control access in some other way, such as looking for group membership with getGroupService.getGroupsForUser().  

License
-------

This software is provided under the MIT License.  See license.txt.




