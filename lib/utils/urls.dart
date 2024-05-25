const baseUrl = 'http://192.168.10.86:5000/api';
const registerUrl = '/register';

const loginUrl = '/login';
const verifyMailUrl = '/mail-verification';

const forgotPasswordUrl = '/forget-password';
const addStaff = '/add-staff';
const getStaff = '/get-staff';
const editStaffUrl = '/edit-staff';
const deleteStaffUrl = '/delete-staff';

const getUser = '/get-user';
const getUserByWard = '/get-user-ward';
const getStaffByWard = '/get-staff-ward';

const addDustbinUrl = '/add-dustbin';
const editDustbinUrl = '/edit-dustbin';
const getDustbinUrl = '/get-dustbin';
const deleteDustbinUrl = '/delete-dustbin';
const getDustbinByWard = '/get-filter-dustbin';
const getDustbinStats = '/dustbin-stats';

const wastepickupAddTime = '/add-time';
const getWastepickupTimeByWard = '/get-filter-time';
const editWastepickupTime = '/edit-time';
const deleteWastepickupTime = '/delete-time';

// merged

const createReport = '/create-report';
const getReportAccWard = '/get-filter-report';
const getReport = '/get-report';
const deleteUserReport = '/delete-user-report';

const createBulkRequest = '/create-bulk-request';
const getBulkRequest = '/get-bulk-request';
const deleteBulkReportById = '/delete-bulk-request';

const paymentCreate = '/payment';
const getPaymentDetails = '/get-payment-details';
