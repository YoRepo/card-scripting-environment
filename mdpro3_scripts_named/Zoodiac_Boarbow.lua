--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Zoodiac Boarbow  (ID: 74393852)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Rank: 4
-- ATK ? | DEF ?
-- Setcode: 0xf1
-- Scope: OCG / TCG
--
-- Effect Text:
-- 5 Level 4 monsters
-- Once per turn, you can also Xyz Summon "Zoodiac Boarbow" by using 1 "Zoodiac" monster you control
-- with a different name as material.
-- (Transfer its materials to this card.)
-- Gains ATK/DEF equal to the ATK/DEF of all "Zoodiac" monsters attached to it as material.
-- This card can attack directly.
-- When this card inflicts battle damage to your opponent while it has 12 or more materials: You can
-- send as many cards as possible from your opponent's hand and field to the GY, then change this card
-- to Defense Position.
--[[ __CARD_HEADER_END__ ]]

--十二獣ワイルドボウ
function c74393852.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,5,c74393852.ovfilter,aux.Stringid(74393852,0),5,c74393852.xyzop)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c74393852.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c74393852.defval)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(74393852,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetCondition(c74393852.condition)
	e3:SetTarget(c74393852.target)
	e3:SetOperation(c74393852.operation)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e4)
end
function c74393852.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf1) and not c:IsCode(74393852)
end
function c74393852.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,74393852)==0 end
	Duel.RegisterFlagEffect(tp,74393852,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c74393852.atkfilter(c)
	return c:IsSetCard(0xf1) and c:GetAttack()>=0
end
function c74393852.atkval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c74393852.atkfilter,nil)
	return g:GetSum(Card.GetAttack)
end
function c74393852.deffilter(c)
	return c:IsSetCard(0xf1) and c:GetDefense()>=0
end
function c74393852.defval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c74393852.deffilter,nil)
	return g:GetSum(Card.GetDefense)
end
function c74393852.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetOverlayCount()>=12
end
function c74393852.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_ONFIELD)
	if chk==0 then return g:GetCount()>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c74393852.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_ONFIELD)
	Duel.SendtoGrave(g,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	if og:GetCount()>0 then
		Duel.BreakEffect()
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		end
	end
end
