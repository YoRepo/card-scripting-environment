--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Arcana Force I - The Magician  (ID: 8396952)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1100 | DEF 1100
-- Setcode: 0x5
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Summoned: Toss a coin.
-- ● Heads: Each time a Spell Card is activated, this card's ATK becomes double its original ATK when
-- that card resolves, until the end of that turn.
-- ● Tails: Each time a Spell Card is activated, your opponent gains 500 LP when that card resolves.
--[[ __CARD_HEADER_END__ ]]

--アルカナフォースⅠ－THE MAGICIAN
function c8396952.initial_effect(c)
	--coin
	aux.EnableArcanaCoin(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP_SUMMON_SUCCESS,EVENT_SPSUMMON_SUCCESS)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.ArcanaCondition)
	e1:SetOperation(c8396952.speop)
	c:RegisterEffect(e1)
end
function c8396952.speop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsActiveType(TYPE_SPELL) or not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local val=c:GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)
	if val==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	else
		Duel.Recover(1-tp,500,REASON_EFFECT)
	end
end
