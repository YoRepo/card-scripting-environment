--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Ryu Kokki  (ID: 57281778)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 6
-- ATK 2400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the end of the Damage Step, if this card battled a Warrior or Spellcaster monster: Destroy that
-- monster.
--[[ __CARD_HEADER_END__ ]]

--龍骨鬼
function c57281778.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57281778,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c57281778.descon)
	e1:SetTarget(c57281778.destg)
	e1:SetOperation(c57281778.desop)
	c:RegisterEffect(e1)
end
function c57281778.descon(e,tp,eg,ep,ev,re,r,rp)
	local t=e:GetHandler():GetBattleTarget()
	e:SetLabelObject(t)
	return aux.dsercon(e,tp,eg,ep,ev,re,r,rp) and t and t:IsRace(RACE_SPELLCASTER+RACE_WARRIOR) and t:IsRelateToBattle()
end
function c57281778.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetLabelObject(),1,0,0)
end
function c57281778.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
