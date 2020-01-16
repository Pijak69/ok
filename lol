this.client.warns.set(`${warnedUser.id}`, userWarnings, "warnings");

  message.delete();

  if (this.client.warns.get(`${warnedUser.id}`, "warnings") == 1) {
    message.channel.send(
      `${warnedUser}, premier avertissement (raison: ${reason})`
    );
  } else if (this.client.warns.get(`${warnedUser.id}`, "warnings") == 2) {
    const muteRole = message.guild.roles.find(x => x.name === "muted");
    if (!muteRole) message.guild.createRole("name", "muted");
    message.channel.send(
      `${warnedUser}, deuxième avertissement (raison: ${reason})`
    );
    const muteTime = "1h";
    await warnedUser.addRole(muteRole.id);
    message.channel.send(
      `${warnedUser} est muté pendant ${muteTime} (raison: ${reason})`
    );

    setTimeout(function() {
      warnedUser.removeRole(muteRole.id);
      message.channel.send(`L'utilisateur ${warnedUser} n'est plus muté !`);
    }, ms(muteTime));
  } else if (this.client.warns.get(`${warnedUser.id}`, "warnings") == 3) {
    message.channel.send(`${warnedUser}, troisième avertissement (raison: ${reason})`);
    message.channel.send(`:warning: Attention ${warnedUser}, à 5 avertissement sa sera ban définitif`);
  } else if (this.client.warns.get(`${warnedUser.id}`, "warnings") == 4) {
    message.channel.send(`${warnedUser}, quatrième avertissement profite d'un kick (raison: ${reason})`);
    warnedUser.kick(reason);
  } else if (this.client.warns.get(`${warnedUser.id}`, "warnings") == 5) {
    message.channel.send(`${warnedUser}, cinquième avertissement comme je te l'avait dit au cinquième warn j'allais te bannir donc au revoir`);
    warnedUser.ban(reason);
    userWarnings -= warnToDel;
  }
} catch (e) {
  console.log(e);
}
