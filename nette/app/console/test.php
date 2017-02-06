<?php

namespace App\Console;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class SendNewslettersCommand extends Command
{
	protected function configure()
	{
		$this->setName('app:newsletter')
			->setDescription('Sends the newsletter');
	}

	protected function execute(InputInterface $input, OutputInterface $output)
	{
		$newsletterSender = $this->getHelper('container')->getByType('Models\NewsletterSender');

		try {
			$newsletterSender->sendNewsletters();
			$output->writeLn('Newsletter sent');
			return 0; // zero return code means everything is ok

		} catch (\Nette\Mail\SmtpException $e) {
			$output->writeLn('<error>' . $e->getMessage() . '</error>');
			return 1; // non-zero return code means error
		}
	}
}