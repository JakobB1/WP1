import React, { Component } from "react";
import NarudzbaDataService from "../../services/narudzba.service";
import KorisnikDataService from "../../services/korisnik.service";
import Container from 'react-bootstrap/Container';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import { Link } from "react-router-dom";
import moment from 'moment';



export default class DodajNarudzba extends Component {

  constructor(props) {
    super(props);
    this.dodajNarudzba = this.dodajNarudzba.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.dohvatiKorisnici = this.dohvatiKorisnici.bind(this);

    this.state = {
      korisnik:[],
      sifraKorisnik:0
    };
  }

  componentDidMount() {
    //console.log("Dohvaćam korisnike");
    this.dohvatiKorisnici();
  }

  async dodajNarudzba(narudzba) {
    const odgovor = await NarudzbaDataService.post(narudzba);
    if(odgovor.ok){
      // routing na narudzbe
      window.location.href='/narudzbe';
    }else{
      // pokaži grešku
      console.log(odgovor);
    }
  }

  async dohvatiKorisnici() {

    await KorisnikDataService.getAll()
      .then(response => {
        this.setState({
          korisnici: response.data,
          sifraKorisnik: response.data[0].sifra
        });

       // console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  }



  handleSubmit(e) {
    e.preventDefault();
    const podaci = new FormData(e.target);
    console.log(podaci.get('datumObracuna'));
    console.log(podaci.get('vrijeme'));
    let datum = moment.utc(podaci.get('datumObracuna') + ' ' + podaci.get('vrijeme'));
    console.log(datum);


    this.dodajNarudzba({
      placanje: podaci.get('placanje'),
      sifraKorisnik: this.state.sifraKorisnik,
      datumObracuna: datum
    });
    
  }


  render() { 

    
    const { korisnici} = this.state;

    return (
    <Container>
        <Form onSubmit={this.handleSubmit}>

        <Form.Group className="mb-3" controlId="korisnik">
            <Form.Label>Korisnik</Form.Label>
            <Form.Select onChange={e => {
              this.setState({ sifraKorisnik: e.target.value});
            }}>
            {korisnici && korisnici.map((korisnik,index) => (
                  <option key={index} value={korisnik.sifra}>{korisnik.ime}</option>

            ))}
            </Form.Select>
          </Form.Group>


        <Form.Group className="mb-3" controlId="placanje">
            <Form.Label>Način placanja</Form.Label>
            <Form.Control type="text" name="placanje" placeholder="" maxLength={255} required/>
          </Form.Group>

        <Form.Group className="mb-3" controlId="vrijeme">
            <Form.Label>Datum izlaska</Form.Label>
            <Form.Control type="date" name="vrijeme" placeholder=""  />
        </Form.Group>

          


          <Row>
            <Col>
              <Link className="btn btn-danger gumb" to={`/narudzbe`}>Odustani</Link>
            </Col>
            <Col>
            <Button variant="primary" className="gumb" type="submit">
              Dodaj narudzbu
            </Button>
            </Col>
          </Row>
         
          
        </Form>


      
    </Container>
    );
  }
}

