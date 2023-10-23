import http from "../http-common";


class IzdavacDataService{

    async get(){
        return await http.get('/Izdavac')
    }

    async getBySifra(sifra) {
        return await http.get('/izdavac/' + sifra);
    }

    async delete(sifra){
        const odgovor = await http.delete('/Izdavac/' + sifra)
        .then(response => {
            return {ok: true, poruka: 'Obrisao uspješno'};
        })
        .catch(error =>{
            return {ok: false, poruka: error.response.data}
        });

        return odgovor;
    }

    async post(izdavac){
        //console.log(izdavac);
        const odgovor = await http.post('/izdavac',izdavac)
           .then(response => {
             return {ok:true, poruka: 'Unio izdavaca'}; // return u odgovor
           })
           .catch(error => {
            //console.log(error.response);
             return {ok:false, poruka: error.response.data}; // return u odgovor
           });
     
           return odgovor;
    }

    async put(sifra,izdavac){
        //console.log(izdavaac);
        const odgovor = await http.put('/izdavac/' + sifra,izdavac)
           .then(response => {
             return {ok:true, poruka: 'Promjenio izdavaca'}; // return u odgovor
           })
           .catch(error => {
            //console.log(error.response);
             return {ok:false, poruka: error.response.data}; // return u odgovor
           });
     
           return odgovor;
         }

}

export default new IzdavacDataService();