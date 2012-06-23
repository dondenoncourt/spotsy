/**
 * Internal class used as the controller to view check transaction data.
 * <p>Contains commented out code that originally was use to upload, on demand, check transaction data to the 400
 * but was replaced with the CSV process.</p>
 */
class CheckTransactionController {
    def echecksService
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {CheckTransSearchCommand cmd ->
        def list = []
        def count = 0
        params.max = 10
        // Last name, account, or transaction date (conf num?)
        if (params.lastName) {
            list = CheckTransaction.findAllByLastNameLike("${cmd.lastName}%", params)
            count = CheckTransaction.countByLastNameLike("${cmd.lastName}%")
            log.debug "search on lastName: $params.lastName"
        } else if (params.account) {
            list = CheckTransaction.findAllByAccountNum(cmd.account, params)
            count = CheckTransaction.countByAccountNum(cmd.account)
            log.debug "search on account: $params.account"
        } else if (params.transDate) {
            list = CheckTransaction.findAllByDateCreatedGreaterThanEquals(cmd.transDate, params)
            count = CheckTransaction.countByDateCreatedGreaterThanEquals(cmd.transDate)
            log.debug "search on transDate: $cmd.transDate"
        } else {
            list = CheckTransaction.list( params )
            count = CheckTransaction.count()
            log.debug "search all"
        }
        [ checkTransactionInstanceList: list, checkTransactionInstanceTotal: count ]
    }

    def show = {
        def checkTransactionInstance = CheckTransaction.get( params.id )

        if(!checkTransactionInstance) {
            flash.message = "CheckTransaction not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ checkTransactionInstance : checkTransactionInstance ] }
    }

    /*
    def upload = {UploadCommand cmd ->
        def list = CheckTransaction.findAllByDateCreatedGreaterThanEquals(cmd.transDate)
        if (list.size() > 0) {
            echecksService.writeEchecksTo400(list)
            flash.message = "${list.size()} check transactions uploaded to the ECHECKS file on the iSeries"
        } else {
            flash.message = "Sorry since there are no transactions greater than or equal to "+g.formatDate ([format:"MM/dd/yyyy", date:cmd.transDate])
        }
    }
    */
}
class UploadCommand {
    Date transDate
}
class CheckTransSearchCommand {
    String lastName
    String account
    Date transDate
}