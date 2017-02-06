<?php

namespace App\Presenters;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Model;


class HomepagePresenter extends Nette\Application\UI\Presenter
{
	/** @var EntityManager @inject */
	public $entityManager;


	private $userRepository;


	public function startup()
	{
//		$this->userRepository = $this->entityManager->getRepository(Model\User::class);
	}


	public function actionDefault()
	{
		dump('test'); die;
//		$users = $this->userRepository->findAll();
	}
}
