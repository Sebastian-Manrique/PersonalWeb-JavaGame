import java.util.Scanner;

public class PrimerCamino {
    public Scanner sc = new Scanner(System.in);

    public void primeraDecision(String decision) {
    	if (decision.equals("1")) {
            System.out.println("Te adentras al bosque y ves a lo lejos una casa.¿Qué haces?\n1.Te acertas.\n2.Sigues recto.\n3.Te devuelves.");
            primeraDecision(sc.nextLine());
            switch (decision) {
			case "1": {
				System.out.println("Te acercaste a la casa en el bosque.");
				break;
			}
			case "2": {
				System.out.println("Seguiste recto.");
				break;
			}
			case "3": {
				System.out.println("Te devolviste porque no te gustan los bosques (normal).");
				break;
			}
			default:System.out.println("Elige una opción válidanº1");
			}
        } else {
        	 segundaDecision(decision);
        }
    }

    public void segundaDecision(String decision) {
    	System.out.print("No te has adentrado al bosque, miras alrededor, y te das cuenta de que,\nestas en Guarroman, Jaén."
		+" Sabes que no vas a durar mucho aquí, asi que decides. . ."
		+"\n1.Buscar a alguien para pedir ayuda."
		+"\n2.Acudir al bar mas cercano."
		+"\n3.Andar hacia el pueblo.");
    	System.out.println();
    	decision = sc.nextLine();
    	switch (decision) {
		case "1":{
		System.out.println("En Guarroman no hay apenas gente pero te encuentras a un anciano paseando.");
		terceraDecision(decision);
		break;
		}
		case "2":{
		System.out.println("Obviamente encuentras varios bares.");
		terceraDecision(decision);
		break;
		}
		case "3":{
		System.out.println("Decides andar al pueblo . . .");
		terceraDecision(decision);
		break;
		}
		default:
			System.out.println("Elige una opción válida.");
		}
    }
    public void terceraDecision(String decision) {
    	if (decision.equals("1")) {
    		boolean mostrarDialogo = true;
    		boolean respuesta1= false;
    		boolean respuesta2= false;
    		boolean respuesta3= false;
    	       do {
    	            if (mostrarDialogo) {
    	                System.out.println("Que le decides preguntar al anciano."
    	                        + "\n1.Pides ayuda para salir de Guarroman."
    	                        + "\n2.Pides la hora"
    	                        + "\n3.Pides dinero.");
    	            }

    	            decision = sc.nextLine(); // Para hablar con el anciano.

    	            switch (decision) {
    	                case "1": {
    	                    System.out.println("Te responde con un acento muy cerrado: 'çuerte xabâh pa çali' de Guarroman çin coxe.'.");
    	                    respuesta1= true;
    	                    break;
    	                }
    	                case "2": {
    	                    System.out.println("Te dice la hora con un: 'puê mira çon lâ çeî y media'.");
    	                    respuesta2= true;
    	                    break;
    	                }
    	                case "3": {
    	                    System.out.println("Dice: 'ni arto de bino te doy yo un çentimo'.");
    	                    respuesta3= true;
    	                    break;
    	                }
    	                default:
    	                    System.out.println("Elige una opción válida.");
    	            }

    	            // Para volver a mostrar el diálogo después de cada opción seleccionada
    	            mostrarDialogo = true;

    	        } while (respuesta1 == true || respuesta2 == true || respuesta3 == true);
/*
    		decision = sc.nextLine(); //Para hablar con el anciano.
        	switch (decision) {
    		case "1":{
    		System.out.println("Te responde con un acento muy cerrado: 'çuerte xabâh pa çali' de Guarroman çin coxe.'.");
    		break;
    		}
    		case "2":{
    		System.out.println("Te dice la hora con un: 'puê mira çon lâ çeî y media'.");
    		break;
    		}
    		case "3":{
    		System.out.println("Dice: 'ni arto de bino te doy yo un çentimo'.");
    		break;
    		}
    		default:
    			System.out.println("Elige una opción válida.");
    		}*/
    	}else if(decision.equals("2")) {
    		System.out.println("Ves tres diferentes bares uno pijo, uno humilde y uno gitano.¿A cual entras?"
    				+ "\n1.Al pijo."
    				+ "\n2.Al humilde."
    				+ "\n3.Al gitano.");
    		decision = sc.nextLine(); //Para ir a los bares.
        	switch (decision) {
    		case "1":{
    		System.out.println("Entras al pijo.");
    		break;
    		}
    		case "2":{
    		System.out.println("Entras al humilde.");
    		break;
    		}
    		case "3":{
    		System.out.println("Entras al gitano.");
    		break;
    		}
    		default:
    			System.out.println("Elige una opción válida.");
    		}
    	} else if(decision.equals("3")) {
    		System.out.println("Vas al pueblo y ves como todo el mundo habla con un toque en la boca llamado 'acento andaluz'\nDejando eso de lado.¿Donde vas?"
    				+ "\n1.Al ayuntamiento."
    				+ "\n2.A un parque."
    				+ "\n3.A una comisaria.");
    		decision = sc.nextLine(); //Para andar al pueblo.
        	switch (decision) {
    		case "1":{
    		System.out.println("Caminas al ayuntamiento.");
    		break;
    		}
    		case "2":{
    		System.out.println("Caminas al parque.");
    		break;
    		}
    		case "3":{
    		System.out.println("Caminas a una comisaria.");
    		break;
    		}
    		default:
    			System.out.println("Elige una opción válida.");
    		}
    	} 
    }
}
