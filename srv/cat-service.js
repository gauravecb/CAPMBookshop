
import cds from '@sap/cds';

const { SELECT } = cds.ql;

export default class CatalogService extends cds.ApplicationService {
    async init() {

        this.on('findBookByISBN', async (req) => {
            const { isbn } = req.data;

            if (!isbn || !/^\d{13}$/.test(isbn)) {
                return req.reject(400, 'Please provide a valid 13-digit ISBN.');
            }

            const { Books } = this.entities;

            const book = await SELECT.one
                .from(Books)
                .where({ isbn });

            if (!book) {
                return req.reject(404, `No book found for ISBN ${isbn}.`);
            }

            return book;
        });

        return super.init();
    }
}
