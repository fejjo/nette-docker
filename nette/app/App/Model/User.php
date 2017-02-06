<?php

namespace App\Model;

use Doctrine\ORM\Mapping as ORM;


/**
 * @ORM\Entity
 */
class User extends \Kdyby\Doctrine\Entities\BaseEntity
{

	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue
	 */
	protected $id;

	/**
	 * @ORM\Column(type="string")
	 */
	protected $email;

}
