--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Phantasm Emperor Trilojig  (ID: 95463814)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level: 10
-- ATK 4000 | DEF 4000
-- Setcode: 0x144
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 10 monsters
-- If this card is Special Summoned, or if another monster is Special Summoned from the GY to your
-- field while you control this monster: You can target 1 face-up monster your opponent controls;
-- inflict damage to your opponent equal to half its original ATK.
-- You can only use this effect of "Phantasm Emperor Trilojig" once per turn.
--[[ __CARD_HEADER_END__ ]]

--幻魔帝トリロジーグ
function c95463814.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsLevel,10),3,true)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95463814,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,95463814)
	e1:SetTarget(c95463814.target)
	e1:SetOperation(c95463814.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c95463814.contition2)
	c:RegisterEffect(e2)
end
function c95463814.filter(c)
	return c:IsFaceup() and c:GetBaseAttack()>0
end
function c95463814.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c95463814.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c95463814.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c95463814.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,math.floor(g:GetFirst():GetBaseAttack()/2))
end
function c95463814.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,math.floor(tc:GetBaseAttack()/2),REASON_EFFECT)
	end
end
function c95463814.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c95463814.contition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not eg:IsContains(c) and eg:IsExists(c95463814.cfilter,1,nil,tp)
end
