--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Bujingi Crane  (ID: 68601507)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level: 4
-- ATK 1600 | DEF 300
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- During damage calculation (in either player's turn), if a Beast-Warrior-Type "Bujin" monster you
-- control battles an opponent's monster: You can send this card from your hand to the Graveyard; the
-- ATK of your monster becomes double its original ATK, during that damage calculation only.
--[[ __CARD_HEADER_END__ ]]

--武神器－ハバキリ
function c68601507.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68601507,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c68601507.atkcon)
	e1:SetCost(c68601507.atkcost)
	e1:SetOperation(c68601507.atkop)
	c:RegisterEffect(e1)
end
function c68601507.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttackTarget()
	if not c then return false end
	if c:IsControler(1-tp) then c=Duel.GetAttacker() end
	e:SetLabelObject(c)
	return c and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsRelateToBattle()
end
function c68601507.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c68601507.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	if c:IsFaceup() and c:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(c:GetBaseAttack()*2)
		c:RegisterEffect(e1)
	end
end
