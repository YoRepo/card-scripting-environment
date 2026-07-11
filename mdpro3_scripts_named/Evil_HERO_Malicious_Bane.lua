--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Evil HERO Malicious Bane  (ID: 86165817)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 3000 | DEF 3000
-- Setcode: 0x6008
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Evil HERO" monster + 1 Level 5 or higher monster
-- Must be Special Summoned with "Dark Fusion".
-- Cannot be destroyed by battle or card effects.
-- During your Main Phase: You can destroy all monsters your opponent controls with ATK less than or
-- equal to this card's, also this card gains 200 ATK for each monster destroyed this way, also you
-- cannot declare an attack for the rest of this turn, except with "HERO" monsters.
-- You can only use this effect of "Evil HERO Malicious Bane" once per turn.
--[[ __CARD_HEADER_END__ ]]

--E-HERO マリシャス・ベイン
function c86165817.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c86165817.matfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0x6008),true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.DarkFusionLimit)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,86165817)
	e2:SetTarget(c86165817.destg)
	e2:SetOperation(c86165817.desop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
end
c86165817.material_setcode=0x8
c86165817.dark_calling=true
function c86165817.matfilter(c)
	return c:IsLevelAbove(5) and c:IsFusionType(TYPE_MONSTER)
end
function c86165817.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk)
end
function c86165817.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c86165817.filter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack()) end
	local g=Duel.GetMatchingGroup(c86165817.filter,tp,0,LOCATION_MZONE,nil,c:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c86165817.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetMatchingGroup(c86165817.filter,tp,0,LOCATION_MZONE,nil,c:GetAttack())
		local ct=Duel.Destroy(g,REASON_EFFECT)
		if ct>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			e1:SetValue(ct*200)
			c:RegisterEffect(e1)
		end
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c86165817.atktg)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c86165817.atktg(e,c)
	return not c:IsSetCard(0x8)
end
