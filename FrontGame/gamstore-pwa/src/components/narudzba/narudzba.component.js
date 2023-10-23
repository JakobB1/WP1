import React, { Component } from "react";
import NarudzbaDataService from "../../services/narudzba.service";
import Container from 'react-bootstrap/Container';
import Table from 'react-bootstrap/Table';
import Button from 'react-bootstrap/Button';
import { Link } from "react-router-dom";
import { FaEdit } from 'react-icons/fa';
import { FaTrash } from 'react-icons/fa';



export default class Narudzbe extends Component{

    constructor(props){
        super(props);

        this.state = {
            narudzbe: []
        };

    }

    componentDidMount(){
        this.dohvatiNarudzbe();
    }

    async dohvatiNarudzbe(){

        await NarudzbaDataService.get()
        .then(response => {
            this.setState({
                narudzbe: response.data
            });
            console.log(response.data);
        })
        .catch(e =>{
            console.log(e);
        });
    }

    async obrisiNarudzba(sifra){
        const odgovor = await NarudzbaDataService.delete(sifra);
        if(odgovor.ok){
            this.dohvatiNarudzbe();
        }else{
            alert(odgovor.poruka);
        }
    }


    render(){

        const { narudzbe } = this.state;

        return (
            <Container>
                <a href="/narudzbe/dodaj" className="btn btn-success gumb">
                    Dodaj novu narudžbu
                </a>

                <Table strict bordered hover responsive>
                    <thead>
                        <tr>
                            <th>Broj računa</th>
                            <th>Korisnik</th>
                            <th>Plaćanje</th>
                            <th>Datum obracuna</th>
                            <th>Akcija</th>
                        </tr>
                    </thead>
                    <tbody>
                        { narudzbe && narudzbe.map((narudzba,index) => (

                            <tr key={index}>
                                <td>{narudzba.sifra}</td>
                                <td>{narudzba.korisnik_id}</td>
                                <td>{narudzba.placanje}</td>
                                <td>{narudzba.datumObracuna}</td>
                                <td>
                                    <Link className="btn btn-primary gumb"
                                    to={`/narudzbe/${narudzba.sifra}`}>
                                        <FaEdit />
                                    </Link>

                                    <Button variant="danger" className="gumb"
                                    onClick={()=>this.obrisiNarudzba(narudzba.sifra)}>
                                        <FaTrash />
                                    </Button>
                                </td>
                            </tr>

                        ))}
                    </tbody>
                </Table>





            </Container>
            

        );
    }
}