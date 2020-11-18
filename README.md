Application for use in IT dept. when sometimes you have to send multiple personalized emails to employees. Allows to create your own templates and define new variables.
Also allows to create mail signatures on similar terms. More modules are also present in this app but they mainly serve as a learning opportunity for myself.

# This application is a work in progress
# Features (future, not implemented)

By design all modules are backed by data from LDAP storage (ad_users table). It is howewer possible to add new records by-hand. Maybe in the future other ways to import data will be implemented.

Functionality:
1)  Manage AD Users info
    * Add optional info such as:
        * Office location
            * Office locations and their data can be entered from application interface independently from Users
            * If LDAP field "cn" contains <b>name</b> of existing <b>office location</b> it can be bound automatically to User
                    * Such synchronization is possible from Settings menu after initial sync with LDAP
        * Phone number
            * Allow multiple phone numbers
2)  Mailing
    * Allows sending mails to one or more selected Users
    * Allows configuration and selection of sender account and name
        * Authorization with extermal mail provider thorugh IMAP or OAuth
    * Create, edit or upload templates for mail messages which can be personalized by variable text fragments
        * Mail templates stored in .html files, can be styled
        * Mass Mailing - multiple messages can be sent to multiple users
        * Mail templates contain Tags
            * For every unique Tag in Mail Template application creates text input
            * Tags can be marked to be automatically filled by User data when User is selected, text input is filled accordingly
            * Tags can be created by anyone in application interface
                * Text Tag - allows inserting text in template
                * File Tag - allows inserting file attachment in template
            * Every Tag in Template can be flagged, so when the message is sent data inserted under this tag will be saved to database
            * Some Tags can have special functionality, such as password generation for all selected users
    * Before sending all prepared mails are shown in modal window
        * Prepared mails can be sorted in two ways
            * By recipient address
            * By used template
        * Any prepared mail can be removed from list (but not actually removed from interface - only greyed out, this way user can undo missclicks)
        * Accepting list of prepared mails sends request to backend and begins sending.
            * Interface contains progress indicator 
    * History of sent Mails can be shown
3)  Mail Signature Generator
    * Similar Template and Tags handling as in Mailing module
    * Can create, upload or edit existing template
    * Allows for mass creation of Mail signatures
4)  SMS Gateway (smsapi.com)
    * Functionality mostly the same as Mailing module
    * Allows for limited management of logged smsapi account
        * Shows remaining points
    * Allows to enqueue SMS for immediate delivery
    * Allows to enqueue SMS for delivery on set date
    * History of sent SMS can be shown
5)  Module for holiday requests - new idea
    * Ability to log-in with google OAuth using business Google account
    * Optionally can authenticate through LDAP
    * Support for roles (eg. supervisor can see subordinates' requests, HR Dept. can see all requests, etc)
    * Mail notifications on request updates (created, accepted, rejected)
