import cds from '@sap/cds'

export default class CatalogService extends cds.ApplicationService {
    async init() {
        const bp = await cds.connect.to('API_BUSINESS_PARTNER')

        this.on('READ', 'BusinessPartners', req => bp.run(req.query))

        return super.init()
    }
}
