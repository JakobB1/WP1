import http from "../http-common";


class IzdavacDataService{

    async get(){
        return await http.get('/Izdavac')
    }

}

export default new IzdavacDataService();