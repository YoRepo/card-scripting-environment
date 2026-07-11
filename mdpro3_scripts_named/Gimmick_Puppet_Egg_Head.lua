--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Gimmick Puppet Egg Head  (ID: 20032555)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1600 | DEF 1200
-- Setcode: 0x1083
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can discard 1 "Gimmick Puppet" monster, then activate 1 of these effects;
-- ● Inflict 800 damage to your opponent.
-- ● This card's Level becomes 8 until the End Phase.
-- You can only use this effect of "Gimmick Puppet Egg Head" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－ボム・エッグ
function c20032555.initial_effect(c)
	--effects
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20032555,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,20032555)
	e1:SetTarget(c20032555.efftg)
	e1:SetOperation(c20032555.effop)
	c:RegisterEffect(e1)
end
function c20032555.cfilter(c)
	return c:IsSetCard(0x1083) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c20032555.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20032555.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c20032555.cfilter,1,1,REASON_COST+REASON_DISCARD)
	local opt=0
	if e:GetHandler():IsLevel(8) then
		opt=Duel.SelectOption(tp,aux.Stringid(20032555,1))
	else
		opt=Duel.SelectOption(tp,aux.Stringid(20032555,1),aux.Stringid(20032555,2))
	end
	e:SetLabel(opt)
	if opt==0 then
		e:SetCategory(CATEGORY_DAMAGE)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
	else
		e:SetCategory(0)
	end
end
function c20032555.effop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Damage(1-tp,800,REASON_EFFECT)
	else
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(8)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e:GetHandler():RegisterEffect(e1)
	end
end
