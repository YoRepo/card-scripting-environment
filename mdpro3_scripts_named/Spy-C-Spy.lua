--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Spy-C-Spy  (ID: 21088856)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 3
-- ATK 1200 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal Summoned: Look at 1 random card in your opponent's Extra Deck, and if it has
-- 2000 or more ATK, this card gains 1000 ATK.
-- If it has less than 2000 ATK, you gain LP equal to that monster's ATK.
--[[ __CARD_HEADER_END__ ]]

--華麗なる密偵－C
function c21088856.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21088856,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c21088856.operation)
	c:RegisterEffect(e1)
end
function c21088856.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_EXTRA,0)
	if g:GetCount()==0 then return end
	Duel.ShuffleExtra(1-tp)
	local tc=g:RandomSelect(tp,1):GetFirst()
	Duel.ConfirmCards(tp,tc)
	local atk=tc:GetAttack()
	if atk<0 then atk=0 end
	if atk>=2000 then
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	else
		Duel.Recover(tp,atk,REASON_EFFECT)
	end
	Duel.ShuffleExtra(1-tp)
end
