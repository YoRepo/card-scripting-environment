--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Aqua Armor Ninja  (ID: 96427353)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 4
-- ATK 800 | DEF 1600
-- Setcode: 0x2b
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent's monster declares a direct attack, if you have another "Ninja" monster in your
-- Graveyard: You can banish this card from your Graveyard to target the attacking monster; negate that
-- attack.
--[[ __CARD_HEADER_END__ ]]

--機甲忍者アクア
function c96427353.initial_effect(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96427353,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c96427353.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c96427353.target)
	e1:SetOperation(c96427353.operation)
	c:RegisterEffect(e1)
end
function c96427353.cfilter(c)
	return c:IsSetCard(0x2b) and c:IsType(TYPE_MONSTER)
end
function c96427353.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==nil
		and Duel.IsExistingMatchingCard(c96427353.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler())
end
function c96427353.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c96427353.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
