import java.util.Scanner;

public class PrimerCamino {
    public Scanner sc = new Scanner(System.in);

    public void primeraDecision(String decision) {
        if (decision.equals("1")) {
            System.out.println("Te adentras al bosque.");
            System.out.println("Ves una casa en el bosque, ¿qué decides hacer?\n1.Te acercas a la casa."
            		+ "\n2.Seguir recto.\n3.Te devuelves.");
            if (decision.equals("1")) {
                System.out.println("Te acercaste a la casa en el bosque.");
            } else if (decision.equals("2")) {
                System.out.println("Seguiste recto.");
            } else if (decision.equals("3")) {
                System.out.println("Te devolviste porque no te gustan los bosques (normal).");
            } else {
                System.out.println("Elige una opción válida.");
            }
        } else if (decision.equals("2")) {
        	System.out.print("No te has adentrado al bosque, miras alrededor, y te das cuenta de que,\nestas en Guarroman, Jaén."
          + " Sabes que no vas a durar mucho aquí, asi que decides. . ."
          + "\n1.Buscar a alguien para pedir ayuda."
          + "\n2.Acudir al bar mas cercano."
          + "\n3.Andar hacia el pueblo.");
	        segundaDecision(sc.nextLine());
        } else {
            System.out.println("Elige una opción válida.");
        }
    }

    public void segundaDecision(String decision) {  
    	  if (decision.equals("2")) {
    		  
    	  } else if (decision.equals("1")) {
    		  System.out.println("no.");
    	  } else if (decision.equals("3")) {
    		  System.out.println("no2.");
    	  } 
    }
}
