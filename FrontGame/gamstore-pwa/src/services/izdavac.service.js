import http from "../http-common";


class IzdavacDataService{

    async get(){
        return await http.get('/Izdavac');
    }

    async getBySifra(sifra) {
        return await http.get('/izdavac/' + sifra);
      }

    async delete(sifra){
        const odgovor = await http.delete('/Izdavac/' + sifra)
        .then(response => {
            return {ok: true, poruka: 'Obrisao uspješno'};
        })
        .catch(e=>{
            return {ok: false, poruka: e.response.data};
        });

        return odgovor;
    }


    async post(izdavac){
        //console.log(smjer);
        const odgovor = await http.post('/izdavac',izdavac)
           .then(response => {
             return {ok:true, poruka: 'Unio izdavac'}; // return u odgovor
           })
           .catch(error => {
            //console.log(error.response);
             return {ok:false, poruka: error.response.data}; // return u odgovor
           });
     
           return odgovor;
    }

    async put(sifra,izdavac){
        //console.log(smjer);
        const odgovor = await http.put('/izdavac/' + sifra,izdavac)
           .then(response => {
             return {ok:true, poruka: 'Promjenio izdavac'}; // return u odgovor
           })
           .catch(error => {
            //console.log(error.response);
             return {ok:false, poruka: error.response.data}; // return u odgovor
           });
     
           return odgovor;
         }

}

export default new IzdavacDataService();