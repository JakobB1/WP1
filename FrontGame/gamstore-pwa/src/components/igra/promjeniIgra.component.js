import React, { Component } from "react";
import IgraDataService from "../../services/igra.service";
import IzdavacDataService from "../../services/izdavac.service";
import Container from 'react-bootstrap/Container';
import moment from 'moment';


export default class PromjeniIgra extends Component {

  constructor(props) {
    super(props);

    

  //  console.log('Konstruktor PromjeniIgra');

    

    this.igra = this.dohvatiIgra();
    this.promjeniIgra = this.promjeniIgra.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.izdavaci = this.izdavaci();
    this.obrisiIzdavaca = this.obrisiIzdavaca.bind(this);
    this.traziIzdavaca = this.traziIzdavaca.bind(this);
    this.dodajIzdavaca = this.dodajIzdavaca.bind(this);


    this.state = {
      igra: {},
      izdavaci: [],
      sifraIzdavac:0,
      pronadeniIzdavaci: []
    };
  }




  async dohvatiIgra() {
    // ovo mora bolje
    //console.log('Dohvaćam igre');
    let href = window.location.href;
    let niz = href.split('/'); 
    await IgraDataService.getBySifra(niz[niz.length-1])
      .then(response => {
        let i = response.data;
        i.datumIzlaska = moment.utc(i.datumIzlaska).format("yyyy-MM-DD");
        
        //console.log(g.vrijemePocetka);
        this.setState({
          igra: i
        });
       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }

  

  async promjeniIgra(igra) {
    const odgovor = await IgraDataService.post(igra);
    if(odgovor.ok){
      // routing na igre
      window.location.href='/igre';
    }else{
      // pokaži grešku
      console.log(odgovor);
    }
  }


  async dohvatiIzdavaci() {
   // console.log('Dohvaćm izdavace');
    await IzdavacDataService.get()
      .then(response => {
        this.setState({
          izdavaci: response.data,
          sifraIzdavac: response.data[0].sifra
        });

       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }

  
   async traziIzdavaca( uvjet) {

    await IzdavacDataService.traziPolaznik( uvjet)
       .then(response => {
         this.setState({
          pronadeniIzdavaci: response.data
         });
 
        // console.log(response.data);
       })
       .catch(e => {
         console.log(e);
       });
   }

   async obrisiIzdavaca(igra, izdavac){
    const odgovor = await IgraDataService.obrisiIzdavaca(igra, izdavac);
    if(odgovor.ok){
     this.dohvatiIzdavaci();
    }else{
     //this.otvoriModal();
    }
   }

   async dodajIzdavaca(igra, izdavac){
    const odgovor = await IgraDataService.dodajIzdavaca(igra, izdavac);
    if(odgovor.ok){
     this.dohvatiIzdavaci();
    }else{
    //this.otvoriModal();
    }
   }
 

  handleSubmit(e) {
    e.preventDefault();
    const podaci = new FormData(e.target);
    console.log(podaci.get('datumIzlaska'));
    console.log(podaci.get('vrijeme'));
    let datum = moment.utc(podaci.get('datumIzlaska') + ' ' + podaci.get('vrijeme'));
    console.log(datum);

    this.promjeniIgra({
      naziv: podaci.get('naziv'),
      sifraIzdavac: this.state.sifraIzdavac,
      zanr: podaci.get('zanr'),
      cijena: parseFloat(podaci.get('cijena')),
      dobnaGranica: parseFloat(podaci.get('dobnaGranica')),
      datumIzlaska: datum
    });
    
  }


  render() { 
    

    return (
    <Container>
       
        
    </Container>
    );
  }
}

