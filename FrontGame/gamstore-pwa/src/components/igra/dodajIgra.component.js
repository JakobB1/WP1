import React, { Component } from "react";
import IgraDataService from "../../services/igra.service";
import IzdavacDataService from "../../services/izdavac.service";
import Container from 'react-bootstrap/Container';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import { Link } from "react-router-dom";
import moment from 'moment';



export default class DodajIgra extends Component {

  constructor(props) {
    super(props);
    this.dodajIgra = this.dodajIgra.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.dohvatiIzdavaci = this.dohvatiIzdavaci.bind(this);

    this.state = {
      izdavac:[],
      sifraIzdavac:0
    };
  }

  componentDidMount() {
    //console.log("Dohvaćam smjerove");
    this.dohvatiIzdavaci();
  }

  async dodajIgra(igra) {
    console.log(igra)
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



  handleSubmit(e) {
    e.preventDefault();
    const podaci = new FormData(e.target);
    console.log(podaci.get('datumIzlaska'));
    console.log(podaci.get('vrijeme'));
    let datum = moment.utc(podaci.get('datumIzlaska') + ' ' + podaci.get('vrijeme'));
    console.log(datum);


    this.dodajIgra({
      naziv: podaci.get('naziv'),
      sifraIzdavac: this.state.sifraIzdavac,
      zanr: podaci.get('zanr'),
      cijena: parseFloat(podaci.get('cijena')),
      dobnaGranica: parseFloat(podaci.get('dobnaGranica')),
      datumIzlaska: datum,
    });

    // this.dodajIgra({
    //   sifra: 0,
    //   naziv: "string",
    //   izdavac: "string",
    //   zanr: "string",
    //   cijena: 0,
    //   dobnaGranica: 0,
    //   datumIzlaska: "2023-10-24T17:14:27.823Z",
    //   opis: "string",
    //   sifraIzdavac: 0
    // })
    
  }


  render() { 

    
    const { izdavaci} = this.state;

    return (
    <Container>
        <Form onSubmit={this.handleSubmit}>


        <Form.Group className="mb-3" controlId="naziv">
            <Form.Label>Naziv</Form.Label>
            <Form.Control type="text" name="naziv" placeholder="" maxLength={255} />
          </Form.Group>

          <Form.Group className="mb-3" controlId="izdavac">
            <Form.Label>Izdavač</Form.Label>
            <Form.Select onChange={e => {
              this.setState({ sifraIzdavac: e.target.value});
            }}>
            {izdavaci && izdavaci.map((izdavac,index) => (
                  <option key={index} value={izdavac.sifra}>{izdavac.naziv}</option>

            ))}
            </Form.Select>
          </Form.Group>

          <Form.Group className="mb-3" controlId="zanr">
            <Form.Label>Žanr</Form.Label>
            <Form.Control type="text" name="zanr" placeholder="Žanr igre"
            maxLength={255} />
          </Form.Group>

          <Form.Group className="mb-3" controlId="cijena">
            <Form.Label>Cijena</Form.Label>
            <Form.Control type="text" name="cijena" placeholder="500" />
            <Form.Text className="text-muted">
             Ne smije biti negativna
            </Form.Text>
          </Form.Group>

          <Form.Group className="mb-3" controlId="dobnaGranica">
            <Form.Label>Dobna granica</Form.Label>
            <Form.Control type="text" name="dobnaGranica" placeholder="dobnaGranica"
            maxLength={255}  />
          </Form.Group>

          <Form.Group className="mb-3" controlId="vrijeme">
            <Form.Label>Datum izlaska</Form.Label>
            <Form.Control type="date" name="vrijeme" placeholder=""  />
          </Form.Group>



          <Row>
            <Col>
              <Link className="btn btn-danger gumb" to={`/igre`}>Odustani</Link>
            </Col>
            <Col>
            <Button variant="primary" className="gumb" type="submit">
              Dodaj igru
            </Button>
            </Col>
          </Row>
         
          
        </Form>


      
    </Container>
    );
  }
}

