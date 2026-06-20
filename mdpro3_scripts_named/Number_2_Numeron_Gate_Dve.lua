--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: No.2 源数之门-贰  (ID: 42230449)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank 1
-- ATK 1000 | DEF 100
-- Setcode: 290062408
--
-- Effect Text:
-- 1星怪兽×3
-- ①：这张卡不会被战斗破坏。
-- ②：这张卡和对方怪兽进行战斗的伤害步骤结束时，把这张卡1个超量素材取除才能发动。自己场上的全部「源数」怪兽的攻击力直到回合结束时变成2倍。
--[[ __CARD_HEADER_END__ ]]

--No.2 ゲート・オブ・ヌメロン－ドゥヴェー
function c42230449.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(42230449,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCost(c42230449.atkcost)
	e2:SetCondition(c42230449.atkcon)
	e2:SetTarget(c42230449.atktg)
	e2:SetOperation(c42230449.atkop)
	c:RegisterEffect(e2)
end
aux.xyz_number[42230449]=2
function c42230449.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c42230449.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c42230449.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x14a)
end
function c42230449.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42230449.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c42230449.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c42230449.atkfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
