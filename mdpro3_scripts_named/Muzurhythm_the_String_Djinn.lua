--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Muzurhythm the String Djinn  (ID: 26563200)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Fiend
-- Rank: 3
-- ATK 1500 | DEF 1000
-- Setcode: 0x6d
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 3 monsters
-- When a "Djinn" Xyz Monster you control is attacking an opponent's monster, during the Damage Step:
-- You can detach 1 Xyz Material from this card; the attacking monster's ATK is doubled until the End
-- Phase.
-- You can only use this effect of "Muzurhythm the String Djinn" once per turn.
--[[ __CARD_HEADER_END__ ]]

--弦魔人ムズムズリズム
function c26563200.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26563200,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,26563200)
	e1:SetCondition(c26563200.atkcon)
	e1:SetCost(c26563200.atkcost)
	e1:SetOperation(c26563200.atkop)
	c:RegisterEffect(e1)
end
function c26563200.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:IsRelateToBattle() and tc:IsSetCard(0x6d) and tc:IsType(TYPE_XYZ) and Duel.GetAttackTarget()~=nil
end
function c26563200.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c26563200.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
	end
end
