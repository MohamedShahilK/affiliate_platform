class ApiConstants {
  static const BASE_URL = 'https://affiliate.arabinfotechllc.com/api/v1';
}

class EndPoints {
  static const login = '/auth/login';
  static const validateToken = '/auth/validate_token';
  static const regenerateToken = '/auth/regenerate_token';

  // Contacts
  static const getAllContacts = '/contacts/contact_list';
  static const contactForm = '/contacts/contact_form';
  static const contactView = '/contacts/contact_view';
  static const submitContactForm = '/contacts/contact_submit';
  static const submitEditContactSubmit = '/contacts/contact_edit_submit';
  static const contactdelete = '/contacts/contact_delete';
  static const addPermForAffUsers = '/contacts/add_contact_permission';
  static const deletePermForAffUsers = '/contacts/delete_contact_permission';
  static const addFollowup= '/contacts/add_contact_followup';
  static const deleteFollowup= '/contacts/delete_contact_followup';
  static const editFollowup= '/contacts/edit_contact_followup_submit';

  // Projects
  static const getAllProjects = '/project/list';
  static const projectForm = '/project/form';
  static const projectView = '/project/view';
  static const submitProjectForm = '/project/submit';

  // CheckIns
  static const getAllCheckins = '/checkin/list';
  static const checkinForm = '/checkin/form';

}
