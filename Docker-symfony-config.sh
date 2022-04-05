# ------------------------------------------------------------------------------------------------------------------
# I N S T A L L E R   D O C K E R
  sudo apt-get purge docker lxc-docker docker-engine docker.io
  sudo apt-get update
  sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common

  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
  sudo systemctl status docker

  docker -v

  #* CHEICKING
    docker run hello-world
        
# I N S T A L L E R   D O C K E R
# ------------------------------------------------------------------------------------------------------------------ 

# C O N F I G  -  C O N T A I N E R
    ________________________________________________________________________
    
    #* Repertory
        #* mkdir docker_symfony
            touch docker-compose.yml   [ - MySQL, - phpMyAdmin, - Maildev, - Apache, - PhP ]
        #* mkdir php
            touch dockerFile   >>>> www ...
        #* mkdir  vhosts
            touch vhosts.conf ( ref symfony doc )    
    #* Test Engines Container
        docker-compose up -d
    #* project (Symfony)
        docker exec www_docker_symfony composer create-projet symfony/website-skeleton project
    #* Let Change docker Owner
        sudo chown -R $USER ./
    #* Edit .env (Symfony)
        #* For DATABAES create
            DATABASE_URL=mysql://root:@db_docker_symfony:3306/db_name?serverVersion=5.7
        #* SMTP maildev
            MAILER_DSN=smtp://maildev_docker_symfony:25
    #* Create database
        docker exec -it www_docker_symfony bash
    ________________________________________________________________________
# C O N F I G  -  C O N T A I N E R

# ------------------------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------------------------------
	# S H O W  I M A G E S  P R O C E S S
		docker images -a
		docker ps

	# Build Docker-composer file
		docker-compose up --build
		docker-compose up -d

	# New Project Symfony
		docker exec www_docker_symfony composer create-projet symfony/website-skeleton project
		
# ------------------------------------------------------------------------------------------------------------------

    # TO Entry in VM Docker
        docker exec -it www_docker_symfony bash   
        cd /var/www/project
    Let make a entity TEST
         php bin/console make:entity
        php bin/console make:migration
        php bin/console doctrine:migrations:migrate
    Let Make a CONTROLLER
        /var/www/project# php bin/console make:controller MailController
        [______ MailController.php  

            <?php
            namespace App\Controller;
            use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
            use Symfony\Component\HttpFoundation\Response;
            use Symfony\Component\Mailer\MailerInterface;
            use Symfony\Component\Mime\Email;
            use Symfony\Component\Routing\Annotation\Route;
            class MailController extends AbstractController
            {
                /**
                * @Route("/mail", name="mail")
                */
                public function index(MailerInterface $mailer): Response
                {
                    $email = (new Email())
                        ->from('hello@example.com')
                        ->to('you@example.com')
                        ->subject('Test de MailDev')
                        ->text('Ceci est un mail de test');
                    $mailer->send($email);
                    return $this->render('mail/index.html.twig', [
                        'controller_name' => 'MailController',
                    ]);
                }
            }
            
        _________]

# ------------------------------------------------------------------------------------------------------------------
	# Delete / clean
		docker stop 1d5a49765b74
		docker system prune
# ------------------------------------------------------------------------------------------------------------------
