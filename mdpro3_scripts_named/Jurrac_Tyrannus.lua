--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Jurrac Tyrannus  (ID: 62701967)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 7
-- ATK 2500 | DEF 1400
-- Setcode: 0x22
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 1 Dinosaur monster; this card gains 500 ATK.
-- If this card destroys an opponent's monster by battle and sends it to the GY: This card gains 300
-- ATK.
--[[ __CARD_HEADER_END__ ]]

--ジュラック・ティラヌス
function c62701967.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62701967,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetLabel(500)
	e1:SetCost(c62701967.atkcost)
	e1:SetOperation(c62701967.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(62701967,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetLabel(300)
	e2:SetCondition(c62701967.atkcon)
	e2:SetOperation(c62701967.operation)
	c:RegisterEffect(e2)
end
function c62701967.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,e:GetHandler(),RACE_DINOSAUR) end
	local sg=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,e:GetHandler(),RACE_DINOSAUR)
	Duel.Release(sg,REASON_COST)
end
function c62701967.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c62701967.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsFaceup() and c:IsRelateToBattle()
		and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE) and bc:IsType(TYPE_MONSTER)
end
